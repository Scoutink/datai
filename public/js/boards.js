/**
 * Datai Boards - Core JavaScript Module
 * Handles API communication and UI interactions
 */

const Boards = {
    config: null,

    /**
     * Initialize the Boards module
     */
    init() {
        this.config = window.BoardsConfig || {};
        this.bindGlobalEvents();
        console.log('Boards initialized', this.config);
    },

    /**
     * Make API request with authentication
     */
    async api(endpoint, options = {}) {
        const url = this.config.apiUrl + endpoint;

        const defaultOptions = {
            headers: {
                'Authorization': 'Bearer ' + this.config.authToken,
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'X-CSRF-TOKEN': this.config.csrfToken
            }
        };

        const mergedOptions = {
            ...defaultOptions,
            ...options,
            headers: {
                ...defaultOptions.headers,
                ...(options.headers || {})
            }
        };

        if (options.body && typeof options.body === 'object') {
            mergedOptions.body = JSON.stringify(options.body);
        }

        try {
            const response = await fetch(url, mergedOptions);

            if (!response.ok) {
                const error = await response.json().catch(() => ({ message: 'Request failed' }));
                throw new Error(error.message || `HTTP ${response.status}`);
            }

            return await response.json();
        } catch (error) {
            console.error('API Error:', error);
            throw error;
        }
    },

    /**
     * Create a new board
     */
    async createBoard(data) {
        return this.api('/boards', {
            method: 'POST',
            body: data
        });
    },

    /**
     * Update a board
     */
    async updateBoard(boardId, data) {
        return this.api('/boards/' + boardId, {
            method: 'PUT',
            body: data
        });
    },

    /**
     * Delete a board
     */
    async deleteBoard(boardId) {
        return this.api('/boards/' + boardId, {
            method: 'DELETE'
        });
    },

    /**
     * Create a column
     */
    async createColumn(boardId, data) {
        return this.api('/boards/' + boardId + '/columns', {
            method: 'POST',
            body: data
        });
    },

    /**
     * Update a column
     */
    async updateColumn(boardId, columnId, data) {
        return this.api('/boards/' + boardId + '/columns/' + columnId, {
            method: 'PUT',
            body: data
        });
    },

    /**
     * Delete a column
     */
    async deleteColumn(boardId, columnId) {
        return this.api('/boards/' + boardId + '/columns/' + columnId, {
            method: 'DELETE'
        });
    },

    /**
     * Create a card
     */
    async createCard(boardId, data) {
        return this.api('/boards/' + boardId + '/cards', {
            method: 'POST',
            body: data
        });
    },

    /**
     * Update a card
     */
    async updateCard(boardId, cardId, data) {
        return this.api('/boards/' + boardId + '/cards/' + cardId, {
            method: 'PUT',
            body: data
        });
    },

    /**
     * Move a card
     */
    async moveCard(boardId, cardId, columnId, position) {
        return this.api('/boards/' + boardId + '/cards/' + cardId + '/move', {
            method: 'PUT',
            body: {
                column_id: columnId,
                card_order: position
            }
        });
    },

    /**
     * Delete a card
     */
    async deleteCard(boardId, cardId) {
        return this.api('/boards/' + boardId + '/cards/' + cardId, {
            method: 'DELETE'
        });
    },

    /**
     * Bind global UI events
     */
    bindGlobalEvents() {
        // Close alerts
        $(document).on('click', '.boards-alert-close', function () {
            $(this).closest('.boards-alert').fadeOut(200, function () {
                $(this).remove();
            });
        });

        // Auto-close alerts after 5 seconds
        setTimeout(() => {
            $('.boards-alert').fadeOut(200, function () {
                $(this).remove();
            });
        }, 5000);

        // Dropdown toggle (click-based for mobile)
        $(document).on('click', '.boards-dropdown-toggle', function (e) {
            e.stopPropagation();
            const dropdown = $(this).closest('.boards-dropdown');
            const menu = dropdown.find('.boards-dropdown-menu');

            // Close other dropdowns
            $('.boards-dropdown-menu').not(menu).removeClass('show');

            menu.toggleClass('show');
        });

        // Close dropdowns when clicking outside
        $(document).on('click', function () {
            $('.boards-dropdown-menu').removeClass('show');
        });

        // Escape key closes modals
        $(document).on('keydown', function (e) {
            if (e.key === 'Escape') {
                $('.boards-modal.show').removeClass('show');
            }
        });
    },

    /**
     * Show loading overlay
     */
    showLoading(message = 'Loading...') {
        if ($('#boards-loading').length === 0) {
            $('body').append(`
                <div id="boards-loading" class="boards-loading-overlay">
                    <div class="boards-loading-spinner">
                        <i class="fa fa-spinner fa-spin fa-2x"></i>
                        <span>${message}</span>
                    </div>
                </div>
            `);
        }
    },

    /**
     * Hide loading overlay
     */
    hideLoading() {
        $('#boards-loading').remove();
    },

    /**
     * Show toast notification
     */
    toast(message, type = 'success') {
        const icon = type === 'success' ? 'check-circle' :
            type === 'error' ? 'exclamation-circle' :
                type === 'warning' ? 'exclamation-triangle' : 'info-circle';

        const toast = $(`
            <div class="boards-toast boards-toast-${type}">
                <i class="fa fa-${icon}"></i>
                <span>${message}</span>
            </div>
        `);

        $('body').append(toast);

        setTimeout(() => toast.addClass('show'), 10);

        setTimeout(() => {
            toast.removeClass('show');
            setTimeout(() => toast.remove(), 300);
        }, 3000);
    },

    /**
     * Confirm dialog
     */
    confirm(message, callback) {
        if (confirm(message)) {
            callback();
        }
    },

    /**
     * Format date for display
     */
    formatDate(dateString) {
        if (!dateString) return '';
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', {
            month: 'short',
            day: 'numeric',
            year: date.getFullYear() !== new Date().getFullYear() ? 'numeric' : undefined
        });
    },

    /**
     * Check if date is overdue
     */
    isOverdue(dateString) {
        if (!dateString) return false;
        return new Date(dateString) < new Date();
    },

    /**
     * Debounce function
     */
    debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }
};

// Add toast styles dynamically
const toastStyles = `
    .boards-loading-overlay {
        position: fixed;
        inset: 0;
        background: rgba(0,0,0,0.5);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 2000;
    }
    .boards-loading-spinner {
        background: white;
        padding: 2rem;
        border-radius: 12px;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 1rem;
        color: #6366f1;
    }
    .boards-toast {
        position: fixed;
        bottom: 1.5rem;
        right: 1.5rem;
        padding: 0.875rem 1.25rem;
        background: white;
        border-radius: 8px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        display: flex;
        align-items: center;
        gap: 0.75rem;
        transform: translateY(100%);
        opacity: 0;
        transition: all 0.3s ease;
        z-index: 2000;
    }
    .boards-toast.show {
        transform: translateY(0);
        opacity: 1;
    }
    .boards-toast-success { border-left: 4px solid #22c55e; color: #22c55e; }
    .boards-toast-error { border-left: 4px solid #ef4444; color: #ef4444; }
    .boards-toast-warning { border-left: 4px solid #f59e0b; color: #f59e0b; }
    .boards-toast-info { border-left: 4px solid #3b82f6; color: #3b82f6; }
    .boards-toast span { color: #1e293b; }
`;

// Inject styles
$('<style>').text(toastStyles).appendTo('head');

// Initialize on DOM ready
$(document).ready(function () {
    Boards.init();
});

// Export for global access
window.Boards = Boards;
