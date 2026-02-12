<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class BoardLabel extends Model
{
    use Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = null;
    protected $table = 'boardLabels';

    protected $fillable = [
        'boardId',
        'name',
        'color'
    ];

    public function board()
    {
        return $this->belongsTo(Board::class, 'boardId', 'id');
    }

    public function cards()
    {
        return $this->belongsToMany(BoardCard::class, 'boardCardLabels', 'labelId', 'cardId');
    }

}
