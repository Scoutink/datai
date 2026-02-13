import { Component, Inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MAT_DIALOG_DATA, MatDialogModule, MatDialogRef } from '@angular/material/dialog';
import { TranslateModule } from '@ngx-translate/core';
import { HttpClient } from '@angular/common/http';
import { ToastrService } from 'ngx-toastr';
import { FeatherIconsModule } from '@shared/feather-icons.module';
import { MatButtonModule } from '@angular/material/button';

@Component({
    selector: 'app-archived-cards-modal',
    standalone: true,
    imports: [
        CommonModule,
        MatDialogModule,
        TranslateModule,
        FeatherIconsModule,
        MatButtonModule
    ],
    template: `
        <div class="archived-modal">
            <div class="modal-header">
                <h2>{{ 'ARCHIVED_CARDS' | translate }}</h2>
                <button class="btn-close" (click)="close()">
                    <i-feather name="x"></i-feather>
                </button>
            </div>
            <div class="modal-body">
                <div class="archived-list" *ngIf="cards.length > 0; else noCards">
                    <div class="archived-item" *ngFor="let card of cards">
                        <div class="card-info">
                            <span class="card-title">{{ card.title }}</span>
                            <span class="card-meta">In column: {{ card.column?.name }}</span>
                        </div>
                        <button mat-flat-button color="primary" (click)="restoreCard(card.id)">
                            {{ 'RESTORE' | translate }}
                        </button>
                    </div>
                </div>
                <ng-template #noCards>
                    <div class="empty-state">
                        <p>{{ 'NO_ARCHIVED_CARDS' | translate }}</p>
                    </div>
                </ng-template>
            </div>
        </div>
    `,
    styles: [`
        .archived-modal { padding: 20px; min-width: 400px; }
        .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .btn-close { border: none; background: none; cursor: pointer; }
        .archived-item { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            padding: 10px; 
            border-bottom: 1px solid #eee;
        }
        .card-info { display: flex; flex-direction: column; }
        .card-title { font-weight: bold; }
        .card-meta { font-size: 12px; color: #666; }
        .empty-state { text-align: center; color: #999; padding: 20px; }
    `]
})
export class ArchivedCardsModalComponent implements OnInit {
    cards: any[] = [];

    constructor(
        @Inject(MAT_DIALOG_DATA) public data: { boardId: string },
        private dialogRef: MatDialogRef<ArchivedCardsModalComponent>,
        private http: HttpClient,
        private toastr: ToastrService
    ) { }

    ngOnInit(): void {
        this.loadArchivedCards();
    }

    loadArchivedCards(): void {
        this.http.get<any[]>(`boards/${this.data.boardId}/archived-cards`).subscribe({
            next: (cards) => this.cards = cards,
            error: () => this.toastr.error('Failed to load archived cards')
        });
    }

    restoreCard(id: string): void {
        this.http.put(`cards/${id}/restore`, {}).subscribe({
            next: () => {
                this.toastr.success('Card restored');
                this.loadArchivedCards();
            },
            error: () => this.toastr.error('Failed to restore card')
        });
    }

    close(): void {
        this.dialogRef.close();
    }
}
