# Build Overview

## Workflow goal
Generate a ready-to-upload deployment ZIP artifact from GitHub Actions so server deployment does not require local build.

## What the workflow does
1. Checks out repository.
2. Sets up PHP (8.2) and Composer.
3. Runs production Composer install (`--no-dev --optimize-autoloader`).
4. Sets up Node.js (20) and builds Angular from `resources/frontend/angular`.
5. Copies Angular generated `index.html` to `resources/views/angular.blade.php`.
6. Assembles deploy folder with runtime-required Laravel files + built assets + vendor.
7. Produces ZIP and uploads artifact.

## Why these versions
- PHP version requirement is declared in `composer.json` (`^8.2`).
- Angular 18 toolchain is used; Node 20 LTS is compatible and stable for CI builds.

## Artifact scope
Includes source/runtime files needed for deployment, excluding `.git`, CI metadata, local caches, and dev-only build folders.
