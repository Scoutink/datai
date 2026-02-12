<?php

namespace App\Http\Controllers;

use App\Models\Board;
use App\Models\BoardColumn;
use App\Models\BoardCard;
use App\Repositories\Contracts\CompanyProfileRepositoryInterface;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

/**
 * Controller for Boards Blade views (standalone pages)
 * Handles server-side rendering of Kanban boards
 */
class BoardsViewController extends Controller
{
    protected $companyProfileRepository;

    public function __construct(CompanyProfileRepositoryInterface $companyProfileRepository)
    {
        $this->companyProfileRepository = $companyProfileRepository;
    }

    /**
     * Display list of all boards
     */
    public function index(Request $request)
    {
        $user = $request->auth_user;
        $claims = $request->auth_claims ?? [];
        
        // Get boards (respect soft deletes)
        $boards = Board::where('is_deleted', false)
            ->orderBy('created_date', 'desc')
            ->get();
        
        // Get company profile for theming
        $companyProfile = $this->companyProfileRepository->getCompanyProfile();
        
        // Get languages for translation
        $languages = DB::table('languages')->where('isDeleted', false)->get();
        $currentLang = session('locale', 'en');
        
        return view('boards.index', compact(
            'boards', 
            'user', 
            'claims', 
            'companyProfile',
            'languages',
            'currentLang'
        ));
    }

    /**
     * Display a single board with columns and cards
     */
    public function view(Request $request, $id)
    {
        $user = $request->auth_user;
        $claims = $request->auth_claims ?? [];
        
        // Get board with all relations
        $board = Board::with([
            'columns' => function($query) {
                $query->where('is_deleted', false)
                      ->orderBy('list_order', 'asc');
            },
            'columns.cards' => function($query) {
                $query->where('is_deleted', false)
                      ->orderBy('card_order', 'asc');
            },
            'columns.cards.assignees',
            'labels' => function($query) {
                $query->where('is_deleted', false);
            }
        ])->where('is_deleted', false)->findOrFail($id);
        
        // Get company profile for theming
        $companyProfile = $this->companyProfileRepository->getCompanyProfile();
        
        // Get all users for assignee dropdown
        $users = DB::table('users')
            ->where('isDeleted', false)
            ->select('id', 'firstName', 'lastName', 'email', 'profilePhoto')
            ->get();
        
        // Get languages
        $languages = DB::table('languages')->where('isDeleted', false)->get();
        $currentLang = session('locale', 'en');
        
        // Check permissions for different actions
        $canEdit = in_array('BOARDS_EDIT_BOARDS', $claims);
        $canDelete = in_array('BOARDS_DELETE_BOARDS', $claims);
        $canManageCards = in_array('BOARDS_MANAGE_CARDS', $claims);
        
        return view('boards.view', compact(
            'board',
            'user',
            'claims',
            'users',
            'companyProfile',
            'languages',
            'currentLang',
            'canEdit',
            'canDelete',
            'canManageCards'
        ));
    }

    /**
     * Helper: Check if user has a specific claim
     */
    protected function hasClaim($claims, $claim)
    {
        return in_array($claim, $claims);
    }
}
