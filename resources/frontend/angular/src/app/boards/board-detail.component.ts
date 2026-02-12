import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { TranslateModule, TranslateService } from '@ngx-translate/core';
import { HttpClient } from '@angular/common/http';
import { ToastrService } from 'ngx-toastr';
import { ActivatedRoute, RouterModule, Router } from '@angular/router';
import { CdkDragDrop, DragDropModule, moveItemInArray, transferArrayItem } from '@angular/cdk/drag-drop';
import { Subject, takeUntil } from 'rxjs';
import { FeatherIconsModule } from '@shared/feather-icons.module';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { CardDetailModalComponent } from './card-detail-modal/card-detail-modal.component';
import { ArchivedCardsModalComponent } from './archived-cards-modal.component';

import { BoardLabelsModalComponent } from './board-labels-modal.component';

interface Card {
  id: string;
  title: string;
  description: string;
  position: number;
  priority: string;
  columnId: string;
  checklists?: any[];
  document?: any;
  labels?: any[];
  tags?: any[];
  isCompleted?: boolean;
  dueDate?: string;
  attachments?: any[];
}

interface Column {
  id: string;
  name: string;
  position: number;
  cards: Card[];
}

interface Board {
  id: string;
  name: string;
  description: string;
  backgroundColor: string;
  columns: Column[];
}

