<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Djoudi\LaravelH5p\Events\H5pEvent;
use H5PCore;
use H5peditor;

class InteractiveEditorController extends Controller
{
    public function settings(Request $request, $id = null)
    {
        try {
            $this->ensureH5PClassesLoaded();

            $h5p = App::make('LaravelH5p');
            $core = $h5p::$core;
            $editor = $h5p::$h5peditor;

            // Get Editor Configuration
            if ($id) {
                $content = $h5p->get_content($id);
                $settings = $h5p::get_editor($content);
            } else {
                $settings = $h5p::get_editor();
            }

            // BRIDGING: Override URLs to point to our API
            // The frontend needs to know where to send AJAX requests.
            // We point it to OUR controller, not the plugin's default routes.
            $settings['editor']['ajaxPath'] = url('api/interactive/editor/ajax'); 
            $settings['editor']['libraryUrl'] = url('assets/vendor/h5p-editor'); // Keep this as is for assets
            $settings['editor']['url'] = url('storage/h5p'); // Storage URL

            // Fix asset URLs to be absolute if they aren't
            // (The plugin sometimes returns relative paths which breaks in Angular)
            
            return response()->json($settings);
        } catch (\Throwable $e) {
            \Log::error("H5P Editor Settings Error: " . $e->getMessage());
            return response()->json([
                'error' => 'H5P Editor Settings Error',
                'message' => $e->getMessage(),
                'file' => $e->getFile(),
                'line' => $e->getLine()
            ], 500);
        }
    }

    public function ajax(Request $request)
    {
        try {
            $this->ensureH5PClassesLoaded();

            $h5p = App::make('LaravelH5p');
            $editor = $h5p::$h5peditor;

            // The logic in H5PEditorAjax runs 'echo' commands.
            // We must capture this output.
            ob_start();
            
            // The action is passed as a query param or post param 'action'
            // But H5PEditorAjax usually expects arguments.
            // We need to map the request to the action.
            
            // Based on AjaxController from the plugin:
            // $editor->ajax->action(H5PEditorEndpoints::SINGLE_LIBRARY, ...)
            
            // HOWEVER, the plugin's 'action' method automatically reads $_REQUEST['action'] / $_POST['action']
            // inside the library if arguments aren't strictly passed for some things.
            // Let's see how the plugin's AjaxController does it.
            // It separates methods: libraries, singleLibrary, etc.
            // But the frontend H5P Editor usually sends a generic AJAX request with ?action=...
            
            // We will try to emulate the "hub" action which handles routing internally if possible,
            // OR we map specific actions.
            
            $action = $request->input('action');
            
            // For 'libraries'
            if (!$action) {
                 // Some endpoints might be deduced from the URL in the original plugin.
                 // But here we use a single point.
                 // Let's assume the editor.js sends 'action' in the body or query.
            }

            // HACK: The H5P classes rely extensively on $_POST and $_GET superglobals.
            // Since we are in Laravel, these are populated, but we must ensure they are correct.
            
            // We delegate to the repository which implements H5PEditorAjaxInterface
            // But the 'action' method on H5PEditorAjax uses `call_user_func`.
            
            // Let's duplicate the logic from the plugin's AjaxController but wrap it.

            switch ($action) {
                case 'libraries':
                    $machineName = $request->get('machineName');
                    if ($machineName) {
                        $editor->ajax->action(\H5PEditorEndpoints::SINGLE_LIBRARY, $machineName, 
                            $request->get('majorVersion'), 
                            $request->get('minorVersion'), 
                            $h5p->get_language(), 
                            '', 
                            $h5p->get_h5plibrary_url('', true), 
                            $request->get('defaultLanguage'));
                    } else {
                        $editor->ajax->action(\H5PEditorEndpoints::LIBRARIES);
                    }
                    break;
                
                case 'single-library':
                    $editor->ajax->action(\H5PEditorEndpoints::SINGLE_LIBRARY, $request->get('_token'));
                    break;
                
                case 'content-type-cache':
                    $editor->ajax->action(\H5PEditorEndpoints::CONTENT_TYPE_CACHE, $request->get('_token'));
                    break;

                case 'library-install':
                    $editor->ajax->action(\H5PEditorEndpoints::LIBRARY_INSTALL, $request->get('_token'), $request->get('id'));
                    break;

                case 'library-upload':
                    if ($request->hasFile('h5p')) {
                        $filePath = $request->file('h5p')->getPathName();
                        $editor->ajax->action(\H5PEditorEndpoints::LIBRARY_UPLOAD, $request->get('_token'), $filePath, $request->get('contentId'));
                    } else {
                        throw new \Exception("No file uploaded for library-upload");
                    }
                    break;

                default:
                    // Fallback for strict actions defined in H5PEditorEndpoints
                    // If the action name matches the endpoint constant
                    // We might need to handle specific args.
                    break;
            }
        } catch (\Throwable $e) {
            // Log error
            \Log::error("H5P Bridge Error: " . $e->getMessage());
            // Clear buffer if exception
            ob_end_clean(); 
            return response()->json(['error' => $e->getMessage()], 500);
        }

        $output = ob_get_clean();
        
        // If output is json, return it as json response
        $json = json_decode($output);
        if ($json) {
            return response()->json($json);
        }
        
        return response($output);
    }
    
