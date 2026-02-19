import { Component, Inject, OnInit, inject } from '@angular/core';
import { UntypedFormBuilder, UntypedFormControl, UntypedFormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { MatCheckboxChange, MatCheckboxModule } from '@angular/material/checkbox';
import { MAT_DIALOG_DATA, MatDialogRef, MatDialogModule } from '@angular/material/dialog';
import { TranslationService } from '@core/services/translation.service';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from 'src/app/base.component';
import { PaperService } from '../../paper.service';
import { TranslateModule } from '@ngx-translate/core';
import { CommonModule } from '@angular/common';
import { SharedModule } from '@shared/shared.module';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { NgSelectModule } from '@ng-select/ng-select';
import { OwlDateTimeModule, OwlNativeDateTimeModule } from 'ng-pick-datetime-ex';
import { FeatherIconsModule } from '@shared/feather-icons.module';

@Component({
    selector: 'app-manage-paper-user-permission',
    standalone: true,
    imports: [
        CommonModule,
        TranslateModule,
        SharedModule,
        ReactiveFormsModule,
        MatDialogModule,
        MatCheckboxModule,
        MatIconModule,
        MatButtonModule,
        NgSelectModule,
        OwlDateTimeModule,
        OwlNativeDateTimeModule,
        FeatherIconsModule
    ],
    templateUrl: './manage-paper-user-permission.component.html',
    styleUrls: ['./manage-paper-user-permission.component.scss']
})
export class ManagePaperUserPermissionComponent extends BaseComponent implements OnInit {
    minDate: Date;
    permissionForm: UntypedFormGroup;

    private paperService = inject(PaperService);
    private toastrService = inject(ToastrService);
    private fb = inject(UntypedFormBuilder);
    private translationService = inject(TranslationService);
    public dialogRef = inject(MatDialogRef<ManagePaperUserPermissionComponent>);

    constructor(
        @Inject(MAT_DIALOG_DATA) public data: { users: any[]; paperId: string }
    ) {
        super();
        this.minDate = new Date();
    }

    ngOnInit(): void {
        this.createUserPermissionForm();
    }

    closeDialog() {
        this.dialogRef.close();
    }

    createUserPermissionForm() {
        this.permissionForm = this.fb.group({
            isTimeBound: new UntypedFormControl(false),
            startDate: [''],
            endDate: [''],
            isAllowDownload: new UntypedFormControl(false),
            selectedUsers: [],
        });
    }

    timeBoundChange(event: MatCheckboxChange) {
        if (event.checked) {
            this.permissionForm.get('startDate').setValidators([Validators.required]);
            this.permissionForm.get('endDate').setValidators([Validators.required]);
        } else {
            this.permissionForm.get('startDate').clearValidators();
            this.permissionForm.get('startDate').updateValueAndValidity();
            this.permissionForm.get('endDate').clearValidators();
            this.permissionForm.get('endDate').updateValueAndValidity();
        }
    }

    savePaperUserPermission() {
        if (!this.permissionForm.valid) {
            this.permissionForm.markAllAsTouched();
            return;
        }
        const selectedUsers: any[] = this.permissionForm.get('selectedUsers').value ?? [];
        if (selectedUsers?.length == 0) {
            this.toastrService.error(
                this.translationService.getValue('PLEASE_SELECT_ATLEAST_ONE_USER')
            );
            return;
        }
        const paperUserPermissions = selectedUsers.map((user) => {
            return {
                ...this.permissionForm.value,
                id: '',
                paperId: this.data.paperId,
                userId: user.id,
            };
        });

        this.paperService
            .addUserPermission(paperUserPermissions)
            .subscribe(() => {
                this.toastrService.success(
                    this.translationService.getValue('PERMISSION_ADDED_SUCCESSFULLY')
                );
                this.dialogRef.close(true);
            });
    }

    onNoClick() {
        this.dialogRef.close();
    }
}
