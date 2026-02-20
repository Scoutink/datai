<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UpdateController;

Route::get('/', [UpdateController::class, 'index']);
Route::post('run', [UpdateController::class, 'update']);
Route::post('tasks/migrate', [UpdateController::class, 'runMigrationsOnly']);
Route::post('tasks/clear-cache', [UpdateController::class, 'clearRuntimeCaches']);
