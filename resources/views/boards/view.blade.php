@extends('layouts.boards')

@section('title', $board->name)

@section('content')
<div class="kanban-container">
    {{-- Board Header --}}
    <div class="kanban-header">
        <div class="kanban-header-left">
            <a href="{{ route('boards.index') }}" class="boards-btn boards-btn-ghost">
                <i class="fa fa-arrow-left"></i>
            </a>
            <h1 class="kanban-title">{{ $board->name }}</h1>
            <span class="kanban-visibility-badge kanban-visibility-{{ $board->visibility ?? 'public' }}">
                <i class="fa fa-{{ ($board->visibility ?? 'public') === 'private' ? 'lock' : 'globe' }}"></i>
                {{ ucfirst($board->visibility ?? 'public') }}
            </span>
        </div>
        
        <div class="kanban-header-right">
            {{-- Labels --}}
            <div class="kanban-labels-preview">
                @foreach(($board->labels ?? collect())->take(5) as $label)
                    <span class="kanban-label-dot" style="background: {{ $label->color }}" title="{{ $label->name }}"></span>
                @endforeach
                @if(($board->labels ?? collect())->count() > 5)
                    <span class="kanban-label-more">+{{ ($board->labels ?? collect())->count() - 5 }}</span>
                @endif
            </div>
            
            @if($canEdit ?? false)
            <button class="boards-btn boards-btn-ghost" id="btn-board-settings">
                <i class="fa fa-cog"></i>
            </button>
            @endif
        </div>
    </div>
    
    {{-- Kanban Board --}}
    <div class="kanban-board" id="kanban-board" data-board-id="{{ $board->id }}">
        @foreach($board->columns as $column)
        <div class="kanban-column" data-column-id="{{ $column->id }}" style="{{ $column->color ? 'border-top: 3px solid ' . $column->color . ';' : '' }}">
            <div class="kanban-column-header">
                <h3 class="kanban-column-title">
                    {{ $column->name }}
                    <span class="kanban-column-count">{{ $column->cards->count() }}</span>
                </h3>
                <div class="kanban-column-actions">
                    <button class="kanban-column-menu-btn" data-column-id="{{ $column->id }}">
                        <i class="fa fa-ellipsis-v"></i>
                    </button>
                </div>
            </div>
            
            <div class="kanban-cards-container" data-column-id="{{ $column->id }}">
                @foreach($column->cards as $card)
                <div class="kanban-card" data-card-id="{{ $card->id }}">
                    {{-- Labels --}}
                    @if($card->labels && $card->labels->count() > 0)
                    <div class="kanban-card-labels">
                        @foreach($card->labels as $label)
                            <span class="kanban-card-label" style="background: {{ $label->color }}" title="{{ $label->name }}"></span>
                        @endforeach
                    </div>
                    @endif
                    
                    {{-- Title --}}
                    <div class="kanban-card-title">{{ $card->title }}</div>
                    
                    {{-- Footer --}}
                    <div class="kanban-card-footer">
                        {{-- Assignees --}}
                        <div class="kanban-card-assignees">
                            @foreach(($card->assignees ?? collect())->take(3) as $assignee)
                                @php $assigneeUser = $users->firstWhere('id', $assignee->user_id); @endphp
                                @if($assigneeUser)
                                    @if($assigneeUser->profilePhoto)
                                        <img src="{{ asset('uploads/photos/' . $assigneeUser->profilePhoto) }}" 
                                             alt="{{ $assigneeUser->firstName }}" 
                                             class="kanban-assignee-avatar" 
                                             title="{{ $assigneeUser->firstName }} {{ $assigneeUser->lastName }}">
                                    @else
                                        <div class="kanban-assignee-placeholder" title="{{ $assigneeUser->firstName }} {{ $assigneeUser->lastName }}">
                                            {{ strtoupper(substr($assigneeUser->firstName, 0, 1)) }}
                                        </div>
                                    @endif
                                @endif
                            @endforeach
                            @if(($card->assignees ?? collect())->count() > 3)
                                <span class="kanban-assignee-more">+{{ ($card->assignees ?? collect())->count() - 3 }}</span>
                            @endif
                        </div>
                        
                        {{-- Meta --}}
                        <div class="kanban-card-meta">
                            @if($card->due_date)
                                <span class="kanban-card-due {{ strtotime($card->due_date) < time() ? 'overdue' : '' }}">
                                    <i class="fa fa-calendar"></i>
                                    {{ \Carbon\Carbon::parse($card->due_date)->format('M d') }}
                                </span>
                            @endif
                            
                            {{-- Priority --}}
                            <span class="kanban-card-priority priority-{{ $card->priority ?? 'medium' }}"></span>
                        </div>
                    </div>
                </div>
                @endforeach
            </div>
            
            @if($canManageCards ?? true)
            <div class="kanban-add-card">
                <button class="kanban-add-card-btn" data-column-id="{{ $column->id }}">
                    <i class="fa fa-plus"></i>
                    Add Card
                </button>
            </div>
            @endif
        </div>
        @endforeach
        
        {{-- Add Column --}}
        @if($canEdit ?? false)
        <div class="kanban-add-column">
            <button class="kanban-add-column-btn" id="btn-add-column">
                <i class="fa fa-plus"></i>
                Add Column
            </button>
        </div>
        @endif
    </div>
