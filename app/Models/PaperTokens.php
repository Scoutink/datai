<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class PaperTokens extends Model
{
    use HasFactory, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = null;
    protected $table = 'paperTokens';

    protected $fillable = [
        'paperId',
        'token',
        'expiresAt',
        'createdBy'
    ];

    protected $casts = [
        'expiresAt' => 'datetime'
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
