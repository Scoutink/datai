<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (!Schema::hasTable('papers')) {
            Schema::create('papers', function (Blueprint $table) {
                $table->char('id', 36)->primary();
                $table->string('name');
                $table->text('description')->nullable();
                $table->longText('contentJson');
                $table->longText('contentHtmlSanitized');
                $table->longText('contentText')->nullable();
                $table->integer('wordCount')->default(0);
                $table->integer('readingTimeMinutes')->default(0);
                $table->char('categoryId', 36);
                $table->char('clientId', 36)->nullable();
                $table->char('statusId', 36)->nullable();
                $table->integer('retentionPeriod')->nullable();
                $table->integer('retentionAction')->nullable();
                $table->char('createdBy', 36);
                $table->char('modifiedBy', 36);
                $table->char('deletedBy', 36)->nullable();
                $table->boolean('isDeleted')->default(false);
                $table->dateTime('createdDate');
                $table->dateTime('modifiedDate');
                $table->softDeletes();

                $table->index('categoryId');
                $table->index('clientId');
                $table->index('statusId');
                $table->index('createdBy');
                $table->index('isDeleted');
            });
        }

        if (!Schema::hasTable('paperMetaDatas')) {
            Schema::create('paperMetaDatas', function (Blueprint $table) {
                $table->char('id', 36)->primary();
                $table->char('paperId', 36);
                $table->string('metatag');
                $table->foreign('paperId')->references('id')->on('papers')->cascadeOnDelete();
            });
        }

        if (!Schema::hasTable('paperRolePermissions')) {
            Schema::create('paperRolePermissions', function (Blueprint $table) {
                $table->char('id', 36)->primary();
                $table->char('paperId', 36);
                $table->char('roleId', 36);
                $table->boolean('isAllowDownload')->default(false);
                $table->dateTime('startDate')->nullable();
                $table->dateTime('endDate')->nullable();
                $table->char('createdBy', 36);
                $table->foreign('paperId')->references('id')->on('papers')->cascadeOnDelete();
                $table->foreign('roleId')->references('id')->on('roles');
            });
        }

        if (!Schema::hasTable('paperUserPermissions')) {
            Schema::create('paperUserPermissions', function (Blueprint $table) {
                $table->char('id', 36)->primary();
                $table->char('paperId', 36);
                $table->char('userId', 36);
                $table->boolean('isAllowDownload')->default(false);
                $table->dateTime('startDate')->nullable();
                $table->dateTime('endDate')->nullable();
                $table->char('createdBy', 36);
                $table->foreign('paperId')->references('id')->on('papers')->cascadeOnDelete();
                $table->foreign('userId')->references('id')->on('users');
            });
        }

        if (!Schema::hasTable('paperVersions')) {
            Schema::create('paperVersions', function (Blueprint $table) {
                $table->char('id', 36)->primary();
                $table->char('paperId', 36);
                $table->longText('contentJson');
                $table->longText('contentHtmlSanitized');
                $table->longText('contentText')->nullable();
                $table->char('createdBy', 36);
                $table->char('modifiedBy', 36);
                $table->boolean('isDeleted')->default(false);
                $table->dateTime('createdDate');
                $table->dateTime('modifiedDate');
                $table->foreign('paperId')->references('id')->on('papers')->cascadeOnDelete();
            });
        }

        if (!Schema::hasTable('paperComments')) {
            Schema::create('paperComments', function (Blueprint $table) {
                $table->char('id', 36)->primary();
                $table->char('paperId', 36);
                $table->longText('comment');
                $table->char('createdBy', 36);
                $table->char('modifiedBy', 36);
                $table->boolean('isDeleted')->default(false);
                $table->dateTime('createdDate');
                $table->dateTime('modifiedDate');
                $table->foreign('paperId')->references('id')->on('papers')->cascadeOnDelete();
            });
        }

        if (!Schema::hasTable('paperAuditTrails')) {
            Schema::create('paperAuditTrails', function (Blueprint $table) {
                $table->char('id', 36)->primary();
                $table->char('paperId', 36);
                $table->string('operationName');
                $table->char('assignToRoleId', 36)->nullable();
                $table->char('assignToUserId', 36)->nullable();
                $table->char('createdBy', 36)->nullable();
                $table->dateTime('createdDate');
                $table->foreign('paperId')->references('id')->on('papers')->cascadeOnDelete();
            });
        }

        if (!Schema::hasTable('paperShareableLink')) {
            Schema::create('paperShareableLink', function (Blueprint $table) {
                $table->char('id', 36)->primary();
                $table->char('paperId', 36);
                $table->string('code')->unique();
                $table->string('password')->nullable();
                $table->boolean('isAllowDownload')->default(false);
                $table->dateTime('expiryDate')->nullable();
                $table->char('createdBy', 36)->nullable();
                $table->dateTime('createdDate');
                $table->foreign('paperId')->references('id')->on('papers')->cascadeOnDelete();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('paperShareableLink');
        Schema::dropIfExists('paperAuditTrails');
        Schema::dropIfExists('paperComments');
        Schema::dropIfExists('paperVersions');
        Schema::dropIfExists('paperUserPermissions');
        Schema::dropIfExists('paperRolePermissions');
        Schema::dropIfExists('paperMetaDatas');
        Schema::dropIfExists('papers');
    }
};
