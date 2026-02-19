@extends('layouts.boards')

@section('title', 'All Boards')

@section('content')
<div class="boards-container">
    {{-- Header --}}
    <div class="boards-header">
        <div class="boards-header-left">
            <h1 class="boards-title">
                <i class="fa fa-columns"></i>
                My Boards
            </h1>
            <p class="boards-subtitle">Manage your Kanban boards and projects</p>
        </div>
        
        @if(in_array('BOARDS_CREATE_BOARDS', $claims ?? []))
        <div class="boards-header-right">
            <button class="boards-btn boards-btn-primary" id="btn-create-board">
                <i class="fa fa-plus"></i>
                <span>Create Board</span>
            </button>
        </div>
        @endif
    </div>
    
    {{-- Boards Grid --}}
    <div class="boards-grid">
        @forelse($boards as $board)
            <div class="board-card" data-board-id="{{ $board->id }}">
                <div class="board-card-header" style="background: linear-gradient(135deg, {{ $board->color ?? '#6366f1' }}, {{ $board->color ?? '#8b5cf6' }}99);">
                    <div class="board-card-visibility">
                        <i class="fa fa-{{ $board->visibility === 'private' ? 'lock' : 'globe' }}"></i>
                        {{ ucfirst($board->visibility ?? 'public') }}
                    </div>
                </div>
                
                <div class="board-card-body">
                    <h3 class="board-card-title">{{ $board->name }}</h3>
                    @if($board->description)
                        <p class="board-card-description">{{ Str::limit($board->description, 100) }}</p>
                    @endif
                    
                    <div class="board-card-stats">
                        <span class="board-stat">
                            <i class="fa fa-columns"></i>
                            {{ $board->columns_count ?? 0 }} columns
                        </span>
                        <span class="board-stat">
                            <i class="fa fa-sticky-note"></i>
                            {{ $board->cards_count ?? 0 }} cards
                        </span>
                    </div>
                </div>
                
                <div class="board-card-footer">
                    <a href="{{ route('boards.view', $board->id) }}" class="boards-btn boards-btn-primary boards-btn-block">
                        <i class="fa fa-external-link-alt"></i>
                        Open Board
                    </a>
                </div>
            </div>
        @empty
            <div class="boards-empty-state">
                <div class="boards-empty-icon">
                    <i class="fa fa-th-large"></i>
                </div>
                <h3>No Boards Yet</h3>
                <p>Create your first board to start organizing your work</p>
                @if(in_array('BOARDS_CREATE_BOARDS', $claims ?? []))
                    <button class="boards-btn boards-btn-primary" id="btn-create-board-empty">
                        <i class="fa fa-plus"></i>
                        Create Your First Board
                    </button>
                @endif
            </div>
        @endforelse
    </div>
</div>

{{-- Create Board Modal --}}
<div class="boards-modal" id="create-board-modal">
    <div class="boards-modal-backdrop"></div>
    <div class="boards-modal-dialog">
        <div class="boards-modal-content">
            <div class="boards-modal-header">
                <h4 class="boards-modal-title">
                    <i class="fa fa-plus-circle"></i>
                    Create New Board
                </h4>
                <button class="boards-modal-close" data-dismiss="modal">&times;</button>
            </div>
            <div class="boards-modal-body">
                <form id="create-board-form">
                    <div class="boards-form-group">
                        <label for="board-name">Board Name *</label>
                        <input type="text" id="board-name" class="boards-input" placeholder="Enter board name..." required>
                    </div>
                    
                    <div class="boards-form-group">
                        <label for="board-description">Description</label>
                        <textarea id="board-description" class="boards-input" rows="3" placeholder="Optional description..."></textarea>
                    </div>
                    
                    <div class="boards-form-row">
                        <div class="boards-form-group">
                            <label for="board-color">Color</label>
                            <input type="color" id="board-color" class="boards-input boards-color-input" value="#6366f1">
                        </div>
                        
                        <div class="boards-form-group">
                            <label for="board-visibility">Visibility</label>
                            <select id="board-visibility" class="boards-input">
                                <option value="public">Public (Everyone)</option>
                                <option value="private">Private (Invite Only)</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="boards-modal-footer">
                <button class="boards-btn boards-btn-outline" data-dismiss="modal">Cancel</button>
                <button class="boards-btn boards-btn-primary" id="btn-submit-board">
                    <i class="fa fa-check"></i>
                    Create Board
                </button>
            </div>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script>
$(document).ready(function() {
    // Open create modal
    $('#btn-create-board, #btn-create-board-empty').on('click', function() {
        $('#create-board-modal').addClass('show');
    });
    
    // Close modal
    $('[data-dismiss="modal"], .boards-modal-backdrop').on('click', function() {
        $(this).closest('.boards-modal').removeClass('show');
    });
    
    // Submit new board
    $('#btn-submit-board').on('click', function() {
        const name = $('#board-name').val().trim();
        if (!name) {
            alert('Please enter a board name');
            return;
        }
        
        const data = {
            name: name,
            description: $('#board-description').val().trim(),
            color: $('#board-color').val(),
            visibility: $('#board-visibility').val()
        };
        
        $.ajax({
            url: BoardsConfig.apiUrl + '/boards',
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + BoardsConfig.authToken,
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': BoardsConfig.csrfToken
            },
            data: JSON.stringify(data),
            success: function(response) {
                window.location.href = '{{ route("boards.view", "") }}/' + response.id;
            },
            error: function(xhr) {
                alert('Error creating board: ' + (xhr.responseJSON?.message || 'Unknown error'));
            }
        });
    });
    
    // Open board on card click
    $('.board-card').on('click', function(e) {
        if ($(e.target).closest('.boards-btn').length) return;
        const boardId = $(this).data('board-id');
        window.location.href = '{{ route("boards.view", "") }}/' + boardId;
    });
});
</script>
@endpush
