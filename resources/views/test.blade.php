<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Page - Datai</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Roboto, Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: white;
        }
        .container {
            text-align: center;
            padding: 40px;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            border: 1px solid rgba(255,255,255,0.2);
        }
        h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .status {
            font-size: 1.25rem;
            opacity: 0.9;
            margin-bottom: 2rem;
        }
        .checks {
            text-align: left;
            margin-top: 2rem;
        }
        .check-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 8px 0;
            padding: 10px 15px;
            background: rgba(255,255,255,0.1);
            border-radius: 8px;
        }
        .check-icon {
            width: 24px;
            height: 24px;
            background: #22c55e;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        .back-link {
            margin-top: 2rem;
            display: inline-block;
            padding: 12px 24px;
            background: rgba(255,255,255,0.2);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: background 0.2s;
        }
        .back-link:hover {
            background: rgba(255,255,255,0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>testing</h1>
        <div class="status">Laravel routing is working correctly!</div>
        
        <div class="checks">
            <div class="check-item">
                <span class="check-icon">✓</span>
                <span>Route /test bypasses Angular SPA</span>
            </div>
            <div class="check-item">
                <span class="check-icon">✓</span>
                <span>Blade view renders successfully</span>
            </div>
            <div class="check-item">
                <span class="check-icon">✓</span>
                <span>No auth middleware applied</span>
            </div>
        </div>
        
        <a href="/" class="back-link">← Back to Dashboard</a>
    </div>
</body>
</html>
