<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class PaperAuditTrails extends Model
{
    use HasFactory, Uuids;

    protected $table = 'paperAuditTrails';
    public $incrementing = false;
    public $timestamps = false;

    protected $fillable = ['paperId', 'operationName', 'assignToRoleId', 'assignToUserId', 'createdBy', 'createdDate'];
}
