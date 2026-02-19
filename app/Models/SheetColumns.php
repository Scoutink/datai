<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Auth;
use Ramsey\Uuid\Uuid;

class SheetColumns extends Model
{
    use HasFactory, SoftDeletes, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';
    protected $table = 'sheetColumns';

    protected $fillable = [
        'paperId',
        'name',
        'type',
        'sortOrder',
        'settings',
        'isRequired',
        'createdBy',
        'modifiedBy',
        'isDeleted'
    ];

    protected $casts = [
        'sortOrder' => 'integer',
        'isRequired' => 'boolean',
        'isDeleted' => 'boolean',
        'settings' => 'array'
    ];

    public function paper()
    {
        return $this->belongsTo(Papers::class, 'paperId');
    }

    protected static function boot()
    {
        parent::boot();
        static::creating(function (Model $model) {
            if (Auth::check()) {
                $model->createdBy = Auth::id();
                $model->modifiedBy = Auth::id();
            }
            if (empty($model->{$model->getKeyName()})) {
                $model->setAttribute($model->getKeyName(), Uuid::uuid4()->toString());
            }
        });

        static::updating(function (Model $model) {
            if (Auth::check()) {
                $model->modifiedBy = Auth::id();
            }
        });
    }
}
