<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class PaperMetaDatas extends Model
{
    use HasFactory, SoftDeletes, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';
    protected $table = 'paperMetaDatas';

    protected $fillable = [
        'paperId',
        'metatag',
        'createdBy',
        'modifiedBy',
        'isDeleted'
    ];

    public function papers()
    {
        return $this->belongsTo(Papers::class, 'paperId', 'id');
    }
}
