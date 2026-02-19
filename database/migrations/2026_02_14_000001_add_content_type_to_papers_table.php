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
        Schema::table('papers', function (Blueprint $table) {
            $table->string('contentType', 50)->default('DOC')->after('description');
        });

        Schema::table('paperVersions', function (Blueprint $table) {
            $table->string('contentType', 50)->default('DOC')->after('description');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('papers', function (Blueprint $table) {
            $table->dropColumn('contentType');
        });

        Schema::table('paperVersions', function (Blueprint $table) {
            $table->dropColumn('contentType');
        });
    }
};
