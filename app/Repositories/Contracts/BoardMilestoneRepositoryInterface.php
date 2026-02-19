<?php

namespace App\Repositories\Contracts;

use App\Repositories\Contracts\BaseRepositoryInterface;

interface BoardMilestoneRepositoryInterface extends BaseRepositoryInterface
{
    public function getBoardMilestones($boardId);
    public function createMilestone($boardId, $data);
    public function updateMilestone($id, $data);
    public function deleteMilestone($id);
    public function syncCardMilestones($cardId, $milestoneIds);
}
