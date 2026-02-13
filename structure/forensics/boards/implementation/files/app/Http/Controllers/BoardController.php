<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\Contracts\BoardRepositoryInterface;
use Illuminate\Support\Facades\Validator;

class BoardController extends Controller
{
    private $boardRepository;

    public function __construct(BoardRepositoryInterface $boardRepository)
    {
        $this->boardRepository = $boardRepository;
    }

    // ========== BOARDS ==========

    public function index(Request $request)
    {
        $queryString = (object) $request->all();
        $boards = $this->boardRepository->getBoards($queryString);
        $count = $this->boardRepository->getBoardsCount($queryString);

        return response()->json($boards)
            ->withHeaders([
                'totalCount' => $count,
                'pageSize' => $queryString->pageSize ?? count($boards),
                'skip' => $queryString->skip ?? 0,
            ]);
    }

    public function show($id)
    {
        $board = $this->boardRepository->getBoardWithDetails($id);
        if (!$board) {
            return response()->json(['message' => 'Board not found'], 404);
        }
        return response()->json($board);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'max:255'],
        ]);

        if ($validator->fails()) {
            return response()->json($validator->messages(), 422);
        }

        $board = $this->boardRepository->createBoard($request->all());
        return response()->json($board, 201);
    }

    public function update(Request $request, $id)
    {
        $board = $this->boardRepository->updateBoard($id, $request->all());
        return response()->json($board);
    }

    public function destroy($id)
    {
        $this->boardRepository->deleteBoard($id);
        return response()->json(['message' => 'Board deleted successfully']);
    }

    // ========== COLUMNS ==========

    public function storeColumn(Request $request, $boardId)
    {
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'max:255'],
        ]);

        if ($validator->fails()) {
            return response()->json($validator->messages(), 422);
        }

        $column = $this->boardRepository->createColumn($boardId, $request->all());
        return response()->json($column, 201);
    }

    public function updateColumn(Request $request, $id)
    {
        $column = $this->boardRepository->updateColumn($id, $request->all());
        return response()->json($column);
    }

    public function destroyColumn($id)
    {
        $this->boardRepository->deleteColumn($id);
        return response()->json(['message' => 'Column deleted successfully']);
    }

    public function reorderColumns(Request $request, $boardId)
    {
        $this->boardRepository->reorderColumns($boardId, $request->columns);
        return response()->json(['message' => 'Columns reordered successfully']);
    }

    // ========== CARDS ==========

    public function storeCard(Request $request, $columnId)
    {
        $validator = Validator::make($request->all(), [
            'title' => ['required', 'max:255'],
        ]);

        if ($validator->fails()) {
            return response()->json($validator->messages(), 422);
        }

        $card = $this->boardRepository->createCard($columnId, $request->all());
        return response()->json($card, 201);
    }

    public function showCard($id)
    {
        $card = $this->boardRepository->getCardWithDetails($id);
        if (!$card) {
            return response()->json(['message' => 'Card not found'], 404);
        }
        return response()->json($card);
    }

    public function updateCard(Request $request, $id)
    {
        $card = $this->boardRepository->updateCard($id, $request->all());
        return response()->json($card);
    }

    public function destroyCard($id)
    {
        $this->boardRepository->deleteCard($id);
        return response()->json(['message' => 'Card deleted successfully']);
    }

    public function moveCard(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'columnId' => ['required'],
            'position' => ['required', 'integer'],
        ]);

        if ($validator->fails()) {
            return response()->json($validator->messages(), 422);
        }

        $card = $this->boardRepository->moveCard($id, $request->columnId, $request->position);
        return response()->json($card);
    }

    public function archiveCard($id)
    {
        $card = $this->boardRepository->archiveCard($id);
        return response()->json($card);
    }

    public function restoreCard($id)
    {
        $card = $this->boardRepository->restoreCard($id);
        return response()->json($card);
    }

    public function getArchivedCards($boardId)
    {
        $cards = $this->boardRepository->getArchivedCards($boardId);
        return response()->json($cards);
    }

    // ========== ASSIGNEES ==========

    public function addAssignee(Request $request, $cardId)
    {
        $this->boardRepository->addCardAssignee($cardId, $request->userId);
        return response()->json(['message' => 'Assignee added successfully']);
    }

    public function removeAssignee($cardId, $userId)
    {
        $this->boardRepository->removeCardAssignee($cardId, $userId);
        return response()->json(['message' => 'Assignee removed successfully']);
    }

    // ========== LABELS ==========

    public function storeLabel(Request $request, $boardId)
    {
        $label = $this->boardRepository->createLabel($boardId, $request->all());
        return response()->json($label, 201);
    }

    public function updateLabel(Request $request, $id)
    {
        $label = $this->boardRepository->updateLabel($id, $request->all());
        return response()->json($label);
    }

    public function destroyLabel($id)
    {
        $this->boardRepository->deleteLabel($id);
        return response()->json(['message' => 'Label deleted successfully']);
    }

    public function addCardLabel(Request $request, $cardId)
    {
        $this->boardRepository->addCardLabel($cardId, $request->labelId);
        return response()->json(['message' => 'Label added to card']);
    }

    public function removeCardLabel($cardId, $labelId)
    {
        $this->boardRepository->removeCardLabel($cardId, $labelId);
        return response()->json(['message' => 'Label removed from card']);
    }

    public function getBoardLabels($boardId)
    {
        $labels = $this->boardRepository->getBoardLabels($boardId);
        return response()->json($labels);
    }

    // ========== ATTACHMENTS ==========

    public function attachDocument(Request $request, $cardId)
    {
        $this->boardRepository->attachDocumentToCard($cardId, $request->documentId);
        return response()->json(['message' => 'Document attached to card']);
    }

    public function detachDocument($cardId, $documentId)
    {
        $this->boardRepository->detachDocumentFromCard($cardId, $documentId);
        return response()->json(['message' => 'Document detached from card']);
    }

    // ========== TAGS ==========
    public function getBoardTags($boardId)
    {
        $tags = $this->boardRepository->getBoardTags($boardId);
        return response()->json($tags);
    }

    public function storeBoardTag(Request $request, $boardId)
    {
        $tag = $this->boardRepository->createBoardTag($boardId, $request->all());
        return response()->json($tag, 201);
    }

    public function updateBoardTag(Request $request, $id)
    {
        $tag = $this->boardRepository->updateBoardTag($id, $request->all());
        return response()->json($tag);
    }

    public function destroyBoardTag($id)
    {
        $this->boardRepository->deleteBoardTag($id);
        return response()->json(['message' => 'Tag deleted successfully']);
    }

    public function addCardTag(Request $request, $cardId)
    {
        $this->boardRepository->addCardTag($cardId, $request->tagId);
        return response()->json(['message' => 'Tag added to card']);
    }

    public function removeCardTag($cardId, $tagId)
    {
        $this->boardRepository->removeCardTag($cardId, $tagId);
        return response()->json(['message' => 'Tag removed from card']);
    }

    // ========== FOLLOWERS ==========

    public function addCardFollower(Request $request, $cardId)
    {
        $this->boardRepository->addCardFollower($cardId, $request->userId);
        return response()->json(['message' => 'Follower added successfully']);
    }

    public function removeCardFollower($cardId, $userId)
    {
        $this->boardRepository->removeCardFollower($cardId, $userId);
        return response()->json(['message' => 'Follower removed successfully']);
    }

    // ========== ACTIVITIES ==========

    public function getCardActivities($cardId)
    {
        $activities = $this->boardRepository->getCardActivities($cardId);
        return response()->json($activities);
    }

    public function storeCardActivity(Request $request, $cardId)
    {
        $activity = $this->boardRepository->addCardActivity($cardId, $request->all());
        return response()->json($activity, 201);
    }

    // ========== CHECKLISTS ==========

    public function storeChecklist(Request $request, $cardId)
    {
        $checklist = $this->boardRepository->addChecklist($cardId, $request->name);
        return response()->json($checklist, 201);
    }

    public function destroyChecklist($id)
    {
        $this->boardRepository->deleteChecklist($id);
        return response()->json(['success' => true]);
    }

    public function storeChecklistItem(Request $request, $checklistId)
    {
        $item = $this->boardRepository->addChecklistItem($checklistId, $request->name);
        return response()->json($item, 201);
    }

    public function updateChecklistItem(Request $request, $id)
    {
        $item = $this->boardRepository->updateChecklistItem($id, $request->all());
        return response()->json($item);
    }

    public function destroyChecklistItem($id)
    {
        $this->boardRepository->deleteChecklistItem($id);
        return response()->json(['success' => true]);
    }
}
