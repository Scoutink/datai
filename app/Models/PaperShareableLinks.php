<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class PaperShareableLinks extends Model
{
    use HasFactory, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = null;
    protected $table = 'paperShareableLinks';

    protected $fillable = [
        'paperId',
        'code',
        'hasPassword',
        'passwordHash',
        'expiresAt',
        'isAllowDownload',
        'createdBy',
        'isDeleted'
    ];

    protected $casts = [
        'hasPassword' => 'boolean',
        'isAllowDownload' => 'boolean',
        'expiresAt' => 'datetime',
        'isDeleted' => 'boolean'
    ];

    public function papers()
    {
        return $this->belongsTo(Papers::class, 'paperId', 'id');
    }

    public function users()
    {
        return $this->belongsTo(Users::class, 'createdBy', 'id');
    }
}
