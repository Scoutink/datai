<?php

namespace App\Repositories\Implementation;

use App\Models\Board;
use App\Models\BoardColumn;
use App\Models\BoardCard;
use App\Models\BoardCardAssignee;
use App\Models\BoardLabel;
use App\Models\BoardCardLabel;
use App\Models\BoardCardAttachment;
use App\Models\BoardCardActivity;
use App\Models\BoardTag;
use App\Models\BoardCardTag;
use App\Models\BoardCardFollower;
use App\Models\BoardCardChecklist;
use App\Models\BoardCardChecklistItem;
use App\Models\Users;
use App\Models\Documents;
use App\Repositories\Implementation\BaseRepository;
use App\Repositories\Contracts\BoardRepositoryInterface;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Ramsey\Uuid\Uuid;

class BoardRepository extends BaseRepository implements BoardRepositoryInterface
{
    public function __construct()
    {
        parent::__construct();
    }

    public static function model()
    {
        return Board::class;
    }

    // ========== BOARDS ==========

    public function getBoards($attributes)
    {
        $query = Board::with(['creator:id,firstName,lastName,email'])
            ->select('boards.*');

        // Search filter
        if (!empty($attributes->searchQuery)) {
            $query->where(function($q) use ($attributes) {
                $q->where('name', 'LIKE', '%' . $attributes->searchQuery . '%')
                  ->orWhere('description', 'LIKE', '%' . $attributes->searchQuery . '%');
            });
        }

        // Sorting
        $orderBy = $attributes->orderBy ?? 'createdDate';
        $order = $attributes->order ?? 'desc';
        $query->orderBy($orderBy, $order);

        // Pagination
        if (!empty($attributes->skip) && !empty($attributes->pageSize)) {
            $query->skip($attributes->skip)->take($attributes->pageSize);
        }

        return $query->get();
    }

    public function getBoardsCount($attributes)
    {
        $query = Board::query();

        if (!empty($attributes->searchQuery)) {
            $query->where(function($q) use ($attributes) {
                $q->where('name', 'LIKE', '%' . $attributes->searchQuery . '%')
                  ->orWhere('description', 'LIKE', '%' . $attributes->searchQuery . '%');
            });
        }

        return $query->count();
    }

    public function getBoardWithDetails($id)
    {
        return Board::with([
            'columns' => function($q) {
                $q->orderBy('position');
            },
            'columns.cards' => function($q) {
                $q->orderBy('position');
            },
            'columns.cards.assignees:id,firstName,lastName,email',
            'columns.cards.labels',
            'columns.cards.document:id,name',
            'labels',
            'creator:id,firstName,lastName,email'
        ])->find($id);
    }

    public function createBoard($data)
    {
        $board = Board::create([
            'name' => $data['name'],
            'description' => $data['description'] ?? null,
            'isPublic' => $data['isPublic'] ?? false,
            'backgroundColor' => $data['backgroundColor'] ?? '#f4f5f7',
            'isDeleted' => false
        ]);

        // Create default columns
        $defaultColumns = ['To Do', 'In Progress', 'Done'];
        foreach ($defaultColumns as $index => $name) {
            BoardColumn::create([
                'boardId' => $board->id,
                'name' => $name,
                'position' => $index,
                'isDeleted' => false
            ]);
        }

        // Create default labels
        $defaultLabels = [
            ['name' => 'Priority', 'color' => '#eb5a46'],
            ['name' => 'Bug', 'color' => '#c377e0'],
            ['name' => 'Feature', 'color' => '#61bd4f'],
            ['name' => 'Review', 'color' => '#f2d600'],
        ];
        foreach ($defaultLabels as $label) {
            BoardLabel::create([
                'boardId' => $board->id,
                'name' => $label['name'],
                'color' => $label['color']
            ]);
        }

        // Create default tags
        $defaultTags = [
            ['name' => 'High Priority', 'color' => '#eb5a46'],
            ['name' => 'Design', 'color' => '#0079bf'],
            ['name' => 'Frontend', 'color' => '#61bd4f'],
            ['name' => 'Backend', 'color' => '#ff9f1a'],
        ];
        foreach ($defaultTags as $tag) {
            BoardTag::create([
                'id' => Uuid::uuid4()->toString(),
                'boardId' => $board->id,
                'name' => $tag['name'],
                'color' => $tag['color'],
                'createdDate' => now()
            ]);
        }

        return $this->getBoardWithDetails($board->id);
    }

