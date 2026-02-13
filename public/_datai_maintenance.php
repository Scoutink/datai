<?php
/**
 * DATAI Maintenance Utility
 * -------------------------
 * Upload this file to your server's public/ folder.
 * Access it at: https://your-domain.com/_datai_maintenance.php
 *
 * IMPORTANT: Delete this file from the server after use!
 */

// ── Security: Simple access key (change if you want) ──
$ACCESS_KEY = 'datai2026';

// ── Bootstrap Laravel ──
$basePath = realpath(__DIR__ . '/..');
require $basePath . '/vendor/autoload.php';
$app = require_once $basePath . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

// ── Check access key ──
$authorized = (($_GET['key'] ?? '') === $ACCESS_KEY || ($_POST['key'] ?? '') === $ACCESS_KEY);

// ── Handle actions ──
$results = [];
if ($authorized && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'clear_all') {
        $commands = [
            'config:clear'    => 'Config Cache',
            'route:clear'     => 'Route Cache',
            'cache:clear'     => 'Application Cache',
            'view:clear'      => 'View Cache',
            'optimize:clear'  => 'Optimized Files',
        ];
        foreach ($commands as $cmd => $label) {
            try {
                Artisan::call($cmd);
                $output = trim(Artisan::output());
                $results[] = ['success' => true, 'label' => $label, 'output' => $output ?: 'Done'];
            } catch (Throwable $e) {
                $results[] = ['success' => false, 'label' => $label, 'output' => $e->getMessage()];
            }
        }
    }

    if ($action === 'dump_autoload') {
        $output = shell_exec('cd ' . escapeshellarg($basePath) . ' && composer dump-autoload 2>&1');
        $results[] = ['success' => true, 'label' => 'Composer Dump Autoload', 'output' => $output ?: 'Done'];
    }
}

