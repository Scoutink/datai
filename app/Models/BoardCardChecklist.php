<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoardCardChecklist extends Model
{
    use HasFactory, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = null;
    protected $table = 'boardCardChecklists';

    protected $fillable = [
        'id',
        'cardId',
        'name',
        'createdDate'
    ];

    public function card()
    {
        return $this->belongsTo(BoardCard::class, 'cardId', 'id');
    }

    public function items()
    {
        return $this->hasMany(BoardCardChecklistItem::class, 'checklistId', 'id')->orderBy('position', 'asc');
    }
}
