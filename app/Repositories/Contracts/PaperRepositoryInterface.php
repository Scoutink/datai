<?php

namespace App\Repositories\Contracts;

use App\Repositories\Contracts\BaseRepositoryInterface;

interface PaperRepositoryInterface extends BaseRepositoryInterface
{
    public function getPapers($attributes);
    public function getPapersCount($attributes);
    public function savePaper($request);
    public function updatePaper($request, $id);
    public function getPaperById($id);
    public function assignedPapers($attributes);
    public function assignedPapersCount($attributes);
    public function archivePaper($id);
    public function getDeepSearchPapers($attributes);
    public function addPaperToDeepSearch($id);
    public function removePaperFromDeepSearch($id);
}
