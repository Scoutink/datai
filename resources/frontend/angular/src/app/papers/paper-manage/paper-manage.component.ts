import { Component, OnInit, ViewChild } from '@angular/core';
import { UntypedFormBuilder, UntypedFormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { BaseComponent } from 'src/app/base.component';
import { PaperService } from '../paper.service';
import { ToastrService } from 'ngx-toastr';
import { TranslationService } from '@core/services/translation.service';
import { CategoryStore } from 'src/app/category/store/category-store';
import { ClientStore } from 'src/app/client/client-store';
import { DocumentStatusStore } from 'src/app/document-status/store/document-status.store';
import { PaperEditorComponent } from '../paper-editor/paper-editor.component';
import { inject } from '@angular/core';
import { PaperContentType } from '../paper-content-type.enum';

@Component({
    selector: 'app-paper-manage',
    templateUrl: './paper-manage.component.html',
    styleUrls: ['./paper-manage.component.scss']
})
export class PaperManageComponent extends BaseComponent implements OnInit {
    @ViewChild(PaperEditorComponent) editor: PaperEditorComponent;
    paperForm: UntypedFormGroup;
    paperId: string;
    isEditMode: boolean = false;
    paperData: any;
    editorData: any;
    initialSheetData: any;
    paperContentType = PaperContentType;

    public categoryStore = inject(CategoryStore);
    public clientStore = inject(ClientStore);
    public documentStatusStore = inject(DocumentStatusStore);

    constructor(
        private fb: UntypedFormBuilder,
        private route: ActivatedRoute,
        private router: Router,
        private paperService: PaperService,
        private toastrService: ToastrService,
        private translationService: TranslationService
    ) {
        super();
        this.createForm();
    }

    ngOnInit(): void {
        this.paperId = this.route.snapshot.params['id'];
        if (this.paperId) {
            this.isEditMode = true;
            this.getPaper();
        }
    }

    createForm() {
        this.paperForm = this.fb.group({
            name: ['', [Validators.required]],
            contentType: [PaperContentType.DOC, [Validators.required]],
            categoryId: ['', [Validators.required]],
            clientId: [''],
            statusId: [''],
            description: ['']
        });
    }

    getPaper() {
        this.sub$.sink = this.paperService.getPaper(this.paperId).subscribe((paper: any) => {
            this.paperData = paper;
            this.paperForm.patchValue(paper);
            if (paper.contentJson) {
                try {
                    this.editorData = JSON.parse(paper.contentJson);
                } catch (e) {
                    console.error('Failed to parse paper content JSON:', e);
                    this.editorData = null;
                }
            }
        });
    }

    onEditorChange(data: any) {
        this.editorData = data;
    }

    async savePaper() {
        if (this.paperForm.invalid) {
            this.paperForm.markAllAsTouched();
            return;
        }

        // Use the snapshot from the editor if it's currently active
        const finalData = await this.editor.save();

        const payload = {
            ...this.paperForm.value,
            contentJson: JSON.stringify(finalData)
        };

        if (this.isEditMode) {
            this.sub$.sink = this.paperService.updatePaper(this.paperId, payload).subscribe(() => {
                this.toastrService.success('Paper updated successfully');
                this.router.navigate(['/papers/assigned']);
            });
        } else {
            this.sub$.sink = this.paperService.addPaper(payload).subscribe(() => {
                this.toastrService.success('Paper created successfully');
                this.router.navigate(['/papers/assigned']);
            });
        }
    }
}
