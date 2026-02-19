<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

echo "<h1>H5P Forensic Debugger</h1>";

$vendorPath = realpath(__DIR__ . '/../vendor');
echo "<b>1. Vendor Path:</b> " . $vendorPath . "<br>";

// Check if H5P Core files exist in vendor
$h5pCorePath = $vendorPath . '/h5p/h5p-core/h5p.classes.php';
echo "<b>2. H5P Core File Check:</b> " . $h5pCorePath . " -> ";
if (file_exists($h5pCorePath)) {
    echo "<span style='color:green'>FOUND</span><br>";
} else {
    echo "<span style='color:red'>MISSING</span> (Critical Failure)<br>";
}

// Check if the Laravel Package exists in vendor (Symlink check)
$pkgPath = $vendorPath . '/djoudi/laravel-h5p/src/LaravelH5p/LaravelH5p.php';
echo "<b>3. Laravel H5P Package Check:</b> " . $pkgPath . " -> ";
if (file_exists($pkgPath)) {
    echo "<span style='color:green'>FOUND</span><br>";
} else {
    echo "<span style='color:red'>MISSING</span> (Broken Symlink/Empty Folder)<br>";
}

echo "<b>4. Testing Autoloading:</b><br>";
if (file_exists(__DIR__ . '/../vendor/autoload.php')) {
    require __DIR__ . '/../vendor/autoload.php';
    echo "Autoload.php included.<br>";
    
    // Check H5PCore Class Load
    if (class_exists('H5PCore')) {
        echo "Class 'H5PCore': <span style='color:green'>LOADED</span><br>";
    } else {
        echo "Class 'H5PCore': <span style='color:red'>NOT LOADED</span><br>";
        
        // Attempt manual inclusion to see if it fixes it
        if (file_exists($h5pCorePath)) {
            require_once $h5pCorePath;
             if (class_exists('H5PCore')) {
                echo "Manual include works? <span style='color:green'>YES (Fixable via Controller)</span><br>";
            } else {
                 echo "Manual include failed.<br>";
            }
        }
    }
} else {
    echo "vendor/autoload.php MISSING!<br>";
}