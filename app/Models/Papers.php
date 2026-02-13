<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Notifications\Notifiable;
use App\Traits\Uuids;
use Illuminate\Support\Facades\Auth;
use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Builder;

class Papers extends Model
{
    use HasFactory, SoftDeletes, Notifiable, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';

    protected $table = 'papers';

    protected $fillable = [
        'name',
        'description',
        'contentJson',
        'contentHtmlSanitized',
        'contentText',
        'wordCount',
        'readingTimeMinutes',
        'categoryId',
        'clientId',
        'statusId',
        'createdBy',
        'modifiedBy',
        'isDeleted',
        'retentionPeriod',
        'retentionAction',
    ];

    public function paperComments()
    {
        return $this->hasMany(PaperComments::class, 'paperId');
    }

    public function paperVersions()
    {
        return $this->hasMany(PaperVersions::class, 'paperId');
    }

    public function paperRolePermissions()
    {
        return $this->hasMany(PaperRolePermissions::class, 'paperId');
    }

    public function paperUserPermissions()
    {
        return $this->hasMany(PaperUserPermissions::class, 'paperId');
    }

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
            $builder->where('papers.isDeleted', '=', 0);
        });
    }
}
