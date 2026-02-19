@@ -97,32 +97,41 @@ $h5p = App::make('LaravelH5p');

// Get content
$content = $h5p->get_content($id);

// Get embed code
$embed = $h5p->get_embed($content, $settings);
```

## 🔗 xAPI/LRS Integration

When LRS is enabled, student results are automatically sent to your LRS:

1. Set `LRS_ENABLED=true` in `.env`
2. Configure LRS credentials
3. Run queue worker: `php artisan queue:work`

## 📁 Directory Structure

```
storage/app/public/h5p/
├── content/      # H5P content files
├── libraries/    # H5P libraries
└── temp/         # Temporary files
```

## 🧭 Deploying on Plesk (Ubuntu 22 + MySQL)

This repository is a **Laravel package**, not a standalone Laravel application.
Deploy it inside a Laravel app, then run package install commands.

For a full step-by-step production guide (including phpMyAdmin + MySQL setup), see:

- `PLESK_DEPLOYMENT_MANUAL.txt`

## 🤝 Contributing

Contributions are welcome! Please read our contributing guidelines.

## 📄 License

MIT License - see LICENSE file.
