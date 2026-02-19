<?php

namespace App\Repositories\Contracts;

use App\Repositories\Contracts\BaseRepositoryInterface;

interface PaperCommentRepositoryInterface extends BaseRepositoryInterface
{
    public function getPaperComments($paperId);
    public function savePaperComment($request);
    public function deletePaperComment($id);
}