// ── Read latest log entries ──
$logContent = '';
if ($authorized) {
    $logPath = $basePath . '/storage/logs/laravel.log';
    if (file_exists($logPath)) {
        // Read last 8000 chars of the log
        $size = filesize($logPath);
        $fp = fopen($logPath, 'r');
        $offset = max(0, $size - 8000);
        fseek($fp, $offset);
        $logContent = fread($fp, 8000);
        fclose($fp);
        // Trim to first complete line
        if ($offset > 0) {
            $logContent = substr($logContent, strpos($logContent, "\n") + 1);
        }
    } else {
        $logContent = '(No log file found at: ' . $logPath . ')';
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DATAI Maintenance</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #0f172a; color: #e2e8f0; min-height: 100vh; padding: 2rem; }
        .container { max-width: 900px; margin: 0 auto; }
        h1 { font-size: 1.5rem; margin-bottom: 0.5rem; color: #38bdf8; }
        .subtitle { color: #94a3b8; margin-bottom: 2rem; font-size: 0.875rem; }
        .warning { background: #7f1d1d; border: 1px solid #dc2626; border-radius: 8px; padding: 1rem; margin-bottom: 2rem; font-size: 0.875rem; }
        .warning strong { color: #fca5a5; }

        /* Login form */
        .login-box { background: #1e293b; border-radius: 12px; padding: 2rem; max-width: 400px; margin: 4rem auto; }
        .login-box input { width: 100%; padding: 0.75rem; border-radius: 6px; border: 1px solid #334155; background: #0f172a; color: #e2e8f0; margin: 0.5rem 0; font-size: 1rem; }
        .login-box button { width: 100%; padding: 0.75rem; border-radius: 6px; border: none; background: #2563eb; color: white; font-size: 1rem; cursor: pointer; margin-top: 0.5rem; }
        .login-box button:hover { background: #1d4ed8; }

        /* Action cards */
        .card { background: #1e293b; border-radius: 12px; padding: 1.5rem; margin-bottom: 1.5rem; }
        .card h2 { font-size: 1.1rem; color: #f1f5f9; margin-bottom: 0.5rem; }
        .card p { color: #94a3b8; font-size: 0.85rem; margin-bottom: 1rem; }
        .btn { display: inline-block; padding: 0.6rem 1.5rem; border-radius: 6px; border: none; font-size: 0.9rem; cursor: pointer; font-weight: 600; }
        .btn-blue { background: #2563eb; color: white; }
        .btn-blue:hover { background: #1d4ed8; }
        .btn-orange { background: #d97706; color: white; }
        .btn-orange:hover { background: #b45309; }

        /* Results */
        .result { padding: 0.5rem 0.75rem; border-radius: 6px; margin-top: 0.5rem; font-size: 0.85rem; font-family: monospace; }
        .result-ok { background: #064e3b; border: 1px solid #059669; }
        .result-fail { background: #7f1d1d; border: 1px solid #dc2626; }

        /* Log viewer */
        .log-viewer { background: #0f172a; border: 1px solid #334155; border-radius: 8px; padding: 1rem; max-height: 500px; overflow-y: auto; font-family: 'Courier New', monospace; font-size: 0.75rem; white-space: pre-wrap; word-break: break-all; line-height: 1.4; color: #cbd5e1; }
        .log-viewer .error-line { color: #f87171; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">
    <h1>🔧 DATAI Maintenance Utility</h1>
    <p class="subtitle">Clear caches, view error logs, and diagnose issues.</p>

    <?php if (!$authorized): ?>
        <div class="login-box">
            <h2>Enter Access Key</h2>
            <form method="GET">
                <input type="password" name="key" placeholder="Access key..." autofocus>
                <button type="submit">Unlock</button>
            </form>
        </div>
    <?php else: ?>

        <div class="warning">
            <strong>⚠️ Security Notice:</strong> Delete this file from the server when you're done!
            This page has access to your application internals.
        </div>

        <!-- Action: Clear All Caches -->
        <div class="card">
            <h2>1️⃣ Clear All Laravel Caches</h2>
            <p>Clears config, routes, views, application cache, and optimized files. This is safe and non-destructive.</p>
            <form method="POST">
                <input type="hidden" name="key" value="<?= htmlspecialchars($ACCESS_KEY) ?>">
                <input type="hidden" name="action" value="clear_all">
                <button type="submit" class="btn btn-blue">🧹 Clear All Caches</button>
            </form>
        </div>

        <!-- Action: Dump Autoload -->
        <div class="card">
            <h2>2️⃣ Composer Dump Autoload</h2>
            <p>Regenerates the class autoloader map. Use this if you see "Class not found" errors.</p>
            <form method="POST">
                <input type="hidden" name="key" value="<?= htmlspecialchars($ACCESS_KEY) ?>">
                <input type="hidden" name="action" value="dump_autoload">
                <button type="submit" class="btn btn-orange">🔄 Dump Autoload</button>
            </form>
        </div>

        <!-- Results -->
        <?php if (!empty($results)): ?>
            <div class="card">
                <h2>✅ Results</h2>
                <?php foreach ($results as $r): ?>
                    <div class="result <?= $r['success'] ? 'result-ok' : 'result-fail' ?>">
                        <strong><?= htmlspecialchars($r['label']) ?>:</strong> <?= htmlspecialchars($r['output']) ?>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>

        <!-- Log Viewer -->
        <div class="card">
            <h2>3️⃣ Latest Error Log</h2>
            <p>Last ~8KB of <code>storage/logs/laravel.log</code>. Look for the most recent error entry.</p>
            <div class="log-viewer"><?php
                // Highlight error lines
                $lines = explode("\n", htmlspecialchars($logContent));
                foreach ($lines as $line) {
                    if (preg_match('/\.(ERROR|CRITICAL|EMERGENCY)/i', $line)) {
                        echo '<span class="error-line">' . $line . "</span>\n";
                    } else {
                        echo $line . "\n";
                    }
                }
            ?></div>
        </div>

    <?php endif; ?>
</div>
</body>
</html>
