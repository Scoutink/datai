import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { TranslateModule, TranslateService } from '@ngx-translate/core';
import { HttpClient } from '@angular/common/http';
import { ToastrService } from 'ngx-toastr';
import { RouterModule, Router } from '@angular/router';
import { FeatherIconsModule } from '@shared/feather-icons.module';

interface Board {
  id: string;
  name: string;
  description: string;
  backgroundColor: string;
  createdDate: string;
  creator?: {
    firstName: string;
    lastName: string;
  };
}

@Component({
  selector: 'app-boards-list',
  standalone: true,
  imports: [CommonModule, FormsModule, TranslateModule, RouterModule, FeatherIconsModule],
  template: `
  <section class="content">
    <div class="container-fluid">
      <div class="boards-container">
        <div class="page-header">
          <h2>{{ 'BOARDS' | translate }}</h2>
          <button class="btn-create" (click)="openCreateDialog()">
            <i-feather name="plus"></i-feather>
            {{ 'CREATE_BOARD' | translate }}
          </button>
        </div>
        
        <div class="boards-grid" *ngIf="boards.length > 0">
          <div class="board-card" *ngFor="let board of boards" 
               [style.background-color]="board.backgroundColor"
               (click)="openBoard(board)">
            <h3>{{ board.name }}</h3>
            <p *ngIf="board.description">{{ board.description }}</p>
            <div class="board-meta">
              <span *ngIf="board.creator">{{ board.creator.firstName }} {{ board.creator.lastName }}</span>
            </div>
          </div>
        </div>
        
        <div class="no-boards" *ngIf="boards.length === 0 && !loading">
          <i-feather name="trello"></i-feather>
          <p>{{ 'NO_BOARDS_FOUND' | translate }}</p>
          <button class="btn-create" (click)="openCreateDialog()">
            {{ 'CREATE_FIRST_BOARD' | translate }}
          </button>
        </div>
        
        <div class="loading" *ngIf="loading">
          <span>Loading...</span>
        </div>
      </div>
      
      <!-- Create Board Dialog -->
      <div class="dialog-overlay" *ngIf="showCreateDialog" (click)="closeCreateDialog()">
        <div class="dialog" (click)="$event.stopPropagation()">
          <h3>{{ 'CREATE_NEW_BOARD' | translate }}</h3>
          <div class="form-group">
            <label>{{ 'BOARD_NAME' | translate }}</label>
            <input type="text" [(ngModel)]="newBoard.name" placeholder="Enter board name">
          </div>
          <div class="form-group">
            <label>{{ 'DESCRIPTION' | translate }}</label>
            <textarea [(ngModel)]="newBoard.description" placeholder="Enter description (optional)"></textarea>
          </div>
          <div class="form-group">
            <label>{{ 'BACKGROUND_COLOR' | translate }}</label>
            <div class="color-options">
              <button *ngFor="let color of colorOptions" 
                      [style.background-color]="color"
                      [class.selected]="newBoard.backgroundColor === color"
                      (click)="newBoard.backgroundColor = color">
              </button>
            </div>
          </div>
          <div class="dialog-actions">
            <button class="btn-cancel" (click)="closeCreateDialog()">{{ 'CANCEL' | translate }}</button>
            <button class="btn-save" (click)="createBoard()">{{ 'CREATE' | translate }}</button>
          </div>
        </div>
      </div>
    </div>
  </section>
  `,
  styles: [`
    .boards-container {
      /* Removed padding: 24px because section.content handles it */
    }
    
    .page-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 24px;
    }
    
    .page-header h2 {
      margin: 0;
      font-size: 24px;
      font-weight: 600;
    }
    
    .btn-create {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 10px 20px;
      background: #5c6bc0;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 14px;
      font-weight: 500;
    }
    
    .btn-create:hover {
      background: #3f51b5;
    }
    
    .boards-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 16px;
    }
    
    .board-card {
      padding: 16px;
      border-radius: 8px;
      cursor: pointer;
      min-height: 100px;
      transition: transform 0.2s, box-shadow 0.2s;
      color: #172b4d;
    }
    
    .board-card:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    
    .board-card h3 {
      margin: 0 0 8px 0;
      font-size: 16px;
      font-weight: 600;
    }
    
    .board-card p {
      margin: 0;
      font-size: 14px;
      opacity: 0.8;
    }
    
    .board-meta {
      margin-top: 12px;
      font-size: 12px;
      opacity: 0.7;
    }
    
    .no-boards {
      text-align: center;
      padding: 60px 20px;
      color: #666;
    }
    
    .no-boards i {
      font-size: 48px;
      margin-bottom: 16px;
      display: block;
    }
    
    .loading {
      text-align: center;
      padding: 40px;
    }
    
    .dialog-overlay {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0,0,0,0.5);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 1000;
    }
    
    .dialog {
      background: white;
      padding: 24px;
      border-radius: 8px;
      width: 400px;
      max-width: 90%;
    }
    
    .dialog h3 {
      margin: 0 0 20px 0;
    }
    
    .form-group {
      margin-bottom: 16px;
    }
    
    .form-group label {
      display: block;
      margin-bottom: 6px;
      font-weight: 500;
    }
    
    .form-group input,
    .form-group textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 14px;
    }
    
    .form-group textarea {
      min-height: 80px;
      resize: vertical;
    }
    
    .color-options {
      display: flex;
      gap: 8px;
    }
    
    .color-options button {
      width: 32px;
      height: 32px;
      border: 2px solid transparent;
      border-radius: 4px;
      cursor: pointer;
    }
    
    .color-options button.selected {
      border-color: #172b4d;
    }
    
    .dialog-actions {
      display: flex;
      justify-content: flex-end;
      gap: 12px;
      margin-top: 24px;
    }
    
    .btn-cancel {
      padding: 10px 20px;
      background: #f4f5f7;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    
    .btn-save {
      padding: 10px 20px;
      background: #5c6bc0;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
  `]
})
export class BoardsListComponent implements OnInit {
  boards: Board[] = [];
  loading = true;
  showCreateDialog = false;

