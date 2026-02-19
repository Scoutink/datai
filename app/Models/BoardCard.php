<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Builder;

class BoardCard extends Model
{
    use HasFactory, SoftDeletes, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';
    protected $table = 'boardCards';

    protected $fillable = [
        'columnId',
        'boardId',
        'title',
        'description',
        'position',
        'priority',
        'dueDate',
        'documentId',
        'coverColor',
        'isArchived',
        'htmlDescription',
        'executorId',
        'approverId',
        'supervisorId',
        'parentCardId',
        'createdBy',
        'modifiedBy',
        'isDeleted',
        'isCompleted'
    ];

    protected $casts = [
        'position' => 'integer',
        'isArchived' => 'boolean',
        'isDeleted' => 'boolean',
        'isCompleted' => 'boolean',
        'dueDate' => 'datetime'
    ];

    public function column()
    {
        return $this->belongsTo(BoardColumn::class, 'columnId', 'id');
    }

    public function board()
    {
        return $this->belongsTo(Board::class, 'boardId', 'id');
    }

    public function document()
    {
        return $this->belongsTo(Documents::class, 'documentId', 'id');
    }

    public function assignees()
    {
        return $this->belongsToMany(Users::class, 'boardCardAssignees', 'cardId', 'userId');
    }

    public function labels()
    {
        return $this->belongsToMany(BoardLabel::class, 'boardCardLabels', 'cardId', 'labelId');
    }

    public function creator()
    {
        return $this->belongsTo(Users::class, 'createdBy', 'id');
    }

    public function executor()
    {
        return $this->belongsTo(Users::class, 'executorId', 'id');
    }

    public function approver()
    {
        return $this->belongsTo(Users::class, 'approverId', 'id');
    }

    public function supervisor()
    {
        return $this->belongsTo(Users::class, 'supervisorId', 'id');
    }

    public function parentCard()
    {
        return $this->belongsTo(BoardCard::class, 'parentCardId', 'id');
    }

    public function subCards()
    {
        return $this->hasMany(BoardCard::class, 'parentCardId', 'id');
    }

    public function followers()
    {
        return $this->belongsToMany(Users::class, 'boardCardFollowers', 'cardId', 'userId');
    }

    public function tags()
    {
        return $this->belongsToMany(BoardTag::class, 'boardCardTags', 'cardId', 'tagId');
    }

    public function activities()
    {
        return $this->hasMany(BoardCardActivity::class, 'cardId', 'id')->orderBy('createdDate', 'desc');
    }

    public function attachments()
    {
        return $this->belongsToMany(Documents::class, 'boardCardAttachments', 'cardId', 'documentId')->withPivot('id', 'createdDate');
    }

    public function checklists()
    {
        return $this->hasMany(BoardCardChecklist::class, 'cardId', 'id');
    }

    public function milestones()
    {
        return $this->belongsToMany(BoardMilestone::class, 'boardCardMilestones', 'cardId', 'milestoneId');
    }

    protected static function boot()
    {
        parent::boot();
        static::creating(function (Model $model) {
            if (Auth::check()) {
                $userId = Auth::id();
                $model->createdBy = $userId;
                $model->modifiedBy = $userId;
            }
        });
        static::updating(function (Model $model) {
            if (Auth::check()) {
                $userId = Auth::id();
                $model->modifiedBy = $userId;
            }
        });

        static::addGlobalScope('isDeleted', function (Builder $builder) {
            $builder->where('boardCards.isDeleted', '=', 0);
        });

        static::addGlobalScope('isArchived', function (Builder $builder) {
            $builder->where('boardCards.isArchived', '=', 0);
        });
    }
}
