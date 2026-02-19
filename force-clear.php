<?php
/**
 * DATAI Emergency Cache Clear script
 * Upload this to your web root (where index.php is) and visit it in your browser.
 */

define('LARAVEL_START', microtime(true));

// Load Laravel
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);

echo "<h1>DATAI System Recovery</h1>";

try {
    echo "Attempting to clear caches via Artisan...<br>";
    
    // We use shell_exec in case the app can't boot at all
    $output = shell_exec('php artisan optimize:clear 2>&1');
    echo "<pre>$output</pre>";

    echo "Manually cleaning bootstrap/cache/...<br>";
    $cacheFiles = [
        __DIR__ . '/bootstrap/cache/config.php',
        __DIR__ . '/bootstrap/cache/routes-v7.php',
        __DIR__ . '/bootstrap/cache/services.php',
        __DIR__ . '/bootstrap/cache/packages.php',
    ];

    foreach ($cacheFiles as $file) {
        if (file_exists($file)) {
            if (unlink($file)) {
                echo "Deleted: $file <br>";
            } else {
                echo "Failed to delete: $file <br>";
            }
        } else {
            echo "Not found (already clean): $file <br>";
        }
    }

    echo "<h3>Success! Please refresh your main site.</h3>";
} catch (Exception $e) {
    echo "<h3>Error: " . $e->getMessage() . "</h3>";
    echo "Ensure you uploaded this file to the root directory.";
}
