<?php
use Illuminate\Support\Facades\Route;

Route::get('/h5p-controller-test', function () {
    ini_set('display_errors', 1);
    error_reporting(E_ALL);

    echo "<h1>H5P Controller Direct Test</h1>";

    try {
        echo "<b>Testing InteractiveEditorController->settings()...</b><br>";
        
        $controller = new \App\Http\Controllers\Api\InteractiveEditorController();
        $request = new \Illuminate\Http\Request();
        
        $response = $controller->settings($request);
        
        echo "<span style='color:green'>SUCCESS</span><br>";
        echo "<b>Status:</b> " . $response->getStatusCode() . "<br>";
        
        $content = $response->getContent();
        $data = json_decode($content, true);
        
        if (isset($data['error'])) {
            echo "<hr><span style='color:red'>CONTROLLER ERROR:</span><br>";
            echo "<pre>" . print_r($data, true) . "</pre>";
        } else {
            echo "<b>Settings retrieved successfully</b><br>";
            echo "<pre>" . print_r(array_keys($data), true) . "</pre>";
        }

    } catch (\Throwable $e) {
        echo "<hr><h2 style='color:red'>CONTROLLER CRASHED</h2>";
        echo "<b>Error:</b> " . $e->getMessage() . "<br>";
        echo "<b>File:</b> " . $e->getFile() . " (Line " . $e->getLine() . ")<br>";
        echo "<pre>" . $e->getTraceAsString() . "</pre>";
    }
});
