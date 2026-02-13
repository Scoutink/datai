<?php
/**
 * DATAI Emergency Cache Recovery Script
 * Purpose: Clear all Laravel caches when Artisan is unreachable due to 500 errors.
 * 
 * INSTRUCTIONS:
 * 1. Upload this file to your public_html (webroot).
 * 2. Access it via browser: your-domain.com/force-clear.php
 * 3. Delete immediately after use.
 */

define('LARAVEL_START', microtime(true));

// 1. Locate the vendor folder and bootstrap
$paths = [
    __DIR__ . '/../vendor/autoload.php',
    __DIR__ . '/vendor/autoload.php',
    '/var/www/vhosts/corprorate.com/datai.corprorate.com/vendor/autoload.php'
];

$autoload = null;
foreach ($paths as $path) {
    if (file_exists($path)) {
        $autoload = $path;
        break;
    }
}

if (!$autoload) {
    die("Error: Could not find vendor/autoload.php. Please check paths.");
}

require $autoload;

// 2. Initialize Laravel App
$appPaths = [
    __DIR__ . '/../bootstrap/app.php',
    __DIR__ . '/bootstrap/app.php',
    '/var/www/vhosts/corprorate.com/datai.corprorate.com/bootstrap/app.php'
];

$appFile = null;
foreach ($appPaths as $path) {
    if (file_exists($path)) {
        $appFile = $path;
        break;
    }
}

if (!$appFile) {
    die("Error: Could not find bootstrap/app.php.");
}

$app = require_once $appFile;
$kernel = $app->make(Illuminate\Contracts\Http\Kernel::class);

echo "<h1>DATAI Forensic Recovery</h1>";
echo "<p>Starting deep cache purge...</p>";

try {
    // Clear via Artisan Facade
    echo "<li>Clearing Config cache... ";
    \Illuminate\Support\Facades\Artisan::call('config:clear');
    echo "[OK]</li>";

    echo "<li>Clearing Route cache... ";
    \Illuminate\Support\Facades\Artisan::call('route:clear');
    echo "[OK]</li>";

    echo "<li>Clearing View cache... ";
    \Illuminate\Support\Facades\Artisan::call('view:clear');
    echo "[OK]</li>";

    echo "<li>Clearing Compiled classes... ";
    \Illuminate\Support\Facades\Artisan::call('clear-compiled');
    echo "[OK]</li>";

    echo "<li>Optimizing (Re-caching)... ";
    \Illuminate\Support\Facades\Artisan::call('optimize');
    echo "[OK]</li>";

    echo "<h2>SUCCESS: All caches cleared.</h2>";
    echo "<p>Please hard-refresh your browser (Ctrl+F5).</p>";
    echo "<p><strong>IMPORTANT: Delete this file (force-clear.php) from your server NOW.</strong></p>";

} catch (\Exception $e) {
    echo "<h2>ERROR during purge: " . $e->getMessage() . "</h2>";
    echo "<p>Manual cleanup suggestion:</p>";
    echo "<code>rm -rf storage/framework/cache/data/*</code><br>";
    echo "<code>rm -rf storage/framework/views/*.php</code><br>";
    echo "<code>rm -rf bootstrap/cache/*.php</code>";
}
