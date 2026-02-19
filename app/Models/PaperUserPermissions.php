<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class PaperUserPermissions extends Model
{
    use HasFactory, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = null;
    protected $table = 'paperUserPermissions';

    protected $fillable = [
        'paperId',
        'userId',
        'isAllowDownload',
        'isTimeBound',
        'startDate',
        'endDate',
        'createdBy'
    ];

    protected $casts = [
        'isAllowDownload' => 'boolean',
        'isTimeBound' => 'boolean',
        'startDate' => 'datetime',
        'endDate' => 'datetime'
    ];

    public function papers()
    {
        return $this->belongsTo(Papers::class, 'paperId', 'id');
    }

    public function users()
    {
        return $this->belongsTo(Users::class, 'userId', 'id');
    }

    public function creator()
    {
        return $this->belongsTo(Users::class, 'createdBy', 'id');
    }
}
