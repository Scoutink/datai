import { Component, inject, Input, OnChanges, OnInit, SimpleChanges } from '@angular/core';
import { TranslateModule } from '@ngx-translate/core';
import { NgFor, NgIf, CommonModule } from '@angular/common';
import { FormBuilder, ReactiveFormsModule, UntypedFormGroup, Validators } from '@angular/forms';
import { SharedModule } from '@shared/shared.module';
import { PaperService } from '../../paper.service';
import { CommonDialogService } from '@core/common-dialog/common-dialog.service';
import { TranslationService } from '@core/services/translation.service';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from 'src/app/base.component';

@Component({
    selector: 'app-paper-comments',
    standalone: true,
    imports: [
        CommonModule,
        TranslateModule,
        SharedModule,
        ReactiveFormsModule
    ],
    templateUrl: './paper-comments.component.html',
    styleUrls: ['./paper-comments.component.scss']
})
export class PaperCommentsComponent extends BaseComponent implements OnChanges, OnInit {
    @Input() paperId: string = '';
    @Input() shouldLoad = false;
    paperComments: any[] = [];
    commentForm: UntypedFormGroup;

    private fb = inject(FormBuilder);
    private paperService = inject(PaperService);
    private commonDialogService = inject(CommonDialogService);
    private translationService = inject(TranslationService);
    private toastrService = inject(ToastrService);

    ngOnInit(): void {
        this.createForm();
    }

    ngOnChanges(changes: SimpleChanges): void {
        if (changes['shouldLoad'] && this.shouldLoad && this.paperId) {
            this.getPaperComments();
        }
    }

    createForm() {
        this.commentForm = this.fb.group({
            comment: ['', [Validators.required]],
        });
    }

    getPaperComments() {
        this.paperService
            .getComments(this.paperId)
            .subscribe((c: any[]) => {
                this.paperComments = c;
            });
    }

    addComment() {
        if (this.commentForm.invalid) {
            this.commentForm.markAllAsTouched();
            return;
        }
        const paperComment = {
            paperId: this.paperId,
            comment: this.commentForm.get('comment').value,
        };
        this.paperService
            .addComment(paperComment)
            .subscribe(() => {
                this.commentForm.patchValue({ comment: '' });
                this.commentForm.markAsUntouched();
                this.getPaperComments();
            });
    }

    onDelete(id: string) {
        this.commonDialogService
            .deleteConformationDialog(
                this.translationService.getValue('ARE_YOU_SURE_YOU_WANT_TO_DELETE')
            )
            .subscribe((isTrue: boolean) => {
                if (isTrue) {
                    this.paperService
                        .deleteComment(id)
                        .subscribe(() => {
                            this.toastrService.success(
                                this.translationService.getValue(`COMMENT_DELETED_SUCCESSFULLY`)
                            );
                            this.getPaperComments();
                        });
                }
            });
    }
}
