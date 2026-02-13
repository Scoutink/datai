<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoardCardTag extends Model
{
    use HasFactory, Uuids;

    public $timestamps = false;
    protected $table = 'boardCardTags';

    protected $fillable = [
        'id',
        'cardId',
        'tagId'
    ];

    public function card()
    {
        return $this->belongsTo(BoardCard::class, 'cardId', 'id');
    }

    public function tag()
    {
        return $this->belongsTo(BoardTag::class, 'tagId', 'id');
    }
}
