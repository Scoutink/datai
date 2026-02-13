<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class PaperRolePermissions extends Model
{
    use HasFactory, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = null;
    protected $table = 'paperRolePermissions';

    protected $fillable = [
        'paperId',
        'roleId',
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

    public function roles()
    {
        return $this->belongsTo(Roles::class, 'roleId', 'id');
    }

    public function users()
    {
        return $this->belongsTo(Users::class, 'createdBy', 'id');
    }
}
