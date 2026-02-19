<?php
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\App;

Route::get('/h5p-test', function () {
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);

    echo "<h1>H5P Deep Probe (Controller Simulation)</h1>";

    try {
        // 1. Service Provider Check
        echo "<b>1. Resolving App::make('LaravelH5p')...</b> ";
        $h5p = App::make('LaravelH5p');
        echo "<span style='color:green'>SUCCESS</span><br>";

        // 2. Class Check - H5peditor
        echo "<b>2. Checking H5peditor Class...</b> ";
        if (class_exists('H5peditor')) {
             echo "<span style='color:green'>AUTOLOADED</span><br>";
        } else {
             echo "<span style='color:orange'>MISSING (Attempting Manual Load)</span><br>";
             
             // Manual Load Routine
             $base = base_path('vendor/h5p/h5p-editor');
             $files = [
                'h5peditor-storage.interface.php',
                'h5peditor-ajax.interface.php',
                'h5peditor.class.php',
                'h5peditor-ajax.class.php',
             ];
             
             foreach($files as $file) {
                 $path = $base . '/' . $file;
                 if (file_exists($path)) {
                     require_once $path;
                     echo "&nbsp;&nbsp;-> Loaded: $file<br>";
                 } else {
                     echo "&nbsp;&nbsp;-> <span style='color:red'>MISSING: $file</span><br>";
                 }
             }
             
             if (class_exists('H5peditor')) {
                 echo "-> H5peditor Class: <span style='color:green'>NOW AVAILABLE</span><br>";
             } else {
                 throw new Exception("H5peditor class could not be loaded even after manual require.");
             }
        }

        // 3. Run get_editor()
        echo "<b>3. Executing \$h5p::get_editor()...</b><br>";
        
        // We simulate the exact call made in the controller
        // Note: get_editor() might return null or crash
        $settings = $h5p::get_editor(); 
        
        if ($settings) {
            echo "<span style='color:green'>SUCCESS (Settings Retrieved)</span><br>";
            echo "<pre>" . print_r(array_keys($settings), true) . "</pre>";
        } else {
            echo "<span style='color:red'>FAILED (Returned Null/False)</span><br>";
        }

    } catch (\Throwable $e) {
        echo "<hr><h2 style='color:red'>CRASH DETECTED</h2>";
        echo "<b>Type:</b> " . get_class($e) . "<br>";
        echo "<b>Message:</b> " . $e->getMessage() . "<br>";
        echo "<b>File:</b> " . $e->getFile() . " (Line " . $e->getLine() . ")<br>";
        echo "<h3>Stack Trace:</h3>";
        echo "<pre>" . $e->getTraceAsString() . "</pre>";
    }
});
