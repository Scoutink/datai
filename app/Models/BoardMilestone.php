<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class BoardMilestone extends Model
{
    use HasFactory, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';

    protected $table = 'boardMilestones';

    protected $fillable = [
        'boardId',
        'name',
        'color',
        'createdBy',
        'modifiedBy',
        'isDeleted'
    ];

    protected $casts = [
        'isDeleted' => 'boolean'
    ];

    public function board()
    {
        return $this->belongsTo(Board::class, 'boardId', 'id');
    }

    public function cards()
    {
        return $this->belongsToMany(BoardCard::class, 'boardCardMilestones', 'milestoneId', 'cardId');
    }
}
