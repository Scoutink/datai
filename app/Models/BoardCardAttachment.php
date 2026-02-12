<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class BoardCardAttachment extends Model
{
    use Uuids;

    public $timestamps = false;
    protected $table = 'boardCardAttachments';

    protected $fillable = [
        'cardId',
        'documentId',
        'createdDate'
    ];

    public function card()
    {
        return $this->belongsTo(BoardCard::class, 'cardId', 'id');
    }

    public function document()
    {
        return $this->belongsTo(Documents::class, 'documentId', 'id');
    }
}
