# H5P Systematic Recovery Plan

Following a comprehensive forensic audit, this plan outlines the steps required to achieve a flawless H5P deployment.

## Current State Assessment
- **Database:** Tables `h5p_*` exist but are empty. High-level relationships are intact but lack content/libraries.
- **Config:** Published to `config/laravel-h5p.php` but requires path verification.
- **Assets:** Deployed in `public/assets/vendor/laravel-h5p/`, but H5P core/editor fonts/styles may have path mapping issues.
- **Auth:** Fixed to use Bearer tokens for the editor.

## Phase 1: Storage & Permissions
- [ ] **Verify Storage Structure:** Ensure `storage/app/public/h5p/` contains `content`, `libraries`, and `temp` folders.
- [ ] **Permissions:** Ensure the web server (Plesk/Ubuntu) has write access to these folders.
- [ ] **Symlink:** Verify `public/storage` exists and points to `storage/app/public`.

## Phase 2: Database & Library Seeding
- [ ] **Identify "Golden" Library Set:** Determine which H5P libraries are required (e.g., Interactive Video, Course Presentation).
- [ ] **Hub Cache Refresh:** 
  - Access `/h5p/library` (the plugin's admin UI) to force a Hub refresh.
  - Or manually run an SQL update to set `h5p_content_type_cache_updated_at` to `0` in `config/laravel-h5p.php`.
- [ ] **Direct Implementation of Libraries:** If Hub fetching fails, manually upload `.h5p` library packages via the `/h5p/library` admin interface.

## Phase 3: Path & Asset Alignment
- [ ] **Config Check:** Double-check `config/laravel-h5p.php` for `h5p_public_path` alignment with actual server paths.
- [ ] **Asset Validation:** Ensure all core H5P JS/CSS files are loading correctly (check browser console for 404s).

## Phase 4: Integration Verification
- [ ] **Create Smoke Test:** Create a simple "Multiple Choice" H5P content via `/interactive/create`.
- [ ] **Save Logic:** Verify the content is saved to `h5p_contents` and files appear in `storage`.
- [ ] **View Logic:** Verify the content can be viewed/rendered in a "Paper".

## Fallback Plan (Clean Slate)
If dependencies are too fragmented:
1. **Drop Tables:** `DROP TABLE IF EXISTS h5p_...` (13 tables).
2. **Clear Config:** Remove `config/laravel-h5p.php`.
3. **Clean Storage:** Delete `storage/app/public/h5p`.
4. **Re-Install:** Run `php artisan h5p:install` (if terminal access allows) or perform the manual equivalent by running the SQL migration and publishing files.