    public function updateBoard($id, $data)
    {
        $board = Board::findOrFail($id);
        $board->update([
            'name' => $data['name'] ?? $board->name,
            'description' => $data['description'] ?? $board->description,
            'isPublic' => $data['isPublic'] ?? $board->isPublic,
            'backgroundColor' => $data['backgroundColor'] ?? $board->backgroundColor,
        ]);
        return $board;
    }

    public function deleteBoard($id)
    {
        $board = Board::findOrFail($id);
        $userId = Auth::id();
        $board->update(['isDeleted' => true, 'deletedBy' => $userId]);
        $board->delete();
        return true;
    }

    // ========== COLUMNS ==========

    public function createColumn($boardId, $data)
    {
        $maxPosition = BoardColumn::where('boardId', $boardId)->max('position') ?? -1;
        
        return BoardColumn::create([
            'boardId' => $boardId,
            'name' => $data['name'],
            'position' => $maxPosition + 1,
            'color' => $data['color'] ?? '#e2e4e6',
            'wipLimit' => $data['wipLimit'] ?? null,
            'isDeleted' => false
        ]);
    }

    public function updateColumn($id, $data)
    {
        $column = BoardColumn::findOrFail($id);
        $column->update([
            'name' => $data['name'] ?? $column->name,
            'color' => $data['color'] ?? $column->color,
            'wipLimit' => $data['wipLimit'] ?? $column->wipLimit,
        ]);
        return $column;
    }

    public function deleteColumn($id)
    {
        $column = BoardColumn::findOrFail($id);
        $userId = Auth::id();
        $column->update(['isDeleted' => true, 'deletedBy' => $userId]);
        $column->delete();
        return true;
    }

    public function reorderColumns($boardId, $columns)
    {
        foreach ($columns as $index => $columnId) {
            BoardColumn::where('id', $columnId)->update(['position' => $index]);
        }
        return true;
    }

    // ========== CARDS ==========

    public function createCard($columnId, $data)
    {
        $column = BoardColumn::findOrFail($columnId);
        $maxPosition = BoardCard::where('columnId', $columnId)->max('position') ?? -1;
        
        return BoardCard::create([
            'columnId' => $columnId,
            'boardId' => $column->boardId,
            'title' => $data['title'],
            'description' => $data['description'] ?? null,
            'position' => $maxPosition + 1,
            'priority' => $data['priority'] ?? 'medium',
            'dueDate' => $data['dueDate'] ?? null,
            'documentId' => $data['documentId'] ?? null,
            'coverColor' => $data['coverColor'] ?? null,
            'isArchived' => false,
            'isDeleted' => false
        ]);
    }

    public function getCardWithDetails($id)
    {
        return BoardCard::with(['assignees', 'labels', 'executor', 'approver', 'supervisor', 'followers', 'tags', 'attachments', 'activities.user', 'checklists.items'])
            ->findOrFail($id);
    }

    public function updateCard($id, $data)
    {
        $card = BoardCard::findOrFail($id);
        $card->update([
            'title' => $data['title'] ?? $card->title,
            'description' => $data['description'] ?? $card->description,
            'htmlDescription' => $data['htmlDescription'] ?? $card->htmlDescription,
            'priority' => $data['priority'] ?? $card->priority,
            'dueDate' => $data['dueDate'] ?? $card->dueDate,
            'documentId' => $data['documentId'] ?? $card->documentId,
            'coverColor' => $data['coverColor'] ?? $card->coverColor,
            'isCompleted' => array_key_exists('isCompleted', $data) ? $data['isCompleted'] : $card->isCompleted,
            'executorId' => array_key_exists('executorId', $data) ? $data['executorId'] : $card->executorId,
            'approverId' => array_key_exists('approverId', $data) ? $data['approverId'] : $card->approverId,
            'supervisorId' => array_key_exists('supervisorId', $data) ? $data['supervisorId'] : $card->supervisorId,
            'parentCardId' => array_key_exists('parentCardId', $data) ? $data['parentCardId'] : $card->parentCardId,
        ]);
        return $this->getCardWithDetails($id);
    }

