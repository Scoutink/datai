<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (!Schema::hasTable('boardMilestones')) {
            Schema::create('boardMilestones', function (Blueprint $table) {
                $table->char('id', 36)->primary();
                $table->char('boardId', 36);
                $table->string('name');
                $table->string('color', 50)->default('#0079bf');
                $table->char('createdBy', 36);
                $table->dateTime('createdDate');
                $table->char('modifiedBy', 36)->nullable();
                $table->dateTime('modifiedDate')->nullable();
                $table->boolean('isDeleted')->default(false);

                $table->index('boardId');
                $table->index('createdBy');
                $table->index('modifiedBy');
                $table->foreign('boardId')->references('id')->on('boards')->cascadeOnDelete();
                $table->foreign('createdBy')->references('id')->on('users');
                $table->foreign('modifiedBy')->references('id')->on('users');
            });
        }

        if (!Schema::hasTable('boardCardMilestones')) {
            Schema::create('boardCardMilestones', function (Blueprint $table) {
                $table->char('cardId', 36);
                $table->char('milestoneId', 36);
                $table->primary(['cardId', 'milestoneId']);

                $table->foreign('cardId')->references('id')->on('boardCards')->cascadeOnDelete();
                $table->foreign('milestoneId')->references('id')->on('boardMilestones')->cascadeOnDelete();
            });
        }
    }

    public function down(): void
    {
        if (Schema::hasTable('boardCardMilestones')) {
            Schema::drop('boardCardMilestones');
        }

        if (Schema::hasTable('boardMilestones')) {
            Schema::drop('boardMilestones');
        }
    }
};
