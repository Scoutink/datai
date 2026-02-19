<?php
/**
 * DATAI Updater Utility (v5 - Editable Path Fix)
 * ----------------------------------------------
 * Upload this file to your server's public/ folder.
 * Access it at: https://your-domain.com/_datai_updater.php
 *
 * IMPORTANT: Delete this file from the server after use!
 */

// ── Configuration ──
$ACCESS_KEY = 'datai2026';
set_time_limit(900); // 15 minutes
ini_set('memory_limit', '1024M');

// ── Bootstrap ──
$basePath = realpath(__DIR__ . '/..');
$authorized = (($_GET['key'] ?? '') === $ACCESS_KEY || ($_POST['key'] ?? '') === $ACCESS_KEY);

// ── Environment Setup ──
putenv('COMPOSER_HOME=' . $basePath . '/.composer');
putenv('COMPOSER_CACHE_DIR=' . $basePath . '/.composer/cache');

// ── Smart PHP Path Detection ──
function getPhpCliPath() {
    $current = PHP_BINARY;
    // Try to detect common paths if we suspect we are in FPM/CGI
    if (strpos($current, 'fpm') !== false || strpos($current, 'cgi') !== false) {
        $candidate = str_replace('sbin/php-fpm', 'bin/php', $current);
        if (file_exists($candidate) && is_executable($candidate)) return $candidate;
        
        $pleskVersions = ['8.4', '8.3', '8.2', '8.1', '8.0'];
        foreach ($pleskVersions as $v) {
            $path = "/opt/plesk/php/$v/bin/php";
            if (file_exists($path) && is_executable($path)) return $path;
        }
        
        $globalPaths = ['/usr/bin/php', '/usr/local/bin/php', 'php'];
        foreach ($globalPaths as $path) {
            if ($path === 'php') return 'php';
            if (file_exists($path) && is_executable($path)) return $path;
        }
    }
    return $current;
}

// ── Helper Function ──
function runCommand($cmd, $cwd) {
    if (!function_exists('proc_open')) {
        return "Error: proc_open() is disabled. Cannot run commands.";
    }
    
    $descriptorspec = [
        0 => ["pipe", "r"], // stdin
        1 => ["pipe", "w"], // stdout
        2 => ["pipe", "w"], // stderr
    ];

    $process = proc_open($cmd . ' 2>&1', $descriptorspec, $pipes, $cwd);

    if (is_resource($process)) {
        $output = stream_get_contents($pipes[1]);
        fclose($pipes[0]);
        fclose($pipes[1]);
        fclose($pipes[2]);
        proc_close($process);
        return $output;
    }
    return "Error: Failed to start process.";
}

// ── Action Handling ──
$output = '';
$action = '';
$defaultPhp = getPhpCliPath(); 