</div>

{{-- Card Detail Modal --}}
<div class="boards-modal" id="card-detail-modal">
    <div class="boards-modal-backdrop"></div>
    <div class="boards-modal-dialog boards-modal-lg">
        <div class="boards-modal-content">
            <div class="boards-modal-header">
                <h4 class="boards-modal-title" id="card-detail-title">Card Details</h4>
                <button class="boards-modal-close" data-dismiss="modal">&times;</button>
            </div>
            <div class="boards-modal-body" id="card-detail-body">
                {{-- AJAX loaded content --}}
            </div>
        </div>
    </div>
</div>

{{-- Add Card Modal --}}
<div class="boards-modal" id="add-card-modal">
    <div class="boards-modal-backdrop"></div>
    <div class="boards-modal-dialog">
        <div class="boards-modal-content">
            <div class="boards-modal-header">
                <h4 class="boards-modal-title">
                    <i class="fa fa-plus-circle"></i>
                    Add New Card
                </h4>
                <button class="boards-modal-close" data-dismiss="modal">&times;</button>
            </div>
            <div class="boards-modal-body">
                <form id="add-card-form">
                    <input type="hidden" id="add-card-column-id">
                    <div class="boards-form-group">
                        <label for="card-title">Card Title *</label>
                        <input type="text" id="card-title" class="boards-input" placeholder="Enter card title..." required>
                    </div>
                    <div class="boards-form-group">
                        <label for="card-description">Description</label>
                        <textarea id="card-description" class="boards-input" rows="3" placeholder="Optional description..."></textarea>
                    </div>
                    <div class="boards-form-row">
                        <div class="boards-form-group">
                            <label for="card-priority">Priority</label>
                            <select id="card-priority" class="boards-input">
                                <option value="low">Low</option>
                                <option value="medium" selected>Medium</option>
                                <option value="high">High</option>
                                <option value="urgent">Urgent</option>
                            </select>
                        </div>
                        <div class="boards-form-group">
                            <label for="card-due-date">Due Date</label>
                            <input type="date" id="card-due-date" class="boards-input">
                        </div>
                    </div>
                </form>
            </div>
            <div class="boards-modal-footer">
                <button class="boards-btn boards-btn-outline" data-dismiss="modal">Cancel</button>
                <button class="boards-btn boards-btn-primary" id="btn-submit-card">
                    <i class="fa fa-check"></i>
                    Add Card
                </button>
            </div>
        </div>
    </div>
</div>

