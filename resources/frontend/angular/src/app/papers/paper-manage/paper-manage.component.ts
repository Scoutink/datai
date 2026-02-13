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
            this.editorData = JSON.parse(paper.contentJson);
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

        const payload = {
            ...this.paperForm.value,
            contentJson: JSON.stringify(this.editorData)
        };

        if (this.isEditMode) {
            this.sub$.sink = this.paperService.updatePaper(this.paperId, payload).subscribe(() => {
                this.toastrService.success('Paper updated successfully');
                this.router.navigate(['/papers']);
            });
        } else {
            this.sub$.sink = this.paperService.addPaper(payload).subscribe(() => {
                this.toastrService.success('Paper created successfully');
                this.router.navigate(['/papers']);
            });
        }
    }
}
