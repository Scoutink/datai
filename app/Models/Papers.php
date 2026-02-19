<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Builder;

class Papers extends Model
{
    use HasFactory, SoftDeletes;
    use Notifiable, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';
    protected $table = 'papers';

    const TYPE_DOC = 'DOC';
    const TYPE_SHEET = 'SHEET';
    const TYPE_WHITEBOARD = 'WHITEBOARD';
    const TYPE_WYSIWYG = 'WYSIWYG';

    protected $fillable = [
        'name',
        'contentType',
        'description',
        'contentJson',
        'contentHtmlSanitized',
        'contentText',
        'wordCount',
        'readingTimeMinutes',
        'categoryId',
        'clientId',
        'statusId',
        'location',
        'retentionPeriod',
        'retentionAction',
        'exportPdfPath',
        'exportPdfUpdatedAt',
        'isIndexed',
        'createdBy',
        'modifiedBy',
        'isDeleted'
    ];

    protected $casts = [
        'isIndexed' => 'boolean',
        'isDeleted' => 'boolean',
        'wordCount' => 'integer',
        'readingTimeMinutes' => 'integer',
        'retentionPeriod' => 'integer',
        'retentionAction' => 'integer',
        'exportPdfUpdatedAt' => 'datetime'
    ];

    public function categories()
    {
        return $this->belongsTo(Categories::class, 'categoryId', 'id');
    }

    public function clients()
    {
        return $this->belongsTo(Clients::class, 'clientId', 'id');
    }

    public function paperStatus()
    {
        return $this->belongsTo(DocumentStatus::class, 'statusId', 'id');
    }

    public function users()
    {
        return $this->belongsTo(Users::class, 'createdBy', 'id');
    }

    public function paperMetaDatas()
    {
        return $this->hasMany(PaperMetaDatas::class, 'paperId');
    }

    public function paperComments()
    {
        return $this->hasMany(PaperComments::class, 'paperId');
    }

    public function paperVersions()
    {
        return $this->hasMany(PaperVersions::class, 'paperId');
    }

    public function paperUserPermissions()
    {
        return $this->hasMany(PaperUserPermissions::class, 'paperId');
    }

    public function paperRolePermissions()
    {
        return $this->hasMany(PaperRolePermissions::class, 'paperId');
    }

    public function paperAuditTrails()
    {
        return $this->hasMany(PaperAuditTrails::class, 'paperId');
    }

    public function paperShareableLinks()
    {
        return $this->hasMany(PaperShareableLinks::class, 'paperId');
    }

    public function paperAssets()
    {
        return $this->hasMany(PaperAssets::class, 'paperId');
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
            if (empty($model->{$model->getKeyName()})) {
                $model->setAttribute($model->getKeyName(), Uuid::uuid4()->toString());
            }
        });

        static::updating(function (Model $model) {
            if (Auth::check()) {
                $userId = Auth::id();
                $model->modifiedBy = $userId;
            }
        });

        static::addGlobalScope('isDeleted', function (Builder $builder) {
            $builder->where('papers.isDeleted', '=', 0);
        });
    }
}
