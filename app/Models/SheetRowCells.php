<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Ramsey\Uuid\Uuid;

class SheetRowCells extends Model
{
    use HasFactory, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';
    protected $table = 'sheetRowCells';

    protected $fillable = [
        'rowId',
        'paperId',
        'columnId',
        'valueText',
        'valueNumber',
        'valueDate',
        'valueBool',
        'valueJson'
    ];

    protected $casts = [
        'valueNumber' => 'decimal:4',
        'valueDate' => 'datetime',
        'valueBool' => 'boolean',
        'valueJson' => 'array'
    ];

    public function row()
    {
        return $this->belongsTo(SheetRows::class, 'rowId');
    }

    public function column()
    {
        return $this->belongsTo(SheetColumns::class, 'columnId');
    }

    protected static function boot()
    {
        parent::boot();
        static::creating(function (Model $model) {
            if (empty($model->{$model->getKeyName()})) {
                $model->setAttribute($model->getKeyName(), Uuid::uuid4()->toString());
            }
        });
    }
}
