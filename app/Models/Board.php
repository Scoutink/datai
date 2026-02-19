<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Builder;

class Board extends Model
{
    use HasFactory, SoftDeletes, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';
    protected $table = 'boards';

    protected $fillable = [
        'name',
        'description',
        'isPublic',
        'backgroundColor',
        'createdBy',
        'modifiedBy',
        'isDeleted'
    ];

    protected $casts = [
        'isPublic' => 'boolean',
        'isDeleted' => 'boolean'
    ];

    public function columns()
    {
        return $this->hasMany(BoardColumn::class, 'boardId')->orderBy('position');
    }

    public function cards()
    {
        return $this->hasMany(BoardCard::class, 'boardId');
    }

    public function labels()
    {
        return $this->hasMany(BoardLabel::class, 'boardId');
    }

    public function creator()
    {
        return $this->belongsTo(Users::class, 'createdBy', 'id');
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
            $builder->where('boards.isDeleted', '=', 0);
        });
    }
}
