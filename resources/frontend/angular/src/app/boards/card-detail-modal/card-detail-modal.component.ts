import { Component, Inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogModule, MatDialogRef } from '@angular/material/dialog';
import { TranslateModule } from '@ngx-translate/core';
import { HttpClient } from '@angular/common/http';
import { ToastrService } from 'ngx-toastr';
import { CKEditorModule } from '@ckeditor/ckeditor5-angular';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import { FeatherIconsModule } from '@shared/feather-icons.module';
import { MatButtonModule } from '@angular/material/button';
import { CommonService } from '@core/services/common.service';
import { User } from '@core/domain-classes/user';
import { CardDocumentPickerComponent } from '../card-document-picker.component';
import { MatDialog } from '@angular/material/dialog';
import { OverlayPanel } from '@shared/overlay-panel/overlay-panel.service';
import { BasePreviewComponent } from '@shared/base-preview/base-preview.component';
import { DocumentView } from '@core/domain-classes/document-view';
import { BoardLabelsModalComponent } from '../board-labels-modal.component';

interface Card {
    id: string;
    title: string;
    description: string;
    htmlDescription: string;
    columnId: string;
    priority: 'low' | 'medium' | 'high' | 'urgent';
    executorId?: string;
    approverId?: string;
    supervisorId?: string;
    parentCardId?: string;
    executor?: User;
    approver?: User;
    supervisor?: User;
    followers?: User[];
    tags?: any[];
    labels?: any[];
    checklists?: Checklist[];
    isArchived: boolean;
    isCompleted: boolean;
    dueDate?: string;
}

interface Checklist {
    id: string;
    cardId: string;
    name: string;
    items: ChecklistItem[];
}

interface ChecklistItem {
    id: string;
    checklistId: string;
    name: string;
    isCompleted: boolean;
    position: number;
}

interface Activity {
    id: string;
    content: string;
    userName: string;
    createdDate: string;
    type: string;
}

@Component({
    selector: 'app-card-detail-modal',
    standalone: true,
    imports: [
        CommonModule,
        FormsModule,
        ReactiveFormsModule,
        MatDialogModule,
        TranslateModule,
        CKEditorModule,
        FeatherIconsModule,
        MatButtonModule
    ],
    templateUrl: './card-detail-modal.component.html',
    styleUrl: './card-detail-modal.component.scss'
})
export class CardDetailModalComponent implements OnInit {
    editor = ClassicEditor;
    card: any;
    activities: Activity[] = [];
    newComment = '';
    editingTitle = false;
    editingDescription = false;

    users: User[] = [];
    boardTags: any[] = [];
    boardLabels: any[] = [];
    boardMilestones: any[] = [];
    showTagPicker = false;
    showLabelPicker = false;

    constructor(
        @Inject(MAT_DIALOG_DATA) public data: { card: any },
        private dialogRef: MatDialogRef<CardDetailModalComponent>,
        private http: HttpClient,
        private toastr: ToastrService,
        private commonService: CommonService,
        private dialog: MatDialog,
        private overlay: OverlayPanel
    ) {
        this.card = { ...data.card };
    }

    ngOnInit(): void {
        this.loadCardDetails();
        this.loadActivities();
        this.loadUsers();
        this.loadBoardTags();
        this.loadBoardLabels();
        this.loadBoardMilestones();
    }

    loadUsers(): void {
        this.commonService.getUsersForDropdown().subscribe({
            next: (users) => this.users = users as User[],
            error: () => this.toastr.error('Failed to load users')
        });
    }

    loadCardDetails(): void {
        this.http.get(`cards/${this.card.id}`).subscribe({
            next: (card) => this.card = card,
            error: () => this.toastr.error('Failed to load card details')
        });
    }

    loadBoardTags(): void {
        this.http.get<any[]>(`boards/${this.data.card.boardId}/tags`).subscribe({
            next: (tags) => this.boardTags = tags,
            error: () => this.toastr.error('Failed to load board tags')
        });
    }

    loadBoardLabels(): void {
        this.http.get<any[]>(`boards/${this.data.card.boardId}/labels`).subscribe({
            next: (labels) => this.boardLabels = labels,
            error: () => this.toastr.error('Failed to load board labels')
        });
    }

    loadBoardMilestones(): void {
        this.http.get<any[]>(`boards/${this.data.card.boardId}/milestones`).subscribe({
            next: (milestones) => this.boardMilestones = milestones,
            error: () => this.toastr.error('Failed to load board milestones')
        });
    }

    loadActivities(): void {
        this.http.get<Activity[]>(`cards/${this.card.id}/activities`).subscribe({
            next: (activities) => this.activities = activities,
            error: () => this.toastr.error('Failed to load activities')
        });
    }

    saveTitle(): void {
        this.editingTitle = false;
        if (!this.card.title.trim()) return;
        this.updateCard({ title: this.card.title });
    }

    saveDescription(): void {
        this.editingDescription = false;
        this.updateCard({ description: this.card.description });
    }

