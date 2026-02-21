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
        // 1. sheetColumns
        Schema::create('sheetColumns', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('paperId')->nullable(false);
            $table->string('name')->nullable(false);
            $table->string('type')->nullable(false); // text, number, bool, date, select, relation, rollup, etc.
            $table->integer('sortOrder')->default(0);
            $table->longText('settings')->nullable(); // JSON for select options, relation config, etc.
            $table->boolean('isRequired')->default(false);
            $table->uuid('createdBy')->nullable(false);
            $table->string('modifiedBy')->nullable();
            $table->boolean('isDeleted')->default(false);
            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate');
            $table->softDeletes()->nullable();

            $table->foreign('paperId')->references('id')->on('papers')->onDelete('cascade');
            $table->foreign('createdBy')->references('id')->on('users');
            $table->index('paperId');
        });

        // 2. sheetRows
        Schema::create('sheetRows', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('paperId')->nullable(false);
            $table->longText('data')->nullable(); // JSON canonical storage: {columnId: value}
            $table->integer('version')->default(1); // Optimistic locking
            $table->uuid('createdBy')->nullable(false);
            $table->string('modifiedBy')->nullable();
            $table->boolean('isDeleted')->default(false);
            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate');
            $table->softDeletes()->nullable();

            $table->foreign('paperId')->references('id')->on('papers')->onDelete('cascade');
            $table->foreign('createdBy')->references('id')->on('users');
            $table->index('paperId');
        });

        // 3. sheetRowCells (Typed Index Table)
        Schema::create('sheetRowCells', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('rowId')->nullable(false);
            $table->uuid('paperId')->nullable(false);
            $table->uuid('columnId')->nullable(false);
            
            $table->longText('valueText')->nullable();
            $table->decimal('valueNumber', 15, 4)->nullable();
            $table->dateTime('valueDate')->nullable();
            $table->boolean('valueBool')->nullable();
            $table->longText('valueJson')->nullable();

            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate');

            $table->foreign('rowId')->references('id')->on('sheetRows')->onDelete('cascade');
            $table->foreign('paperId')->references('id')->on('papers')->onDelete('cascade');
            $table->foreign('columnId')->references('id')->on('sheetColumns')->onDelete('cascade');

            $table->unique(['rowId', 'columnId']);
            $table->index(['paperId', 'columnId']);
            $table->index('valueNumber');
            $table->index('valueDate');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('sheetRowCells');
        Schema::dropIfExists('sheetRows');
        Schema::dropIfExists('sheetColumns');
    }
};
