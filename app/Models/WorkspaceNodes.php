<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Auth;

class WorkspaceNodes extends Model
{
    use HasFactory, SoftDeletes, Uuids;

    public const CREATED_AT = 'createdDate';
    public const UPDATED_AT = 'modifiedDate';

    protected $table = 'workspaceNodes';

    protected $fillable = [
        'nodeType',
        'title',
        'description',
        'workspaceRootId',
        'parentId',
        'sortIndex',
        'contentKind',
        'contentRef',
        'isDeleted',
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function (Model $model) {
            if (Auth::check()) {
                $model->createdBy = Auth::id();
                $model->modifiedBy = Auth::id();
            }
        });

        static::updating(function (Model $model) {
            if (Auth::check()) {
                $model->modifiedBy = Auth::id();
            }
        });

        static::addGlobalScope('isDeleted', function (Builder $builder) {
            $builder->where('workspaceNodes.isDeleted', 0);
        });
    }
}
