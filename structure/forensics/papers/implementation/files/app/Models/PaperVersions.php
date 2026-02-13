<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use App\Traits\Uuids;
use Illuminate\Support\Facades\Auth;
use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Builder;

class PaperVersions extends Model
{
    use HasFactory, Notifiable, Uuids;

    protected $table = 'paperVersions';
    public $incrementing = false;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';

    protected $fillable = ['paperId', 'contentJson', 'contentHtmlSanitized', 'contentText', 'createdBy', 'modifiedBy', 'isDeleted'];

    protected static function boot()
    {
        parent::boot();
        static::creating(function (Model $model) {
            if (Auth::check()) {
                $model->createdBy = Auth::id();
                $model->modifiedBy = Auth::id();
            }
            $model->setAttribute($model->getKeyName(), Uuid::uuid4());
        });

        static::updating(function (Model $model) {
            if (Auth::check()) {
                $model->modifiedBy = Auth::id();
            }
        });

        static::addGlobalScope('isDeleted', function (Builder $builder) {
            $builder->where('paperVersions.isDeleted', '=', 0);
        });
    }
}
