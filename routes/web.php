<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AngularController;
use App\Http\Controllers\BoardsViewController;
use App\Http\Controllers\WorkspaceSandboxController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

// Route::get('/', function () {
//     return view('angular');
// });

// Simple test route - NO AUTH (for verification)
Route::get('/test', function () {
    return view('test');
})->name('test');

// Boards standalone routes (bypass Angular SPA)
Route::prefix('boards')->middleware(['boards', 'boardsAuth:BOARDS_VIEW_BOARDS'])->group(function () {
    Route::get('/', [BoardsViewController::class, 'index'])->name('boards.index');
    Route::get('/{id}', [BoardsViewController::class, 'view'])->name('boards.view');
});



// Workspace sandbox (no-build mockup for backend validation)
Route::get('/workspace-sandbox', [WorkspaceSandboxController::class, 'index']);
Route::get('/workspace-sandbox/roots', [WorkspaceSandboxController::class, 'roots']);
Route::get('/workspace-sandbox/tree/{id}', [WorkspaceSandboxController::class, 'tree']);
Route::post('/workspace-sandbox/roots', [WorkspaceSandboxController::class, 'createRoot']);
Route::post('/workspace-sandbox/nodes', [WorkspaceSandboxController::class, 'addNode']);
Route::post('/workspace-sandbox/nodes/{id}/rename', [WorkspaceSandboxController::class, 'renameNode']);
Route::post('/workspace-sandbox/nodes/{id}/move', [WorkspaceSandboxController::class, 'moveNode']);
Route::post('/workspace-sandbox/nodes/{id}/delete', [WorkspaceSandboxController::class, 'deleteNode']);

// Angular SPA catch-all (excludes api, install, update, boards, and test)
Route::any('/{any}', [AngularController::class, 'index'])
    ->where('any', '^(?!api).*$')
    ->where('any', '^(?!install|update|boards|test).*$');
    // ->where('any', '^(?!update).*$');
// Route::get('/category', [CategoryController::class, 'index']);
// Route::get('/category',function(){
// });