  newBoard = {
    name: '',
    description: '',
    backgroundColor: '#f4f5f7'
  };

  colorOptions = [
    '#f4f5f7', '#0079bf', '#d29034', '#519839',
    '#b04632', '#89609e', '#cd5a91', '#4bbf6b'
  ];

  constructor(
    private http: HttpClient,
    private toastr: ToastrService,
    private translate: TranslateService,
    private router: Router
  ) { }

  ngOnInit(): void {
    this.loadBoards();
  }

  loadBoards(): void {
    this.loading = true;
    this.http.get<Board[]>('boards').subscribe({
      next: (boards) => {
        this.boards = boards;
        this.loading = false;
      },
      error: (err) => {
        console.error('Error loading boards:', err);
        this.loading = false;
        this.toastr.error('Failed to load boards');
      }
    });
  }

  openCreateDialog(): void {
    this.showCreateDialog = true;
    this.newBoard = {
      name: '',
      description: '',
      backgroundColor: '#f4f5f7'
    };
  }

  closeCreateDialog(): void {
    this.showCreateDialog = false;
  }

  createBoard(): void {
    if (!this.newBoard.name.trim()) {
      this.toastr.warning('Please enter a board name');
      return;
    }

    this.http.post<Board>('boards', this.newBoard).subscribe({
      next: (board) => {
        this.boards.unshift(board);
        this.closeCreateDialog();
        this.toastr.success('Board created successfully');
      },
      error: (err) => {
        console.error('Error creating board:', err);
        this.toastr.error('Failed to create board');
      }
    });
  }

  openBoard(board: Board): void {
    this.router.navigate(['/boards', board.id]);
  }
}
