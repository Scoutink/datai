<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class PaperMetaDatas extends Model
{
    use HasFactory, Uuids;

    protected $table = 'paperMetaDatas';
    public $incrementing = false;
    public $timestamps = false;

    protected $fillable = ['paperId', 'metatag'];
}