    public function deleteCard($id)
    {
        $card = BoardCard::findOrFail($id);
        $userId = Auth::id();
        $card->update(['isDeleted' => true, 'deletedBy' => $userId]);
        $card->delete();
        return true;
    }

    public function moveCard($id, $columnId, $position)
    {
        $card = BoardCard::findOrFail($id);
        $oldColumnId = $card->columnId;
        $oldPosition = $card->position;
        $column = BoardColumn::findOrFail($columnId);

        DB::transaction(function() use ($card, $columnId, $position, $oldColumnId, $oldPosition, $column) {
            // If moving within the same column
            if ($oldColumnId == $columnId) {
                if ($position > $oldPosition) {
                    BoardCard::where('columnId', $columnId)
                        ->where('position', '>', $oldPosition)
                        ->where('position', '<=', $position)
                        ->decrement('position');
                } else {
                    BoardCard::where('columnId', $columnId)
                        ->where('position', '>=', $position)
                        ->where('position', '<', $oldPosition)
                        ->increment('position');
                }
            } else {
                // Moving to different column
                // Decrease positions in old column
                BoardCard::where('columnId', $oldColumnId)
                    ->where('position', '>', $oldPosition)
                    ->decrement('position');

                // Increase positions in new column
                BoardCard::where('columnId', $columnId)
                    ->where('position', '>=', $position)
                    ->increment('position');
            }

            // Update the card
            $card->update([
                'columnId' => $columnId,
                'boardId' => $column->boardId,
                'position' => $position
            ]);
        });

        return $this->getCardWithDetails($id);
    }

    public function archiveCard($id)
    {
        $card = BoardCard::findOrFail($id);
        $card->update(['isArchived' => true]);
        return $card;
    }

    public function restoreCard($id)
    {
        $card = BoardCard::withoutGlobalScope('isArchived')->findOrFail($id);
        $card->update(['isArchived' => false]);
        return $card;
    }

    public function getArchivedCards($boardId)
    {
        return BoardCard::withoutGlobalScope('isArchived')
            ->where('boardId', $boardId)
            ->where('isArchived', true)
            ->with(['column'])
            ->get();
    }

    // ========== ASSIGNEES ==========

    public function addCardAssignee($cardId, $userId)
    {
        // Check if already assigned
        $exists = BoardCardAssignee::where('cardId', $cardId)
            ->where('userId', $userId)
            ->exists();

        if (!$exists) {
            BoardCardAssignee::create([
                'cardId' => $cardId,
                'userId' => $userId
            ]);
        }
        return true;
    }

    public function removeCardAssignee($cardId, $userId)
    {
        BoardCardAssignee::where('cardId', $cardId)
            ->where('userId', $userId)
            ->delete();
        return true;
    }

    // ========== LABELS ==========

    public function createLabel($boardId, $data)
    {
        return BoardLabel::create([
            'boardId' => $boardId,
            'name' => $data['name'],
            'color' => $data['color'] ?? '#61bd4f'
        ]);
    }

    public function updateLabel($id, $data)
    {
        $label = BoardLabel::findOrFail($id);
        $label->update([
            'name' => $data['name'] ?? $label->name,
            'color' => $data['color'] ?? $label->color,
        ]);
        return $label;
    }

    public function deleteLabel($id)
    {
        BoardLabel::findOrFail($id)->delete();
        return true;
    }

