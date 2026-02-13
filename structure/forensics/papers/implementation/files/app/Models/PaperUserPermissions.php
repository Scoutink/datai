<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class PaperUserPermissions extends Model
{
    use HasFactory, Uuids;

    protected $table = 'paperUserPermissions';
    public $incrementing = false;
    public $timestamps = false;

    protected $fillable = ['paperId', 'userId', 'isAllowDownload', 'startDate', 'endDate', 'createdBy'];
}
