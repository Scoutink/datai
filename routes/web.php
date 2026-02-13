<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AngularController;

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


// Angular SPA catch-all (excludes api, install, update, and test)
Route::any('/{any}', [AngularController::class, 'index'])
    ->where('any', '^(?!api).*$')
    ->where('any', '^(?!install|update|test).*$');
    // ->where('any', '^(?!update).*$');
// Route::get('/category', [CategoryController::class, 'index']);
// Route::get('/category',function(){
// });

