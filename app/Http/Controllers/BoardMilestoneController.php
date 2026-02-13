<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\Contracts\BoardMilestoneRepositoryInterface;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;

class BoardMilestoneController extends Controller
{
    private $milestoneRepository;

    public function __construct(BoardMilestoneRepositoryInterface $milestoneRepository)
    {
        $this->milestoneRepository = $milestoneRepository;
    }

    public function index($boardId)
    {
        try {
            return response()->json($this->milestoneRepository->getBoardMilestones($boardId));
        } catch (\Throwable $e) {
            Log::error('Unable to load board milestones.', [
                'boardId' => $boardId,
                'error' => $e->getMessage(),
            ]);

            return response()->json([
                'message' => 'Unable to load board milestones. Ensure board milestone schema is installed correctly.',
            ], 500);
        }
    }

    public function store(Request $request, $boardId)
    {
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'max:255'],
        ]);

        if ($validator->fails()) {
            return response()->json($validator->messages(), 422);
        }

        $milestone = $this->milestoneRepository->createMilestone($boardId, $request->all());
        return response()->json($milestone, 201);
    }

    public function update(Request $request, $id)
    {
        $milestone = $this->milestoneRepository->updateMilestone($id, $request->all());
        return response()->json($milestone);
    }

    public function destroy($id)
    {
        $this->milestoneRepository->deleteMilestone($id);
        return response()->json(['success' => true]);
    }

    public function syncCardMilestones(Request $request, $cardId)
    {
        $this->milestoneRepository->syncCardMilestones($cardId, $request->milestoneIds);
        return response()->json(['success' => true]);
    }
}
