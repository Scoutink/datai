<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoardTag extends Model
{
    use HasFactory, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = null;
    protected $table = 'boardTags';

    protected $fillable = [
        'boardId',
        'name',
        'color',
        'createdDate'
    ];

    public function board()
    {
        return $this->belongsTo(Board::class, 'boardId', 'id');
    }

    public function cards()
    {
        return $this->belongsToMany(BoardCard::class, 'boardCardTags', 'tagId', 'cardId');
    }
}
