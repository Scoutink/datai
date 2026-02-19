<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoardCardFollower extends Model
{
    use HasFactory, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = null;
    protected $table = 'boardCardFollowers';

    protected $fillable = [
        'id',
        'cardId',
        'userId',
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
}
