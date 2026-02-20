<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('workspaceNodes', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('nodeType', 40);
            $table->string('title');
            $table->text('description')->nullable();
            $table->uuid('workspaceRootId')->nullable();
            $table->uuid('parentId')->nullable();
            $table->integer('sortIndex')->default(0);
            $table->string('contentKind', 20)->nullable();
            $table->uuid('contentRef')->nullable();
            $table->uuid('createdBy')->nullable(false);
            $table->string('modifiedBy')->nullable();
            $table->string('deletedBy')->nullable();
            $table->boolean('isDeleted')->default(false);
            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate');
            $table->softDeletes()->nullable();

            $table->foreign('workspaceRootId')->references('id')->on('workspaceNodes')->onDelete('cascade');
            $table->foreign('parentId')->references('id')->on('workspaceNodes')->onDelete('cascade');
            $table->foreign('createdBy')->references('id')->on('users');
            $table->index(['workspaceRootId', 'parentId', 'sortIndex'], 'workspaceNodes_tree_idx');
            $table->index(['contentKind', 'contentRef'], 'workspaceNodes_content_idx');
        });

        Schema::create('workspaceNodeFavorites', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('nodeId');
            $table->uuid('userId');
            $table->dateTime('createdDate');
            $table->unique(['nodeId', 'userId']);
            $table->foreign('nodeId')->references('id')->on('workspaceNodes')->onDelete('cascade');
            $table->foreign('userId')->references('id')->on('users')->onDelete('cascade');
        });

        Schema::create('workspaceNodeRecents', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('nodeId');
            $table->uuid('userId');
            $table->dateTime('openedAt');
            $table->unique(['nodeId', 'userId']);
            $table->foreign('nodeId')->references('id')->on('workspaceNodes')->onDelete('cascade');
            $table->foreign('userId')->references('id')->on('users')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('workspaceNodeRecents');
        Schema::dropIfExists('workspaceNodeFavorites');
        Schema::dropIfExists('workspaceNodes');
    }
};
