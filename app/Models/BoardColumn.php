<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Builder;

class BoardColumn extends Model
{
    use HasFactory, SoftDeletes, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';
    protected $table = 'boardColumns';

    protected $fillable = [
        'boardId',
        'name',
        'position',
        'color',
        'wipLimit',
        'createdBy',
        'modifiedBy',
        'isDeleted'
    ];

    protected $casts = [
        'position' => 'integer',
        'wipLimit' => 'integer',
        'isDeleted' => 'boolean'
    ];

    public function board()
    {
        return $this->belongsTo(Board::class, 'boardId', 'id');
    }

    public function cards()
    {
        return $this->hasMany(BoardCard::class, 'columnId')->orderBy('position');
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
            $builder->where('boardColumns.isDeleted', '=', 0);
        });
    }
}
