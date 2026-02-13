<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class PaperShareableLink extends Model
{
    use HasFactory, Uuids;

    protected $table = 'paperShareableLink';
    public $incrementing = false;
    public $timestamps = false;

    protected $fillable = ['paperId', 'code', 'password', 'isAllowDownload', 'expiryDate', 'createdBy', 'createdDate'];
}
