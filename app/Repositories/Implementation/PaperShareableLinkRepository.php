<?php

namespace App\Repositories\Implementation;

use App\Models\PaperShareableLinks;
use App\Models\Papers;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use App\Repositories\Implementation\BaseRepository;
use App\Repositories\Contracts\PaperShareableLinkRepositoryInterface;

class PaperShareableLinkRepository extends BaseRepository implements PaperShareableLinkRepositoryInterface
{
    public static function model()
    {
        return PaperShareableLinks::class;
    }

    public function getPaperShareableLink($paperId)
    {
        return PaperShareableLinks::where('paperId', $paperId)
            ->where('isDeleted', false)
            ->first();
    }

    public function savePaperShareableLink($request)
    {
        $link = PaperShareableLinks::where('paperId', $request->paperId)->first();

        $data = [
            'paperId' => $request->paperId,
            'code' => $link ? $link->code : Str::random(12),
            'hasPassword' => $request->hasPassword,
            'isAllowDownload' => $request->isAllowDownload,
            'expiresAt' => $request->expiresAt ? Carbon::parse($request->expiresAt) : null,
            'createdBy' => Auth::id(),
            'isDeleted' => false
        ];

        if ($request->hasPassword && $request->password) {
            $data['passwordHash'] = Hash::make($request->password);
        }

        if ($link) {
            $link->update($data);
        } else {
            $link = PaperShareableLinks::create($data);
        }

        return $link;
    }

    public function deletePaperShareableLink($id)
    {
        $link = PaperShareableLinks::findOrFail($id);
        $link->isDeleted = true;
        $link->save();
        $link->delete();
        return true;
    }

    public function getPaperIdByShareCode($code)
    {
        $link = PaperShareableLinks::where('code', $code)
            ->where('isDeleted', false)
            ->where(function ($query) {
                $query->whereNull('expiresAt')
                      ->orWhere('expiresAt', '>', Carbon::now());
            })
            ->first();

        return $link ? $link->paperId : null;
    }
}
