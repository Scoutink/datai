<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // 1. papers main table
        Schema::create('papers', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('name')->nullable(false);
            $table->text('description')->nullable();
            $table->longText('contentJson')->nullable();
            $table->longText('contentHtmlSanitized')->nullable();
            $table->longText('contentText')->nullable();
            $table->integer('wordCount')->default(0);
            $table->integer('readingTimeMinutes')->default(0);
            $table->uuid('categoryId')->nullable(false);
            $table->uuid('clientId')->nullable();
            $table->uuid('statusId')->nullable();
            $table->string('location')->default('local');
            $table->integer('retentionPeriod')->nullable();
            $table->integer('retentionAction')->nullable();
            $table->string('exportPdfPath', 1024)->nullable();
            $table->dateTime('exportPdfUpdatedAt')->nullable();
            $table->boolean('isIndexed')->default(false);
            $table->uuid('createdBy')->nullable(false);
            $table->string('modifiedBy')->nullable();
            $table->string('deletedBy')->nullable();
            $table->boolean('isDeleted')->default(false);
            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate');
            $table->softDeletes()->nullable();

            $table->foreign('categoryId')->references('id')->on('categories');
            $table->foreign('clientId')->references('id')->on('clients');
            $table->foreign('statusId')->references('id')->on('documentStatus');
            $table->foreign('createdBy')->references('id')->on('users');
            
            $table->index('categoryId');
            $table->index('clientId');
            $table->index('statusId');
            $table->index('createdBy');
            $table->index('name');
        });

        // 2. paperMetaDatas
        Schema::create('paperMetaDatas', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('paperId')->nullable(false);
            $table->string('metatag')->nullable();
            $table->string('createdBy')->nullable();
            $table->string('modifiedBy')->nullable();
            $table->string('deletedBy')->nullable();
            $table->boolean('isDeleted')->default(false);
            $table->dateTime('createdDate')->nullable();
            $table->dateTime('modifiedDate')->nullable();
            $table->softDeletes()->nullable();

            $table->foreign('paperId')->references('id')->on('papers')->onDelete('cascade');
            $table->index('paperId');
        });

        // 3. paperVersions
        Schema::create('paperVersions', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('paperId')->nullable(false);
            $table->integer('versionNo')->nullable();
            $table->string('name')->nullable();
            $table->text('description')->nullable();
            $table->longText('contentJson')->nullable();
            $table->longText('contentHtmlSanitized')->nullable();
            $table->longText('contentText')->nullable();
            $table->integer('wordCount')->default(0);
            $table->integer('readingTimeMinutes')->default(0);
            $table->string('exportPdfPath')->nullable();
            $table->uuid('createdBy')->nullable(false);
            $table->string('modifiedBy')->nullable();
            $table->string('deletedBy')->nullable();
            $table->boolean('isDeleted')->default(false);
            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate');
            $table->softDeletes()->nullable();

            $table->foreign('paperId')->references('id')->on('papers')->onDelete('cascade');
            $table->foreign('createdBy')->references('id')->on('users');
            $table->index('paperId');
        });

        // 4. paperComments
        Schema::create('paperComments', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('paperId')->nullable(false);
            $table->longText('comment')->nullable();
            $table->uuid('createdBy')->nullable(false);
            $table->string('modifiedBy')->nullable();
            $table->string('deletedBy')->nullable();
            $table->boolean('isDeleted')->default(false);
            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate');
            $table->softDeletes()->nullable();

            $table->foreign('paperId')->references('id')->on('papers')->onDelete('cascade');
            $table->foreign('createdBy')->references('id')->on('users');
            $table->index('paperId');
        });

        // 5. paperAuditTrails
        Schema::create('paperAuditTrails', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('paperId')->nullable(false);
            $table->string('operationName')->nullable(false);
            $table->longText('metaJson')->nullable();
            $table->uuid('createdBy')->nullable();
            $table->dateTime('createdDate');

            $table->foreign('paperId')->references('id')->on('papers')->onDelete('cascade');
            $table->index('paperId');
        });

        // 6. paperRolePermissions
        Schema::create('paperRolePermissions', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('paperId')->nullable(false);
            $table->uuid('roleId')->nullable(false);
            $table->boolean('isAllowDownload')->default(false);
            $table->boolean('isTimeBound')->default(false);
            $table->dateTime('startDate')->nullable();
            $table->dateTime('endDate')->nullable();
            $table->uuid('createdBy')->nullable(false);
            $table->dateTime('createdDate');

            $table->foreign('paperId')->references('id')->on('papers')->onDelete('cascade');
            $table->foreign('roleId')->references('id')->on('roles');
            $table->foreign('createdBy')->references('id')->on('users');
            $table->index(['paperId', 'roleId']);
        });

        // 7. paperUserPermissions
        Schema::create('paperUserPermissions', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('paperId')->nullable(false);
            $table->uuid('userId')->nullable(false);
            $table->boolean('isAllowDownload')->default(false);
            $table->boolean('isTimeBound')->default(false);
            $table->dateTime('startDate')->nullable();
            $table->dateTime('endDate')->nullable();
            $table->uuid('createdBy')->nullable(false);
            $table->dateTime('createdDate');

            $table->foreign('paperId')->references('id')->on('papers')->onDelete('cascade');
            $table->foreign('userId')->references('id')->on('users');
            $table->foreign('createdBy')->references('id')->on('users');
            $table->index(['paperId', 'userId']);
        });

        // 8. paperShareableLinks
        Schema::create('paperShareableLinks', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('paperId')->nullable(false);
            $table->string('code')->unique();
            $table->boolean('hasPassword')->default(false);
            $table->string('passwordHash')->nullable();
            $table->dateTime('expiresAt')->nullable();
            $table->boolean('isAllowDownload')->default(false);
            $table->uuid('createdBy')->nullable();
            $table->dateTime('createdDate');
            $table->boolean('isDeleted')->default(false);
            $table->softDeletes()->nullable();

            $table->foreign('paperId')->references('id')->on('papers')->onDelete('cascade');
            $table->index('paperId');
        });

        // 9. paperTokens
        Schema::create('paperTokens', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('paperId')->nullable(false);
            $table->string('token')->unique();
            $table->dateTime('expiresAt')->nullable();
            $table->uuid('createdBy')->nullable();
            $table->dateTime('createdDate');

            $table->foreign('paperId')->references('id')->on('papers')->onDelete('cascade');
            $table->index('paperId');
        });

        // 10. paperAssets
        Schema::create('paperAssets', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('paperId')->nullable(false);
            $table->string('type'); // image, file
            $table->string('storageDisk')->default('local');
            $table->string('path', 1024);
            $table->string('originalName')->nullable();
            $table->string('mime')->nullable();
            $table->bigInteger('size')->default(0);
            $table->uuid('createdBy')->nullable();
            $table->dateTime('createdDate');
            $table->softDeletes()->nullable();

            $table->foreign('paperId')->references('id')->on('papers')->onDelete('cascade');
            $table->index(['paperId', 'type']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('paperAssets');
        Schema::dropIfExists('paperTokens');
        Schema::dropIfExists('paperShareableLinks');
        Schema::dropIfExists('paperUserPermissions');
        Schema::dropIfExists('paperRolePermissions');
        Schema::dropIfExists('paperAuditTrails');
        Schema::dropIfExists('paperComments');
        Schema::dropIfExists('paperVersions');
        Schema::dropIfExists('paperMetaDatas');
        Schema::dropIfExists('papers');
    }
};