@Component({
  selector: 'app-board-detail',
  standalone: true,
  imports: [CommonModule, FormsModule, TranslateModule, RouterModule, DragDropModule, FeatherIconsModule, MatDialogModule, BoardLabelsModalComponent],
  template: `
  <section class="content">
    <div class="container-fluid">
      <div class="board-container" [style.background-color]="board?.backgroundColor">
        <div class="board-header">
          <div class="header-left">
            <button class="btn-back" routerLink="/boards">
              <i-feather name="arrow-left"></i-feather>
            </button>
            <h2 *ngIf="!editingName" (click)="editingName = true">{{ board?.name }}</h2>
            <input *ngIf="editingName" type="text" [(ngModel)]="board.name" (blur)="updateBoardName()" (keyup.enter)="updateBoardName()" autofocus>
          </div>
          <div class="header-right">
            <button class="btn-archived" (click)="manageLabels()" style="margin-right: 10px;">
              <i-feather name="tag"></i-feather> {{ 'MANAGE_LABELS' | translate }}
            </button>
            <button class="btn-archived" (click)="showArchivedCards()" style="margin-right: 10px;">
              <i-feather name="archive"></i-feather> {{ 'ARCHIVED' | translate }}
            </button>
            <button class="btn-add-column" (click)="addColumn()">
              <i-feather name="plus"></i-feather> {{ 'ADD_COLUMN' | translate }}
            </button>
          </div>
        </div>

        <!-- Milestones Section -->
        <div class="milestones-bar">
          <div class="milestones-header">
            <i-feather name="flag"></i-feather> {{ 'MILESTONES' | translate | uppercase }}
            <button class="btn-add-milestone" (click)="showingMilestoneAdd = true" *ngIf="!showingMilestoneAdd">
              <i-feather name="plus"></i-feather>
            </button>
          </div>
          <div class="milestones-list">
            <div class="milestone-item" *ngFor="let milestone of milestones" [style.border-color]="milestone.color">
              <span class="milestone-dot" [style.background-color]="milestone.color"></span>
              <span class="milestone-name">{{ milestone.name }}</span>
              <span class="milestone-progress">{{ milestone.completed_cards_count }}/{{ milestone.cards_count }}</span>
              <div class="milestone-actions">
                <button (click)="editMilestone(milestone)"><i-feather name="edit-2"></i-feather></button>
                <button (click)="deleteMilestone(milestone.id)"><i-feather name="trash-2"></i-feather></button>
              </div>
              <div class="progress-bar-container">
                <div class="progress-bar" [style.width.%]="calculateMilestoneProgress(milestone)" [style.background-color]="milestone.color"></div>
              </div>
            </div>

            <div class="milestone-add-form" *ngIf="showingMilestoneAdd">
              <input type="text" [(ngModel)]="newMilestoneName" placeholder="Milestone Name..." (keyup.enter)="saveMilestone()">
              <input type="color" [(ngModel)]="newMilestoneColor">
              <button class="btn-save" (click)="saveMilestone()">Save</button>
              <button class="btn-cancel" (click)="showingMilestoneAdd = false">X</button>
            </div>
          </div>
        </div>

        <div class="board-canvas" cdkDropListGroup>
          <div class="column-container" *ngFor="let column of board?.columns" cdkDropList [cdkDropListData]="column.cards" (cdkDropListDropped)="drop($event, column.id)">
            <div class="column-header">
              <h3>{{ column.name }}</h3>
              <button class="btn-add-card" (click)="openAddCard(column.id)">
              <i-feather name="plus"></i-feather>
            </button>
            </div>
            
            <div class="cards-list">
              <div class="card-item" *ngFor="let card of column.cards" cdkDrag [cdkDragData]="card" (click)="openCard(card)" [class.completed]="card.isCompleted">
                <div class="card-content">
                  <div class="card-labels" *ngIf="card.labels?.length">
                    <div *ngFor="let label of card.labels" class="label-badge" [style.background-color]="label.color" [title]="label.name"></div>
                  </div>
                  <h4>{{ card.title }}</h4>
                  <p *ngIf="card.description">{{ card.description }}</p>
                  <div class="card-footer-tags" *ngIf="card.tags?.length">
                    <span *ngFor="let tag of card.tags" class="tag-label">#{{ tag.name }}</span>
                  </div>
                  <div class="card-footer">
                    <span class="priority" [class]="card.priority">{{ card.priority | uppercase }}</span>
                    <div class="badges">
                      <span class="badge" *ngIf="card.checklists?.length" [title]="'CHECKLIST' | translate">
                        <i-feather name="check-square"></i-feather> {{ getChecklistCount(card) }}
                      </span>
                      <span class="badge" *ngIf="card.attachments?.length" [title]="'ATTACHMENTS' | translate">
                        <i-feather name="paperclip"></i-feather> {{ card.attachments.length }}
                      </span>
                      <span class="badge due-date-badge" *ngIf="card.dueDate" [class.overdue]="isOverdue(card.dueDate)" [title]="'DUE_DATE' | translate">
                        <i-feather name="clock"></i-feather> {{ card.dueDate | date:'MMM d' }}
                      </span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <div class="add-card-inline" *ngIf="addingCardInColumn === column.id">
              <input type="text" [(ngModel)]="newCardTitle" placeholder="Enter card title..." (keyup.enter)="saveCard(column.id)" autofocus>
              <div class="actions">
                <button class="btn-save" (click)="saveCard(column.id)">Add</button>
                <button class="btn-cancel" (click)="addingCardInColumn = null">X</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  `,
  styles: [`
    .board-container {
      height: calc(100vh - 60px);
      display: flex;
      flex-direction: column;
      overflow: hidden;
    }
    .board-header {
      padding: 12px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      background: rgba(0,0,0,0.1);
      backdrop-filter: blur(5px);
    }
    .header-left {
      display: flex;
      align-items: center;
      gap: 12px;
    }
    .board-header h2 {
      margin: 0;
      color: #172b4d;
      font-size: 18px;
      cursor: pointer;
    }
    .board-canvas {
      flex: 1;
      display: flex;
      padding: 12px;
      overflow-x: auto;
      gap: 12px;
      align-items: flex-start;
    }
    .column-container {
      width: 272px;
      background: #ebecf0;
      border-radius: 4px;
      display: flex;
      flex-direction: column;
      max-height: 100%;
      flex-shrink: 0;
    }
    .column-header {
      padding: 10px 8px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .column-header h3 {
      margin: 0;
      font-size: 14px;
      font-weight: 600;
      color: #172b4d;
    }
    .cards-list {
      padding: 0 8px 8px;
      overflow-y: auto;
      flex: 1;
      min-height: 50px;
    }
    .card-item {
      background: white;
      border-radius: 3px;
      box-shadow: 0 1px 0 rgba(9,30,66,.25);
      margin-bottom: 8px;
      padding: 8px;
      cursor: pointer;
    }
    .card-item:hover {
      background: #f4f5f7;
    }
    .card-item.completed {
        background: #e6f4ea;
        border-left: 4px solid #34a853;
        &:hover {
            background: #dcf1e3;
        }
    }
    .card-labels {
      display: flex;
      flex-wrap: wrap;
      gap: 4px;
      margin-bottom: 6px;
    }
    .label-badge {
      height: 8px;
      width: 40px;
      border-radius: 4px;
    }
    .card-item h4 {
      margin: 0 0 4px 0;
      font-size: 14px;
      font-weight: 400;
      color: #172b4d;
    }
    .card-item p {
      margin: 0;
      font-size: 12px;
      color: #5e6c84;
    }
    .card-footer {
      margin-top: 8px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .priority {
      font-size: 10px;
      padding: 2px 6px;
      border-radius: 3px;
      font-weight: 600;
      text-transform: uppercase;
      &.low { background: #dffcf0; color: #006644; }
      &.medium { background: #fffadc; color: #974f0c; }
      &.high { background: #ffebe6; color: #bf2600; }
      &.urgent { background: #fef2f2; color: #dc2626; border: 1px solid #fee2e2; }
    }
    .badges {
      display: flex;
      gap: 8px;
      .badge {
        display: flex;
        align-items: center;
        gap: 4px;
        color: #5e6c84;
        font-size: 12px;
        &.due-date-badge {
            background: #ebecf0;
            padding: 2px 4px;
            border-radius: 3px;
            &.overdue {
                background: #eb5a46;
                color: white;
            }
        }
        i-feather { width: 12px; height: 12px; }
      }
    }
    
    .card-footer-tags {
      display: flex;
      flex-wrap: wrap;
      gap: 4px;
      margin-top: 8px;
    }
    .tag-label {
      font-size: 10px;
      color: #5e6c84;
      background: #f4f5f7;
      padding: 2px 6px;
      border-radius: 3px;
    }
    
    .btn-back, .btn-add-card, .btn-add-column {
      background: transparent;
      border: none;
      cursor: pointer;
      color: #172b4d;
      padding: 4px;
      border-radius: 3px;
    }
    .btn-back:hover, .btn-add-card:hover { background: rgba(0,0,0,0.05); }

    /* Milestones Styles */
    .milestones-bar {
      padding: 10px 20px;
      background: rgba(255,255,255,0.8);
      border-bottom: 1px solid #ddd;
      display: flex;
      align-items: center;
      gap: 20px;
      overflow-x: auto;
    }
    .milestones-header {
      display: flex;
      align-items: center;
      gap: 5px;
      font-weight: bold;
      color: #5e6c84;
      font-size: 12px;
      white-space: nowrap;
    }
    .milestones-list {
      display: flex;
      gap: 10px;
      align-items: center;
    }
    .milestone-item {
      padding: 5px 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
      background: #f4f5f7;
      display: flex;
      align-items: center;
      gap: 8px;
      position: relative;
      min-width: 150px;
    }
    .milestone-dot {
      width: 10px;
      height: 10px;
      border-radius: 50%;
    }
    .milestone-name { font-size: 13px; font-weight: 500; }
    .milestone-progress { font-size: 11px; color: #5e6c84; }
    .milestone-actions {
      display: none;
      gap: 4px;
      button { background: none; border: none; padding: 2px; cursor: pointer; color: #5e6c84; }
      i-feather { width: 14px; height: 14px; }
    }
    .milestone-item:hover .milestone-actions { display: flex; }
    .progress-bar-container {
      position: absolute;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 3px;
      background: #eee;
    }
    .progress-bar { height: 100%; transition: width 0.3s ease; }
    .btn-add-milestone { background: none; border: none; cursor: pointer; color: #5e6c84; }
    .milestone-add-form {
      display: flex;
      gap: 5px;
      align-items: center;
      input[type="text"] { height: 28px; padding: 0 8px; border: 1px solid #ccc; border-radius: 3px; }
      input[type="color"] { width: 30px; height: 28px; padding: 0; border: 1px solid #ccc; border-radius: 3px; }
      button { padding: 4px 8px; border-radius: 3px; font-size: 12px; }
    }
    
    .cdk-drag-preview {
      box-sizing: border-box;
      border-radius: 4px;
      box-shadow: 0 5px 5px -3px rgba(0, 0, 0, 0.2),
                  0 8px 10px 1px rgba(0, 0, 0, 0.14),
                  0 3px 14px 2px rgba(0, 0, 0, 0.12);
    }
    .cdk-drag-placeholder { opacity: 0; }
    .cdk-drag-animating { transition: transform 250ms cubic-bezier(0, 0, 0.2, 1); }
    .cards-list.cdk-drop-list-dragging .card-item:not(.cdk-drag-placeholder) {
      transition: transform 250ms cubic-bezier(0, 0, 0.2, 1);
    }
  `]
})
export class BoardDetailComponent implements OnInit, OnDestroy {
  board: any;
  milestones: any[] = [];
  loading = true;
  editingName = false;
  addingCardInColumn: string | null = null;
  newCardTitle = '';
  showingMilestoneAdd = false;
  newMilestoneName = '';
  newMilestoneColor = '#0079bf';
  private destroy$ = new Subject<void>();

