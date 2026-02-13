import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { MatDialogModule, MatDialogRef } from '@angular/material/dialog';
import { TranslateModule } from '@ngx-translate/core';
import { DocumentService } from '../document/document.service';
import { DocumentInfo } from '@core/domain-classes/document-info';
import { DocumentResource } from '@core/domain-classes/document-resource';
import { FeatherIconsModule } from '@shared/feather-icons.module';
import { HttpResponse } from '@angular/common/http';
import { CommonError } from '@core/error-handler/common-error';

@Component({
  selector: 'app-card-document-picker',
  standalone: true,
  imports: [CommonModule, FormsModule, MatDialogModule, TranslateModule, FeatherIconsModule],
  template: `
    <div class="picker-container">
      <div class="picker-header">
        <h3>{{ 'SELECT_DOCUMENT' | translate }}</h3>
        <button class="btn-close" (click)="close()">
          <i-feather name="x"></i-feather>
        </button>
      </div>
      <div class="picker-body">
        <div class="search-box mb-3">
          <input type="text" class="form-control" [placeholder]="'SEARCH_DOCUMENTS' | translate" 
                 [(ngModel)]="searchQuery" (keyup.enter)="loadDocuments()">
          <button class="btn btn-primary" (click)="loadDocuments()">
            <i-feather name="search"></i-feather>
          </button>
        </div>
        <div class="document-list">
          <div *ngIf="loading" class="text-center p-3">
            <div class="spinner-border text-primary" role="status"></div>
          </div>
          <div *ngIf="!loading && documents.length === 0" class="text-center p-3">
            {{ 'NO_DOCUMENTS_FOUND' | translate }}
          </div>
          <div class="document-item" *ngFor="let doc of documents" (click)="selectDocument(doc)">
            <i-feather name="file-text"></i-feather>
            <div class="doc-info">
              <span class="doc-name">{{ doc.name }}</span>
              <span class="doc-meta">{{ doc.categoryName }} • {{ doc.createdDate | date:'shortDate' }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .picker-container { padding: 20px; min-width: 400px; }
    .picker-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .picker-header h3 { margin: 0; font-size: 18px; }
    .btn-close { background: none; border: none; cursor: pointer; color: #5e6c84; }
    .search-box { display: flex; gap: 8px; }
    .document-list { max-height: 400px; overflow-y: auto; border: 1px solid #ebecf0; border-radius: 4px; }
    .document-item { 
      padding: 12px; border-bottom: 1px solid #ebecf0; display: flex; align-items: center; gap: 12px; cursor: pointer;
      transition: background 0.2s;
    }
    .document-item:hover { background: #f4f5f7; }
    .document-item:last-child { border-bottom: none; }
    .doc-info { display: flex; flex-direction: column; }
    .doc-name { font-weight: 500; font-size: 14px; }
    .doc-meta { font-size: 12px; color: #5e6c84; }
    i-feather { color: #5e6c84; width: 18px; }
  `]
})
export class CardDocumentPickerComponent implements OnInit {
  documents: DocumentInfo[] = [];
  searchQuery = '';
  loading = false;

  private documentService = inject(DocumentService);
  private dialogRef = inject(MatDialogRef<CardDocumentPickerComponent>);

  ngOnInit(): void {
    this.loadDocuments();
  }

  loadDocuments(): void {
    this.loading = true;
    const resource = new DocumentResource();
    resource.pageSize = 50;
    resource.name = this.searchQuery;

    this.documentService.getDocuments(resource).subscribe({
      next: (resp) => {
        if (resp instanceof HttpResponse) {
          this.documents = resp.body || [];
        } else {
          this.documents = [];
        }
        this.loading = false;
      },
      error: () => {
        this.loading = false;
      }
    });
  }

  selectDocument(doc: DocumentInfo): void {
    this.dialogRef.close(doc);
  }

  close(): void {
    this.dialogRef.close();
  }
}