    private updateCard(data: any): void {
        this.http.put(`cards/${this.card.id}`, data).subscribe({
            next: () => this.toastr.success('Card updated'),
            error: () => this.toastr.error('Failed to update card')
        });
    }

    addComment(): void {
        if (!this.newComment.trim()) return;
        this.http.post<Activity>(`cards/${this.card.id}/comments`, { content: this.newComment }).subscribe({
            next: (comment) => {
                this.activities.unshift(comment);
                this.newComment = '';
                this.toastr.success('Comment added');
            },
            error: () => this.toastr.error('Failed to add comment')
        });
    }

    openAssignment(role: string): void {
        // For simplicity, we'll let the HTML handle the selection
        // But we need the logic to save it
    }

    assignUser(role: string, userId: string): void {
        const updateData: any = {};
        updateData[`${role}Id`] = userId;
        this.updateCard(updateData);
    }

    updatePriority(priority: string): void {
        this.updateCard({ priority });
    }

    toggleCompleted(): void {
        this.card.isCompleted = !this.card.isCompleted;
        this.updateCard({ isCompleted: this.card.isCompleted });
    }

    updateDueDate(event: any): void {
        const dueDate = event.target.value;
        this.updateCard({ dueDate });
    }

    // ========== MILESTONES ==========

    hasMilestone(milestoneId: string): boolean {
        return this.card.milestones?.some((m: any) => m.id === milestoneId);
    }

    toggleMilestone(milestoneId: string): void {
        const currentMilestones = this.card.milestones || [];
        let newIds = currentMilestones.map((m: any) => m.id);

        if (this.hasMilestone(milestoneId)) {
            newIds = newIds.filter((id: string) => id !== milestoneId);
        } else {
            newIds.push(milestoneId);
        }

        this.http.post(`cards/${this.card.id}/milestones/sync`, { milestoneIds: newIds }).subscribe({
            next: () => {
                this.loadCardDetails(); // Reload to get updated milestones relationship
                this.toastr.success('Milestones updated');
            },
            error: () => this.toastr.error('Failed to update milestones')
        });
    }

    // ========== CHECKLISTS ==========

    addChecklist(): void {
        const name = prompt('Checklist Name', 'Checklist');
        if (!name) return;

        this.http.post<Checklist>(`cards/${this.card.id}/checklists`, { name }).subscribe({
            next: (checklist) => {
                if (!this.card.checklists) this.card.checklists = [];
                this.card.checklists.push({ ...checklist, items: [] });
                this.toastr.success('Checklist added');
            },
            error: () => this.toastr.error('Failed to add checklist')
        });
    }

    deleteChecklist(id: string): void {
        this.http.delete(`checklists/${id}`).subscribe({
            next: () => {
                this.card.checklists = this.card.checklists.filter((c: any) => c.id !== id);
                this.toastr.success('Checklist deleted');
            },
            error: () => this.toastr.error('Failed to delete checklist')
        });
    }

    addChecklistItem(checklist: Checklist, nameInput: HTMLInputElement): void {
        const name = nameInput.value.trim();
        if (!name) return;

        this.http.post<ChecklistItem>(`checklists/${checklist.id}/items`, { name }).subscribe({
            next: (item) => {
                checklist.items.push(item);
                nameInput.value = '';
                this.toastr.success('Item added');
            },
            error: () => this.toastr.error('Failed to add item')
        });
    }

    toggleChecklistItem(item: ChecklistItem): void {
        this.http.put(`checklist-items/${item.id}`, { isCompleted: !item.isCompleted }).subscribe({
            next: () => {
                item.isCompleted = !item.isCompleted;
            },
            error: () => this.toastr.error('Failed to update item')
        });
    }

    deleteChecklistItem(checklist: Checklist, itemId: string): void {
        this.http.delete(`checklist-items/${itemId}`).subscribe({
            next: () => {
                checklist.items = checklist.items.filter(i => i.id !== itemId);
                this.toastr.success('Item deleted');
            },
            error: () => this.toastr.error('Failed to delete item')
        });
    }

    getChecklistProgress(checklist: Checklist): number {
        if (!checklist.items || checklist.items.length === 0) return 0;
        const completed = checklist.items.filter(i => i.isCompleted).length;
        return Math.round((completed / checklist.items.length) * 100);
    }

    // ========== LABELS & TAGS ==========

    addLabel(): void {
        // Implementation for label selection popup
        this.toastr.info('Label selection coming soon!');
    }

    removeLabel(labelId: string): void {
        this.http.delete(`cards/${this.card.id}/labels/${labelId}`).subscribe({
            next: () => {
                this.card.labels = this.card.labels.filter((l: any) => l.id !== labelId);
                this.toastr.success('Label removed');
            },
            error: () => this.toastr.error('Failed to remove label')
        });
    }

    hasLabel(labelId: string): boolean {
        return this.card.labels?.some((l: any) => l.id === labelId);
    }

