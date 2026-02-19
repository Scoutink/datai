<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class PaperAssets extends Model
{
    use HasFactory, SoftDeletes, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = null;
    protected $table = 'paperAssets';

    protected $fillable = [
        'paperId',
        'type',
        'storageDisk',
        'path',
        'originalName',
        'mime',
        'size',
        'createdBy'
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
