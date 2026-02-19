import { Component, Inject, OnInit, inject } from '@angular/core';
import { UntypedFormGroup, UntypedFormBuilder, UntypedFormControl, ReactiveFormsModule } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialogModule } from '@angular/material/dialog';
import { CommonDialogService } from '@core/common-dialog/common-dialog.service';
import { ToastrService } from 'ngx-toastr';
import { PaperService } from '../../paper.service';
import { TranslationService } from '@core/services/translation.service';
import { BaseComponent } from 'src/app/base.component';
import { TranslateModule } from '@ngx-translate/core';
import { CommonModule } from '@angular/common';
import { SharedModule } from '@shared/shared.module';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { OwlDateTimeModule, OwlNativeDateTimeModule } from 'ng-pick-datetime-ex';
import { ClipboardModule } from '@angular/cdk/clipboard';

@Component({
    selector: 'app-paper-shareable-link',
    standalone: true,
    imports: [
        CommonModule,
        TranslateModule,
        SharedModule,
        ReactiveFormsModule,
        MatDialogModule,
        MatIconModule,
        MatButtonModule,
        MatInputModule,
        MatFormFieldModule,
        MatSlideToggleModule,
        OwlDateTimeModule,
        OwlNativeDateTimeModule,
        ClipboardModule
    ],
    templateUrl: './paper-shareable-link.component.html',
    styleUrls: ['./paper-shareable-link.component.scss']
})
export class PaperShareableLinkComponent extends BaseComponent implements OnInit {
    paperLinkForm: UntypedFormGroup;
    isEditMode = false;
    isResetLink = false;
    minDate = new Date();
    baseUrl = `${window.location.protocol}//${window.location.host}/papers/preview/`;

    private fb = inject(UntypedFormBuilder);
    private paperService = inject(PaperService);
    private toastrService = inject(ToastrService);
    private commonDialogService = inject(CommonDialogService);
    private translationService = inject(TranslationService);
    public dialogRef = inject(MatDialogRef<PaperShareableLinkComponent>);

    constructor(
        @Inject(MAT_DIALOG_DATA) public data: { paper: any; link: any }
    ) {
        super();
    }

    ngOnInit(): void {
        this.createPaperLinkForm();
        if (this.data.link && this.data.link.id) {
            this.isEditMode = true;
            this.patchValue();
        }
    }

    patchValue() {
        this.paperLinkForm.patchValue(this.data.link);
        this.paperLinkForm
            .get('linkCode')
            .setValue(`${this.baseUrl}${this.data.link.code}`);

        if (this.data.link.expiresAt) {
            this.paperLinkForm.get('isLinkExpiryTime').setValue(true);
            this.paperLinkForm.get('linkExpiryTime').setValue(this.data.link.expiresAt);
        }
        if (this.data.link.hasPassword) {
            this.paperLinkForm.get('isPassword').setValue(true);
        }
    }

    createPaperLinkForm() {
        this.paperLinkForm = this.fb.group({
            id: [''],
            isLinkExpiryTime: new UntypedFormControl(false),
            linkExpiryTime: [''],
            isPassword: new UntypedFormControl(false),
            password: [''],
            linkCode: [''],
            isAllowDownload: new UntypedFormControl(false),
        }, {
            validator: this.checkData,
        });
    }

    checkData(group: UntypedFormGroup) {
        const isLinkExpiryTime = group.get('isLinkExpiryTime').value;
        const linkExpiryTime = group.get('linkExpiryTime').value;
        const isPassword = group.get('isPassword').value;
        const password = group.get('password').value;
        const data = {};
        if (isLinkExpiryTime && !linkExpiryTime) {
            data['linkExpiryTimeValidator'] = true;
        }
        if (isPassword && !password) {
            data['passwordValidator'] = true;
        }
        return data;
    }

    createLink() {
        if (!this.paperLinkForm.valid) {
            this.paperLinkForm.markAllAsTouched();
            return;
        }
        const link = this.createBuildObject();
        this.paperService
            .saveShareLink(link)
            .subscribe((data: any) => {
                this.toastrService.success(
                    this.translationService.getValue('LINK_GENERATED_SUCCESSFULLY')
                );
                this.data.link = data;
                this.isEditMode = true;
                this.isResetLink = false;
                this.patchValue();
            });
    }

    deleteLink() {
        this.commonDialogService
            .deleteConformationDialog(
                this.translationService.getValue('ARE_YOU_SURE_YOU_WANT_TO_DELETE')
            )
            .subscribe((isTrue: boolean) => {
                if (isTrue) {
                    this.paperService
                        .deleteShareLink(this.data.link.id)
                        .subscribe(() => {
                            this.toastrService.success(
                                this.translationService.getValue('DOCUMENT_LINK_DELETED_SUCCESSFULLY')
                            );
                            this.dialogRef.close(true);
                        });
                }
            });
    }

    createBuildObject(): any {
        const id = this.paperLinkForm.get('id').value;
        let linkCode = this.paperLinkForm.get('linkCode').value;
        if (linkCode) {
            linkCode = linkCode.replace(this.baseUrl, '');
        }
        return {
            id: id,
            paperId: this.data.paper.id,
            isAllowDownload: this.paperLinkForm.get('isAllowDownload').value,
            password: this.paperLinkForm.get('isPassword').value
                ? this.paperLinkForm.get('password').value
                : '',
            hasPassword: this.paperLinkForm.get('isPassword').value,
            expiresAt: this.paperLinkForm.get('isLinkExpiryTime').value
                ? this.paperLinkForm.get('linkExpiryTime').value
                : '',
            code: linkCode,
        };
    }

    closeDialog() {
        this.dialogRef.close();
    }
}