if ($authorized && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    $customPhp = $_POST['custom_php'] ?? '';
    
    // User override takes precedence
    $phpBin = !empty($customPhp) ? $customPhp : $defaultPhp;
    
    // Pass this back to the view so it persists
    $defaultPhp = $phpBin;
    
    if ($action === 'composer_update') {
        $composerPath = $basePath . '/composer.phar';
        if (!file_exists($composerPath)) {
            $output .= "Downloading composer.phar...\n";
            try {
                $src = fopen('https://getcomposer.org/composer.phar', 'r');
                $dest = fopen($composerPath, 'w');
                stream_copy_to_stream($src, $dest);
                fclose($src);
                fclose($dest);
                $output .= "Composer downloaded successfully.\n\n";
            } catch (Exception $e) {
                $output .= "Error downloading composer: " . $e->getMessage() . "\n";
                $composerPath = 'composer'; 
            }
        }

        if ($composerPath === 'composer') {
            $cmd = "composer update --no-interaction --prefer-dist --optimize-autoloader";
        } else {
            $cmd = "\"$phpBin\" \"$composerPath\" update --no-interaction --prefer-dist --optimize-autoloader";
        }
        
        $output .= "Running Command:\n$cmd\n";
        $output .= "Using PHP Binary: $phpBin\n---------------------------------------\n";
        $output .= runCommand($cmd, $basePath);
        
        $output .= "\n\nRunning: artisan migrate --force\n";
        $output .= runCommand("\"$phpBin\" artisan migrate --force", $basePath);
        
        $output .= "\nRunning: artisan optimize\n";
        $output .= runCommand("\"$phpBin\" artisan optimize", $basePath);
        
        $output .= "\nRunning: artisan view:clear\n";
        $output .= runCommand("\"$phpBin\" artisan view:clear", $basePath);
    }
    
    if ($action === 'seed_permissions') {
        $output .= "Running: artisan db:seed --class=InteractiveRBACSeeder --force\n";
        $output .= "Using PHP Binary: $phpBin\n---------------------------------------\n";
        $output .= runCommand("\"$phpBin\" artisan db:seed --class=InteractiveRBACSeeder --force", $basePath);
        
        $output .= "\nRunning: artisan optimize (to refresh cache)\n";
        $output .= runCommand("\"$phpBin\" artisan optimize", $basePath);
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DATAI Updater v5</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #0f172a; color: #e2e8f0; min-height: 100vh; padding: 2rem; }
        .container { max-width: 900px; margin: 0 auto; }
        h1 { font-size: 1.5rem; margin-bottom: 0.5rem; color: #38bdf8; }
        .subtitle { color: #94a3b8; margin-bottom: 2rem; font-size: 0.875rem; }
        .warning { background: #7f1d1d; border: 1px solid #dc2626; border-radius: 8px; padding: 1rem; margin-bottom: 2rem; font-size: 0.875rem; }
        
        .login-box { background: #1e293b; border-radius: 12px; padding: 2rem; max-width: 400px; margin: 4rem auto; }
        .login-box input { width: 100%; padding: 0.75rem; border-radius: 6px; border: 1px solid #334155; background: #0f172a; color: #e2e8f0; margin: 0.5rem 0; font-size: 1rem; }
        
        .card { background: #1e293b; border-radius: 12px; padding: 1.5rem; margin-bottom: 1.5rem; }
        .btn { padding: 1rem 2rem; border: none; border-radius: 6px; font-size: 1rem; font-weight: bold; cursor: pointer; width: 100%; transition: background 0.2s; color:white; }
        .btn-green { background: #059669; }
        .btn-green:hover { background: #047857; }
        .btn-purple { background: #7c3aed; }
        .btn-purple:hover { background: #6d28d9; }
        
        .console { background: #000; border-radius: 8px; padding: 1rem; font-family: monospace; font-size: 0.85rem; color: #4ade80; white-space: pre-wrap; max-height: 600px; overflow-y: auto; border: 1px solid #333; }
        
        label { display: block; margin-bottom: 0.5rem; color: #cbd5e1; font-size: 0.9rem; }
        .input-dark { width: 100%; padding: 0.75rem; border-radius: 6px; border: 1px solid #334155; background: #0f172a; color: #e2e8f0; margin-bottom: 1rem; font-family: monospace; }

        .loader { display: none; margin-left: 10px; border: 3px solid #f3f3f3; border-top: 3px solid #3498db; border-radius: 50%; width: 20px; height: 20px; animation: spin 1s linear infinite; vertical-align: middle; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
    </style>
    <script>
        function prepareSubmit(form, msg) {
            // Copy the global PHP path to the form's hidden input
            var globalPhp = document.getElementById('global_php_path').value;
            form.querySelector('input[name="custom_php"]').value = globalPhp;

            // Confirm
            var btn = form.querySelector('button');
            if(confirm(msg)) {
                btn.style.opacity = '0.7';
                btn.innerHTML = 'Running... <span class="loader" style="display:inline-block"></span>';
                return true;
            }
            return false;
        }
    </script>
</head>
<body>
<div class="container">
    <h1>🚀 DATAI System Updater (v5)</h1>
    <p class="subtitle">Permissions & Dependencies Manager (Editable Path)</p>

    <?php if (!$authorized): ?>
        <div class="login-box">
            <h2>Enter Access Key</h2>
            <form method="GET">
                <input type="password" name="key" placeholder="Access key..." autofocus>
                <button type="submit" style="width:100%; padding:0.75rem; border-radius:6px; border:none; background:#2563eb; color:white; font-size:1rem; cursor:pointer; margin-top:0.5rem;">Unlock</button>
            </form>
        </div>
    <?php else: ?>

        <div class="warning">
            <strong>⚠️ Security Notice:</strong> This script runs high-privilege commands. Delete it immediately after successful update!
        </div>

        <?php if ($output): ?>
            <div class="card">
                <h2>📜 Execution Output</h2>
                <div class="console"><?= htmlspecialchars($output) ?></div>
                <p style="margin-top:1rem"><a href="?key=<?= urlencode($ACCESS_KEY) ?>" style="color:#38bdf8">Back to Actions</a></p>
            </div>
        <?php else: ?>
            
            <div class="card">
                 <label>PHP Binary Path (You can edit this):</label>
                 <!-- Removed readonly, added ID for JS to grab -->
                 <input type="text" id="global_php_path" value="<?= htmlspecialchars($defaultPhp) ?>" class="input-dark">
                 <p style="font-size:0.8rem; color:#94a3b8; margin-top:-0.5rem; margin-bottom:0;">
                    <i>Common paths: <code>/opt/plesk/php/8.4/bin/php</code>, <code>/usr/bin/php</code>.</i>
                 </p>
            </div>

            <div class="card">
                <h2>1️⃣ Seed Permissions (Run This First!)</h2>
                <p style="margin-bottom:1rem; color:#cbd5e1">
                    Injects the "Interactive Content" page and permissions into the database.
                </p>
                <form method="POST" onsubmit="return prepareSubmit(this, 'Seed database permissions?');">
                    <input type="hidden" name="key" value="<?= htmlspecialchars($ACCESS_KEY) ?>">
                    <input type="hidden" name="action" value="seed_permissions">
                    <input type="hidden" name="custom_php" value=""> <!-- Populated by JS -->
                    <button type="submit" class="btn btn-purple">🌱 Seed Permissions</button>
                </form>
            </div>

            <div class="card">
                <h2>2️⃣ Update Dependencies (If needed)</h2>
                <p style="margin-bottom:1rem; color:#cbd5e1">
                    Runs composer update and migrations.
                </p>
                <form method="POST" onsubmit="return prepareSubmit(this, 'Run composer update?');">
                    <input type="hidden" name="key" value="<?= htmlspecialchars($ACCESS_KEY) ?>">
                    <input type="hidden" name="action" value="composer_update">
                    <input type="hidden" name="custom_php" value=""> <!-- Populated by JS -->
                    <button type="submit" class="btn btn-green">🚀 Run Composer Update</button>
                </form>
            </div>
        <?php endif; ?>

    <?php endif; ?>
</div>
</body>
</html>
