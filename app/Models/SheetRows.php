<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Auth;
use Ramsey\Uuid\Uuid;

class SheetRows extends Model
{
    use HasFactory, SoftDeletes, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';
    protected $table = 'sheetRows';

    protected $fillable = [
        'paperId',
        'data',
        'version',
        'createdBy',
        'modifiedBy',
        'isDeleted'
    ];

    protected $casts = [
        'data' => 'array',
        'version' => 'integer',
        'isDeleted' => 'boolean'
    ];

    public function paper()
    {
        return $this->belongsTo(Papers::class, 'paperId');
    }

    public function cells()
    {
        return $this->hasMany(SheetRowCells::class, 'rowId');
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
