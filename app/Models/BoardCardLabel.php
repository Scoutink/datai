<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class BoardCardLabel extends Model
{
    use Uuids;

    public $timestamps = false;
    protected $table = 'boardCardLabels';

    protected $fillable = [
        'cardId',
        'labelId'
    ];

    public function card()
    {
        return $this->belongsTo(BoardCard::class, 'cardId', 'id');
    }

    public function label()
    {
        return $this->belongsTo(BoardLabel::class, 'labelId', 'id');
    }

}