{{-- Add Column Modal --}}
<div class="boards-modal" id="add-column-modal">
    <div class="boards-modal-backdrop"></div>
    <div class="boards-modal-dialog boards-modal-sm">
        <div class="boards-modal-content">
            <div class="boards-modal-header">
                <h4 class="boards-modal-title">
                    <i class="fa fa-plus"></i>
                    Add Column
                </h4>
                <button class="boards-modal-close" data-dismiss="modal">&times;</button>
            </div>
            <div class="boards-modal-body">
                <div class="boards-form-group">
                    <label for="column-name">Column Name *</label>
                    <input type="text" id="column-name" class="boards-input" placeholder="e.g., To Do, In Progress..." required>
                </div>
                <div class="boards-form-group">
                    <label for="column-color">Color</label>
                    <input type="color" id="column-color" class="boards-input boards-color-input" value="#4a90e2">
                </div>
            </div>
            <div class="boards-modal-footer">
                <button class="boards-btn boards-btn-outline" data-dismiss="modal">Cancel</button>
                <button class="boards-btn boards-btn-primary" id="btn-submit-column">
                    <i class="fa fa-check"></i>
                    Add Column
                </button>
            </div>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script>
$(document).ready(function() {
    const boardId = '{{ $board->id }}';
    
    // Initialize SortableJS for cards
    document.querySelectorAll('.kanban-cards-container').forEach(container => {
        new Sortable(container, {
            group: 'kanban-cards',
            animation: 200,
            ghostClass: 'kanban-card-ghost',
            dragClass: 'kanban-card-drag',
            onEnd: function(evt) {
                const cardId = evt.item.dataset.cardId;
                const columnId = evt.to.dataset.columnId;
                const position = evt.newIndex;
                
                moveCard(cardId, columnId, position);
            }
        });
    });
    
    // Move card API
    function moveCard(cardId, columnId, position) {
        $.ajax({
            url: BoardsConfig.apiUrl + '/boards/' + boardId + '/cards/' + cardId + '/move',
            method: 'PUT',
            headers: {
                'Authorization': 'Bearer ' + BoardsConfig.authToken,
                'Content-Type': 'application/json'
            },
            data: JSON.stringify({
                column_id: columnId,
                card_order: position
            }),
            error: function(xhr) {
                console.error('Move failed:', xhr);
                location.reload();
            }
        });
    }
    
    // Open card detail
    $('.kanban-card').on('click', function() {
        const cardId = $(this).data('card-id');
        // Load card details via AJAX
        $('#card-detail-title').text($(this).find('.kanban-card-title').text());
        $('#card-detail-modal').addClass('show');
    });
    
    // Add card button
    $('.kanban-add-card-btn').on('click', function() {
        const columnId = $(this).data('column-id');
        $('#add-card-column-id').val(columnId);
        $('#add-card-modal').addClass('show');
        $('#card-title').focus();
    });
    
    // Submit new card
    $('#btn-submit-card').on('click', function() {
        const title = $('#card-title').val().trim();
        if (!title) {
            alert('Please enter a card title');
            return;
        }
        
        const columnId = $('#add-card-column-id').val();
        
        $.ajax({
            url: BoardsConfig.apiUrl + '/boards/' + boardId + '/cards',
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + BoardsConfig.authToken,
                'Content-Type': 'application/json'
            },
            data: JSON.stringify({
                column_id: columnId,
                title: title,
                description: $('#card-description').val().trim(),
                priority: $('#card-priority').val(),
                due_date: $('#card-due-date').val() || null
            }),
            success: function() {
                location.reload();
            },
            error: function(xhr) {
                alert('Error: ' + (xhr.responseJSON?.message || 'Failed to create card'));
            }
        });
    });
    
    // Add column button
    $('#btn-add-column').on('click', function() {
        $('#add-column-modal').addClass('show');
        $('#column-name').focus();
    });
    
    // Submit new column
    $('#btn-submit-column').on('click', function() {
        const name = $('#column-name').val().trim();
        if (!name) {
            alert('Please enter a column name');
            return;
        }
        
        $.ajax({
            url: BoardsConfig.apiUrl + '/boards/' + boardId + '/columns',
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + BoardsConfig.authToken,
                'Content-Type': 'application/json'
            },
            data: JSON.stringify({
                name: name,
                color: $('#column-color').val()
            }),
            success: function() {
                location.reload();
            },
            error: function(xhr) {
                alert('Error: ' + (xhr.responseJSON?.message || 'Failed to create column'));
            }
        });
    });
    
    // Close modals
    $('[data-dismiss="modal"], .boards-modal-backdrop').on('click', function() {
        $(this).closest('.boards-modal').removeClass('show');
    });
});
</script>
@endpush