    /**
     * Store content 
     */
    public function store(Request $request)
    {
        try {
            $this->ensureH5PClassesLoaded();

            $h5p = App::make('LaravelH5p');
            $core = $h5p::$core;
            $editor = $h5p::$h5peditor;

            $this->validate($request, [
                'title' => 'required',
                'library' => 'required',
                'params' => 'required'
            ]);

            $content = [
                'disable' => H5PCore::DISABLE_NONE,
                'user_id' => Auth::id(),
                'title' => $request->get('title'),
                'embed_type' => 'div',
                'filtered' => '',
                'slug' => config('laravel-h5p.slug'), // Ensure config is available or use default
                'library' => $core->libraryFromString($request->get('library')),
                'params' => $request->get('params'), // JSON string
            ];
            
            // H5P core expects parameters to be string.
            
            $content['id'] = $core->saveContent($content);
            
            // Verify library existence
            $content['library']['libraryId'] = $core->h5pF->getLibraryId($content['library']['machineName'], $content['library']['majorVersion'], $content['library']['minorVersion']);

            // Process parameters (move images etc)
            // $editor->processParameters($content['id'], $content['library'], json_decode($content['params']), null, null);
            // Note: processParameters expects the params explicitly.
            
            $editor->processParameters(
                $content['id'], 
                $content['library'], 
                json_decode($content['params']), 
                null, 
                null
            );

            return response()->json(['id' => $content['id']]);
        } catch (\Throwable $e) {
            \Log::error("H5P Store Error: " . $e->getMessage());
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    /**
     * Emergency method to load H5P classes if Composer failed to autoload them.
     */
    private function ensureH5PClassesLoaded()
    {
        if (!class_exists('H5PCore')) {
            $path = base_path('vendor/h5p/h5p-core/h5p.classes.php');
            if (file_exists($path)) {
                require_once $path;
            }
        }
        if (!class_exists('H5peditor')) {
            $editorPath = base_path('vendor/h5p/h5p-editor/h5peditor.class.php');
            $ajaxPath = base_path('vendor/h5p/h5p-editor/h5peditor-ajax.class.php');
            $ajaxInterfacePath = base_path('vendor/h5p/h5p-editor/h5peditor-ajax.interface.php');
            $fileStoragePath = base_path('vendor/h5p/h5p-editor/h5peditor-storage.interface.php');
            
            if (file_exists($fileStoragePath)) require_once $fileStoragePath;
            if (file_exists($ajaxInterfacePath)) require_once $ajaxInterfacePath;
            if (file_exists($ajaxPath)) require_once $ajaxPath;
            if (file_exists($editorPath)) require_once $editorPath;
        }
    }
}

