<?php

namespace App\Repositories\Implementation;

use App\Models\BoardMilestone;
use App\Models\BoardCard;
use App\Repositories\Implementation\BaseRepository;
use App\Repositories\Contracts\BoardMilestoneRepositoryInterface;
use Illuminate\Support\Facades\Auth;
use Ramsey\Uuid\Uuid;

class BoardMilestoneRepository extends BaseRepository implements BoardMilestoneRepositoryInterface
{
    public function __construct()
    {
        parent::__construct();
    }

    public static function model()
    {
        return BoardMilestone::class;
    }

    public function getBoardMilestones($boardId)
    {
        // We include a count of total cards and completed cards to calculate progress on the frontend
        return BoardMilestone::where('boardId', $boardId)
            ->withCount(['cards', 'cards as completed_cards_count' => function($query) {
                $query->where('isCompleted', true);
            }])
            ->get();
    }

    public function createMilestone($boardId, $data)
    {
        return BoardMilestone::create([
            'id' => Uuid::uuid4()->toString(),
            'boardId' => $boardId,
            'name' => $data['name'],
            'color' => $data['color'] ?? '#0079bf',
            'createdBy' => Auth::id(),
            'createdDate' => \Carbon\Carbon::now()
        ]);
    }

    public function updateMilestone($id, $data)
    {
        $milestone = BoardMilestone::findOrFail($id);
        $milestone->update([
            'name' => $data['name'] ?? $milestone->name,
            'color' => $data['color'] ?? $milestone->color,
            'modifiedBy' => Auth::id(),
            'modifiedDate' => \Carbon\Carbon::now()
        ]);
        return $milestone;
    }

    public function deleteMilestone($id)
    {
        $milestone = BoardMilestone::findOrFail($id);
        // Using soft delete pattern if model supports it, but here we fulfill the CRUD requirement
        return $milestone->delete();
    }

    public function syncCardMilestones($cardId, $milestoneIds)
    {
        $card = BoardCard::findOrFail($cardId);
        $card->milestones()->sync($milestoneIds);
        return true;
    }
}