  constructor(
    private route: ActivatedRoute,
    private http: HttpClient,
    private toastr: ToastrService,
    private router: Router,
    private dialog: MatDialog
  ) { }

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (id) {
      this.loadBoard(id);
    } else {
      this.router.navigate(['/boards']);
    }
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
  }

  loadBoard(id: string): void {
    this.loading = true;
    this.http.get<Board>(`boards/${id}`).subscribe({
      next: (board) => {
        this.board = board;
        this.loading = false;
        this.loadMilestones();
      },
      error: () => {
        this.toastr.error('Failed to load board');
        this.router.navigate(['/boards']);
      }
    });
  }

  loadMilestones(): void {
    this.http.get<any[]>(`boards/${this.board.id}/milestones`).subscribe({
      next: (res) => this.milestones = res
    });
  }

  saveMilestone(): void {
    if (!this.newMilestoneName.trim()) return;
    this.http.post(`boards/${this.board.id}/milestones`, {
      name: this.newMilestoneName,
      color: this.newMilestoneColor
    }).subscribe({
      next: () => {
        this.loadMilestones();
        this.newMilestoneName = '';
        this.showingMilestoneAdd = false;
        this.toastr.success('Milestone added');
      }
    });
  }

  editMilestone(milestone: any): void {
    const newName = prompt('New Milestone Name:', milestone.name);
    if (newName) {
      this.http.put(`board-milestones/${milestone.id}`, { name: newName }).subscribe({
        next: () => this.loadMilestones()
      });
    }
  }

  deleteMilestone(id: string): void {
    if (confirm('Are you sure you want to delete this milestone?')) {
      this.http.delete(`board-milestones/${id}`).subscribe({
        next: () => this.loadMilestones()
      });
    }
  }

  calculateMilestoneProgress(milestone: any): number {
    if (!milestone.cards_count || milestone.cards_count === 0) return 0;
    return (milestone.completed_cards_count / milestone.cards_count) * 100;
  }

  getChecklistCount(card: Card): string {
    if (!card.checklists || card.checklists.length === 0) return '';
    let total = 0;
    let completed = 0;
    card.checklists.forEach(cl => {
      if (cl.items) {
        total += cl.items.length;
        completed += cl.items.filter((i: any) => i.isCompleted).length;
      }
    });
    return `${completed}/${total}`;
  }

  updateBoardName(): void {
    this.editingName = false;
    this.http.put(`boards/${this.board.id}`, { name: this.board.name }).subscribe({
      next: () => this.toastr.success('Board name updated'),
      error: () => this.toastr.error('Failed to update name')
    });
  }

  openAddCard(columnId: string): void {
    this.addingCardInColumn = columnId;
    this.newCardTitle = '';
  }

  saveCard(columnId: string): void {
    if (!this.newCardTitle.trim()) return;

    this.http.post<Card>(`columns/${columnId}/cards`, { title: this.newCardTitle }).subscribe({
      next: (card) => {
        const column = this.board.columns.find((c: any) => c.id === columnId);
        if (column) column.cards.push(card);
        this.addingCardInColumn = null;
        this.toastr.success('Card added');
      },
      error: () => this.toastr.error('Failed to add card')
    });
  }

  addColumn(): void {
    const name = prompt('Column Name:');
    if (!name) return;

    this.http.post<Column>(`boards/${this.board.id}/columns`, { name }).subscribe({
      next: (col) => {
        this.board.columns.push({ ...col, cards: [] });
        this.toastr.success('Column added');
      },
      error: () => this.toastr.error('Failed to add column')
    });
  }

  drop(event: CdkDragDrop<Card[]>, columnId: string): void {
    if (event.previousContainer === event.container) {
      moveItemInArray(event.container.data, event.previousIndex, event.currentIndex);
      this.updateCardOrder(columnId, event.container.data);
    } else {
      transferArrayItem(
        event.previousContainer.data,
        event.container.data,
        event.previousIndex,
        event.currentIndex
      );
      const card = event.container.data[event.currentIndex];
      this.moveCard(card.id, columnId, event.currentIndex);
    }
  }

  updateCardOrder(columnId: string, cards: Card[]): void {
    // Implementation for reordering within column
  }

  openCard(card: Card): void {
    const dialogRef = this.dialog.open(CardDetailModalComponent, {
      width: '900px',
      data: { card },
      panelClass: 'custom-card-modal'
    });

    dialogRef.afterClosed().subscribe(result => {
      this.loadBoard(this.board.id);
    });
  }

  showArchivedCards(): void {
    const dialogRef = this.dialog.open(ArchivedCardsModalComponent, {
      width: '600px',
      data: { boardId: this.board.id }
    });

    dialogRef.afterClosed().subscribe(() => {
      this.loadBoard(this.board.id);
    });
  }

  moveCard(cardId: string, columnId: string, position: number): void {
    this.http.put(`cards/${cardId}/move`, { columnId, position }).subscribe({
      error: () => this.toastr.error('Failed to move card')
    });
  }

  manageLabels(): void {
    const dialogRef = this.dialog.open(BoardLabelsModalComponent, {
      width: '500px',
      data: { boardId: this.board.id }
    });

    dialogRef.afterClosed().subscribe(() => {
      this.loadBoard(this.board.id);
    });
  }

  isOverdue(date: string): boolean {
    if (!date) return false;
    return new Date(date) < new Date();
  }
}
