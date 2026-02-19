<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Djoudi\LaravelH5p\Eloquents\H5pContent;
use Djoudi\LaravelH5p\Eloquents\H5pLibrary;

class InteractiveController extends Controller
{
    /**
     * List all H5P content for the Admin Module.
     */
    public function index(Request $request)
    {
        // Simple pagination for Admin List
        $query = H5pContent::select('h5p_contents.*', 'users.name as created_by_name', 'h5p_libraries.title as library_title')
            ->join('h5p_libraries', 'h5p_contents.library_id', '=', 'h5p_libraries.id')
            ->leftJoin('users', 'h5p_contents.user_id', '=', 'users.id')
            ->orderBy('h5p_contents.id', 'desc');

        if ($request->has('search')) {
            $search = $request->input('search');
            $query->where('h5p_contents.title', 'like', "%{$search}%");
        }

        return response()->json($query->paginate(20));
    }

    /**
     * Get a specific H5P content details.
     */
    public function show($id)
    {
        $content = H5pContent::find($id);
        if (!$content) {
            return response()->json(['message' => 'Content not found'], 404);
        }
        return response()->json($content);
    }

    /**
     * List installed libraries.
     */
    public function libraries()
    {
        $libraries = H5pLibrary::where('runnable', 1)
            ->select('id', 'name', 'title', 'major_version', 'minor_version', 'patch_version')
            ->orderBy('title')
            ->get();
            
        return response()->json($libraries);
    }
}
