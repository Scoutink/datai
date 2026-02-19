<?php

namespace App\Repositories\Contracts;

interface BoardRepositoryInterface extends BaseRepositoryInterface
{
    // Boards
    public function getBoards($attributes);
    public function getBoardsCount($attributes);
    public function getBoardWithDetails($id);
    public function createBoard($data);
    public function updateBoard($id, $data);
    public function deleteBoard($id);

    // Columns
    public function createColumn($boardId, $data);
    public function updateColumn($id, $data);
    public function deleteColumn($id);
    public function reorderColumns($boardId, $columns);

    // Cards
    public function createCard($columnId, $data);
    public function getCardWithDetails($id);
    public function updateCard($id, $data);
    public function deleteCard($id);
    public function moveCard($id, $columnId, $position);
    public function archiveCard($id);
    public function restoreCard($id);
    public function getArchivedCards($boardId);

    // Assignees
    public function addCardAssignee($cardId, $userId);
    public function removeCardAssignee($cardId, $userId);

    // Labels
    public function createLabel($boardId, $data);
    public function updateLabel($id, $data);
    public function deleteLabel($id);
    public function addCardLabel($cardId, $labelId);
    public function removeCardLabel($cardId, $labelId);
    public function getBoardLabels($boardId);

    // Tags
    public function getBoardTags($boardId);
    public function createBoardTag($boardId, $data);
    public function updateBoardTag($id, $data);
    public function deleteBoardTag($id);
    public function addCardTag($cardId, $tagId);
    public function removeCardTag($cardId, $tagId);

    // Followers
    public function addCardFollower($cardId, $userId);
    public function removeCardFollower($cardId, $userId);

    // Activities
    public function getCardActivities($cardId);
    public function addCardActivity($cardId, $data);

    // Checklists
    public function addChecklist($cardId, $name);
    public function deleteChecklist($id);
    public function addChecklistItem($checklistId, $name);
    public function updateChecklistItem($id, $data);
    public function deleteChecklistItem($id);

    // Attachments
    public function attachDocumentToCard($cardId, $documentId);
    public function detachDocumentFromCard($cardId, $documentId);
}
