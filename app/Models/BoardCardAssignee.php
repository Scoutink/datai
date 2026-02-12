<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class BoardCardAssignee extends Model
{
    use Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = null;
    protected $table = 'boardCardAssignees';

    protected $fillable = [
        'cardId',
        'userId'
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
