<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoardCardActivity extends Model
{
    use HasFactory, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = null;
    protected $table = 'boardCardActivities';

    protected $fillable = [
        'cardId',
        'userId',
        'type',
        'content',
        'attachmentId',
        'createdDate'
    ];

    public function card()
    {
        return $this->belongsTo(BoardCard::class, 'cardId', 'id');
    }

    public function user()
    {
        return $this->belongsTo(Users::class, 'userId', 'id');
    }

    public function attachment()
    {
        return $this->belongsTo(Documents::class, 'attachmentId', 'id');
    }
}