    toggleLabel(labelId: string): void {
        if (this.hasLabel(labelId)) {
            this.removeLabel(labelId);
        } else {
            this.http.post(`cards/${this.card.id}/labels`, { labelId }).subscribe({
                next: () => {
                    const label = this.boardLabels.find(l => l.id === labelId);
                    if (label) {
                        if (!this.card.labels) this.card.labels = [];
                        this.card.labels.push(label);
                    }
                    this.toastr.success('Label added');
                },
                error: () => this.toastr.error('Failed to add label')
            });
        }
    }

    manageBoardLabels(): void {
        const dialogRef = this.dialog.open(BoardLabelsModalComponent, {
            width: '500px',
            data: { boardId: this.data.card.boardId }
        });

        dialogRef.afterClosed().subscribe(() => {
            this.loadBoardLabels();
        });
    }

    // ========== ATTACHMENTS ==========

    addAttachment(): void {
        const dialogRef = this.dialog.open(CardDocumentPickerComponent, {
            width: '800px'
        });

        dialogRef.afterClosed().subscribe(document => {
            if (document) {
                this.http.post(`cards/${this.card.id}/attachments`, { documentId: document.id }).subscribe({
                    next: () => {
                        if (!this.card.attachments) this.card.attachments = [];
                        this.card.attachments.push({
                            ...document,
                            pivot: { createdDate: new Date().toISOString() }
                        });
                        this.toastr.success('Document attached');
                    },
                    error: () => this.toastr.error('Failed to attach document')
                });
            }
        });
    }

    detachAttachment(documentId: string): void {
        this.http.delete(`cards/${this.card.id}/attachments/${documentId}`).subscribe({
            next: () => {
                this.card.attachments = this.card.attachments.filter((a: any) => a.id !== documentId);
                this.toastr.success('Attachment removed');
            },
            error: () => this.toastr.error('Failed to remove attachment')
        });
    }

    viewAttachment(attachment: any): void {
        const urls = attachment.url.split('.');
        const extension = urls[urls.length - 1];
        const documentView: DocumentView = {
            documentId: attachment.id,
            name: attachment.name,
            extension: extension,
            isVersion: false,
            isFromPublicPreview: false,
            isPreviewDownloadEnabled: false,
            isFromFileRequest: false,
        };
        this.overlay.open(BasePreviewComponent, {
            position: 'center',
            origin: 'global',
            panelClass: ['file-preview-overlay-container', 'white-background'],
            data: documentView,
        });
    }

    addTag(tagId: string): void {
        if (!tagId) return;
        this.http.post(`cards/${this.card.id}/tags`, { tagId }).subscribe({
            next: () => {
                const tag = this.boardTags.find(t => t.id === tagId);
                if (tag && !this.card.tags?.some((t: any) => t.id === tagId)) {
                    if (!this.card.tags) this.card.tags = [];
                    this.card.tags.push(tag);
                }
                this.showTagPicker = false;
                this.toastr.success('Tag added');
            },
            error: () => this.toastr.error('Failed to add tag')
        });
    }

    createNewBoardTag(): void {
        const name = prompt('Enter new tag name:');
        if (!name) return;
        const color = prompt('Enter tag color (e.g. #0079bf):', '#0079bf');
        if (!color) return;

        this.http.post(`boards/${this.data.card.boardId}/tags`, { name, color }).subscribe({
            next: (tag: any) => {
                this.boardTags.push(tag);
                this.toastr.success('Tag created');
                this.addTag(tag.id);
            },
            error: () => this.toastr.error('Failed to create tag')
        });
    }

    removeTag(tagId: string): void {
        this.http.delete(`cards/${this.card.id}/tags/${tagId}`).subscribe({
            next: () => {
                this.card.tags = this.card.tags.filter((t: any) => t.id !== tagId);
                this.toastr.success('Tag removed');
            },
            error: () => this.toastr.error('Failed to remove tag')
        });
    }

    archiveCard(): void {
        this.http.put(`cards/${this.card.id}/archive`, {}).subscribe({
            next: () => {
                this.toastr.success('Card archived');
                this.dialogRef.close({ archived: true, cardId: this.card.id });
            },
            error: () => this.toastr.error('Failed to archive card')
        });
    }

    restoreCard(): void {
        this.http.put(`cards/${this.card.id}/restore`, {}).subscribe({
            next: () => {
                this.toastr.success('Card restored');
                this.dialogRef.close({ restored: true, cardId: this.card.id });
            },
            error: () => this.toastr.error('Failed to restore card')
        });
    }

    deleteCard(): void {
        if (confirm('Are you sure you want to permanently delete this card?')) {
            this.http.delete(`cards/${this.card.id}`).subscribe({
                next: () => {
                    this.toastr.success('Card deleted');
                    this.dialogRef.close({ deleted: true, cardId: this.card.id });
                },
                error: () => this.toastr.error('Failed to delete card')
            });
        }
    }

    close(): void {
        this.dialogRef.close();
    }
}
