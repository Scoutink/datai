<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoardCardChecklistItem extends Model
{
    use HasFactory, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = null;
    protected $table = 'boardCardChecklistItems';

    protected $fillable = [
        'id',
        'checklistId',
        'name',
        'isCompleted',
        'position',
        'createdDate'
    ];

    public function checklist()
    {
        return $this->belongsTo(BoardCardChecklist::class, 'checklistId', 'id');
    }
}
