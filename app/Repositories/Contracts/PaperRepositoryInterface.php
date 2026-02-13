<?php

namespace App\Repositories\Contracts;

interface PaperRepositoryInterface extends BaseRepositoryInterface
{
    public function getPapers($attributes);
    public function getPapersCount($attributes);
    public function getAssignedPapers($attributes);
    public function getAssignedPapersCount($attributes);
    public function savePaper($request);
    public function updatePaper($request, $id);
    public function archivePaper($id);
    public function addComment($request);
    public function getComments($paperId);
    public function getVersions($paperId);
    public function restoreVersion($paperId, $versionId);
    public function saveShareableLink($request);
    public function getShareableLink($paperId);
}
