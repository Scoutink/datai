import { Component, inject, OnInit } from '@angular/core';
import { ActivatedRoute, Data } from '@angular/router';
import { BaseComponent } from 'src/app/base.component';
import { PaperService } from '../paper.service';
import { TranslateModule } from '@ngx-translate/core';
import { NgFor, NgIf, CommonModule, Location } from '@angular/common';
import { MatDialog } from '@angular/material/dialog';
import { MatTabChangeEvent, MatTabsModule } from '@angular/material/tabs';
import { Router } from '@angular/router';
import { PaperCommentsComponent } from './paper-comments/paper-comments.component';
import { PaperVersionHistoryComponent } from './paper-versions/paper-versions.component';
import { PaperAuditTrailComponent } from './paper-audit-trail/paper-audit-trail.component';
import { PaperPermissionComponent } from './paper-permissions/paper-permissions.component';
import { PaperShareableLinkComponent } from './paper-shareable-link/paper-shareable-link.component';
import { PaperEditorComponent } from '../paper-editor/paper-editor.component';
import { PaperPreviewComponent } from './paper-preview/paper-preview.component';
import { CategoryStore } from 'src/app/category/store/category-store';
import { ClientStore } from 'src/app/client/client-store';
import { DocumentStatusStore } from 'src/app/document-status/store/document-status.store';
import { SharedModule } from '@shared/shared.module';

@Component({
    selector: 'app-paper-detail',
    standalone: true,
    imports: [
        CommonModule,
        TranslateModule,
        SharedModule,
        MatTabsModule,
        PaperCommentsComponent,
        PaperVersionHistoryComponent,
        PaperAuditTrailComponent,
        PaperPermissionComponent,
        PaperEditorComponent,
        PaperPreviewComponent
    ],
    templateUrl: './paper-detail.component.html',
    styleUrls: ['./paper-detail.component.scss']
})
export class PaperDetailComponent extends BaseComponent implements OnInit {
    paperInfo: any = {};
    paperId: string;
    editorData: any;
    activeTabIndex: number = 0;

    public categoryStore = inject(CategoryStore);
    public clientStore = inject(ClientStore);
    public documentStatusStore = inject(DocumentStatusStore);
    private paperService = inject(PaperService);
    private route = inject(ActivatedRoute);
    private router = inject(Router);
    private location = inject(Location);
    private dialog = inject(MatDialog);

    loadedTabs: boolean[] = [true, false, false, false, false, false];

    ngOnInit(): void {
        this.sub$.sink = this.route.data.subscribe((data: Data) => {
            this.paperInfo = data['paper'];
            if (this.paperInfo) {
                this.paperId = this.paperInfo.id;
                this.editorData = this.paperInfo.contentJson ? JSON.parse(this.paperInfo.contentJson) : null;
            }
        });

        this.sub$.sink = this.route.queryParams.subscribe(params => {
            const tab = params['tab'];
            if (tab) {
                this.switchToTab(tab);
            }
        });
    }

    private switchToTab(tab: string) {
        let index = 0;
        switch (tab) {
            case 'content': index = 0; break;
            case 'general': index = 1; break;
            case 'comment': index = 2; break;
            case 'version': index = 3; break;
            case 'audit': index = 4; break;
            case 'permission': index = 5; break;
        }
        this.loadedTabs[index] = true;
        this.activeTabIndex = index;
    }

    onTabChange(event: MatTabChangeEvent): void {
        const index = event.index;
        if (!this.loadedTabs[index]) {
            this.loadedTabs[index] = true;
        }
    }

    editPaper() {
        this.router.navigate(['/papers/manage', this.paperId]);
    }

    getShareLink() {
        this.paperService.getShareLink(this.paperId).subscribe((link: any) => {
            this.dialog.open(PaperShareableLinkComponent, {
                width: '600px',
                data: {
                    paper: this.paperInfo,
                    link: link
                }
            });
        });
    }

    onPaperCancel() {
        this.location.back();
    }
}
