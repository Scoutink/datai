import { Component, Inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { TranslateModule } from '@ngx-translate/core';
import { HttpClient } from '@angular/common/http';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialogModule } from '@angular/material/dialog';
import { ToastrService } from 'ngx-toastr';
import { FeatherIconsModule } from '@shared/feather-icons.module';

@Component({
    selector: 'app-board-labels-modal',
    standalone: true,
    imports: [CommonModule, FormsModule, TranslateModule, MatDialogModule, FeatherIconsModule],
    template: `
    <div class="labels-modal-container">
      <div class="modal-header">
        <h3>{{ 'MANAGE_LABELS' | translate }}</h3>
        <button class="btn-close" (click)="close()">
          <i-feather name="x"></i-feather>
        </button>
      </div>

      <div class="modal-body">
        <div class="add-label-section mb-4">
          <h4>{{ 'ADD_NEW_LABEL' | translate }}</h4>
          <div class="d-flex gap-2 align-items-center">
            <input type="text" class="form-control" [(ngModel)]="newLabelName" [placeholder]="'LABEL_NAME' | translate">
            <input type="color" [(ngModel)]="newLabelColor" class="color-picker">
            <button class="btn btn-primary" (click)="createLabel()" [disabled]="!newLabelName">
              <i-feather name="plus"></i-feather> Add
            </button>
          </div>
        </div>

        <div class="labels-list">
          <h4>{{ 'BOARD_LABELS' | translate }}</h4>
          <div *ngFor="let label of labels" class="label-item">
            <div class="label-preview" [style.background-color]="label.color"></div>
            <div class="label-info">
              <input type="text" [(ngModel)]="label.name" (blur)="updateLabel(label)" class="form-control-plaintext">
            </div>
            <div class="label-actions">
              <input type="color" [(ngModel)]="label.color" (change)="updateLabel(label)" class="color-picker-sm">
              <button class="btn-delete" (click)="deleteLabel(label.id)">
                <i-feather name="trash-2"></i-feather>
              </button>
            </div>
          </div>
          <div *ngIf="!labels.length" class="no-labels">
            {{ 'NO_LABELS_AVAILABLE' | translate }}
          </div>
        </div>
      </div>
    </div>
  `,
    styles: [`
    .labels-modal-container { padding: 20px; min-width: 400px; }
    .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
    .modal-header h3 { margin: 0; font-size: 18px; }
    .btn-close { background: none; border: none; cursor: pointer; color: #666; }
    
    .label-item { display: flex; align-items: center; gap: 12px; padding: 10px; border-radius: 4px; border: 1px solid #eee; margin-bottom: 8px; }
    .label-preview { width: 32px; height: 32px; border-radius: 4px; flex-shrink: 0; }
    .label-info { flex: 1; }
    .label-info input { padding: 4px 8px; font-weight: 500; font-size: 14px; border-bottom: 1px solid transparent; }
    .label-info input:focus { border-bottom-color: #0079bf; outline: none; }
    
    .label-actions { display: flex; align-items: center; gap: 8px; }
    .color-picker { width: 40px; height: 40px; padding: 0; border: 1px solid #ddd; border-radius: 4px; cursor: pointer; }
    .color-picker-sm { width: 24px; height: 24px; padding: 0; border: none; background: none; cursor: pointer; }
    
    .btn-delete { background: none; border: none; color: #eb5a46; cursor: pointer; padding: 4px; border-radius: 3px; }
    .btn-delete:hover { background: #ffebe6; }
    
    .no-labels { text-align: center; color: #5e6c84; padding: 20px; font-style: italic; }
  `]
})
export class BoardLabelsModalComponent implements OnInit {
    labels: any[] = [];
    newLabelName = '';
    newLabelColor = '#61bd4f';

    constructor(
        private http: HttpClient,
        private toastr: ToastrService,
        public dialogRef: MatDialogRef<BoardLabelsModalComponent>,
        @Inject(MAT_DIALOG_DATA) public data: { boardId: string }
    ) { }

    ngOnInit(): void {
        this.loadLabels();
    }

    loadLabels(): void {
        this.http.get<any[]>(`boards/${this.data.boardId}/labels`).subscribe({
            next: (labels) => this.labels = labels,
            error: () => this.toastr.error('Failed to load labels')
        });
    }

    createLabel(): void {
        if (!this.newLabelName.trim()) return;
        this.http.post(`boards/${this.data.boardId}/labels`, {
            name: this.newLabelName,
            color: this.newLabelColor
        }).subscribe({
            next: (label) => {
                this.labels.push(label);
                this.newLabelName = '';
                this.toastr.success('Label created');
            },
            error: () => this.toastr.error('Failed to create label')
        });
    }

    updateLabel(label: any): void {
        this.http.put(`labels/${label.id}`, {
            name: label.name,
            color: label.color
        }).subscribe({
            next: () => this.toastr.success('Label updated'),
            error: () => this.toastr.error('Failed to update label')
        });
    }

    deleteLabel(id: string): void {
        if (!confirm('Are you sure you want to delete this label?')) return;
        this.http.delete(`labels/${id}`).subscribe({
            next: () => {
                this.labels = this.labels.filter(l => l.id !== id);
                this.toastr.success('Label deleted');
            },
            error: () => this.toastr.error('Failed to delete label')
        });
    }

    close(): void {
        this.dialogRef.close();
    }
}
