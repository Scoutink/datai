<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class PaperRolePermissions extends Model
{
    use HasFactory, Uuids;

    protected $table = 'paperRolePermissions';
    public $incrementing = false;
    public $timestamps = false;

    protected $fillable = ['paperId', 'roleId', 'isAllowDownload', 'startDate', 'endDate', 'createdBy'];
}
