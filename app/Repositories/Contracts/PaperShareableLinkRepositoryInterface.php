<?php

namespace App\Repositories\Contracts;

use App\Repositories\Contracts\BaseRepositoryInterface;

interface PaperShareableLinkRepositoryInterface extends BaseRepositoryInterface
{
    public function getPaperShareableLink($paperId);
    public function savePaperShareableLink($request);
    public function deletePaperShareableLink($id);
    public function getPaperIdByShareCode($code);
}