    public function addCardLabel($cardId, $labelId)
    {
        $exists = BoardCardLabel::where('cardId', $cardId)
            ->where('labelId', $labelId)
            ->exists();

        if (!$exists) {
            BoardCardLabel::create([
                'cardId' => $cardId,
                'labelId' => $labelId
            ]);
        }
        return true;
    }

    public function removeCardLabel($cardId, $labelId)
    {
        BoardCardLabel::where('cardId', $cardId)->where('labelId', $labelId)->delete();
    }

    public function getBoardLabels($boardId)
    {
        return BoardLabel::where('boardId', $boardId)->get();
    }

    // ========== ATTACHMENTS ==========

    public function attachDocumentToCard($cardId, $documentId)
    {
        $exists = BoardCardAttachment::where('cardId', $cardId)
            ->where('documentId', $documentId)
            ->exists();

        if (!$exists) {
            BoardCardAttachment::create([
                'cardId' => $cardId,
                'documentId' => $documentId,
                'createdDate' => now()
            ]);
        }
    }

    public function detachDocumentFromCard($cardId, $documentId)
    {
        BoardCardAttachment::where('cardId', $cardId)
            ->where('documentId', $documentId)
            ->delete();
    }

    // Tags
    public function getBoardTags($boardId)
    {
        return BoardTag::where('boardId', $boardId)->get();
    }

    public function createBoardTag($boardId, $data)
    {
        $data['boardId'] = $boardId;
        $data['id'] = Uuid::uuid4()->toString();
        $data['createdDate'] = now();
        return BoardTag::create($data);
    }

    public function updateBoardTag($id, $data)
    {
        $tag = BoardTag::findOrFail($id);
        $tag->update($data);
        return $tag;
    }

    public function deleteBoardTag($id)
    {
        BoardTag::where('id', $id)->delete();
    }

    public function addCardTag($cardId, $tagId)
    {
        BoardCardTag::create([
            'id' => Uuid::uuid4()->toString(),
            'cardId' => $cardId,
            'tagId' => $tagId
        ]);
    }

    public function removeCardTag($cardId, $tagId)
    {
        BoardCardTag::where('cardId', $cardId)->where('tagId', $tagId)->delete();
    }

    // Followers
    public function addCardFollower($cardId, $userId)
    {
        BoardCardFollower::create([
            'id' => Uuid::uuid4()->toString(),
            'cardId' => $cardId,
            'userId' => $userId,
            'createdDate' => now()
        ]);
    }

    public function removeCardFollower($cardId, $userId)
    {
        BoardCardFollower::where('cardId', $cardId)->where('userId', $userId)->delete();
    }

    // ========== CHECKLISTS ==========

    public function addChecklist($cardId, $name)
    {
        return BoardCardChecklist::create([
            'cardId' => $cardId,
            'name' => $name
        ]);
    }

    public function deleteChecklist($id)
    {
        return BoardCardChecklist::destroy($id);
    }

    public function addChecklistItem($checklistId, $name)
    {
        $maxPos = BoardCardChecklistItem::where('checklistId', $checklistId)->max('position') ?? -1;
        return BoardCardChecklistItem::create([
            'checklistId' => $checklistId,
            'name' => $name,
            'position' => $maxPos + 1
        ]);
    }

    public function updateChecklistItem($id, $data)
    {
        $item = BoardCardChecklistItem::findOrFail($id);
        $item->update($data);
        return $item;
    }

    public function deleteChecklistItem($id)
    {
        return BoardCardChecklistItem::destroy($id);
    }

    // Activities
    public function getCardActivities($cardId)
    {
        return BoardCardActivity::with('user')
            ->where('cardId', $cardId)
            ->orderBy('createdDate', 'desc')
            ->get();
    }

    public function addCardActivity($cardId, $data)
    {
        $data['id'] = Uuid::uuid4()->toString();
        $data['cardId'] = $cardId;
        if (Auth::check()) {
            $data['userId'] = Auth::id();
        }
        $data['createdDate'] = now();
        return BoardCardActivity::create($data);
    }
}
