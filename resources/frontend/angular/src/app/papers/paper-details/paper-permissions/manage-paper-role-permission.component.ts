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
    selector: 'app-manage-paper-role-permission',
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
    templateUrl: './manage-paper-role-permission.component.html',
    styleUrls: ['./manage-paper-role-permission.component.scss']
})
export class ManagePaperRolePermissionComponent extends BaseComponent implements OnInit {
    minDate: Date;
    permissionForm: UntypedFormGroup;

    private paperService = inject(PaperService);
    private toastrService = inject(ToastrService);
    private fb = inject(UntypedFormBuilder);
    private translationService = inject(TranslationService);
    public dialogRef = inject(MatDialogRef<ManagePaperRolePermissionComponent>);

    constructor(
        @Inject(MAT_DIALOG_DATA) public data: { roles: any[]; paperId: string }
    ) {
        super();
        this.minDate = new Date();
    }

    ngOnInit(): void {
        this.createRolePermissionForm();
    }

    closeDialog() {
        this.dialogRef.close();
    }

    createRolePermissionForm() {
        this.permissionForm = this.fb.group({
            isTimeBound: new UntypedFormControl(false),
            startDate: [''],
            endDate: [''],
            isAllowDownload: new UntypedFormControl(false),
            selectedRoles: [],
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

    savePaperRolePermission() {
        if (!this.permissionForm.valid) {
            this.permissionForm.markAllAsTouched();
            return;
        }
        const selectedRoles: any[] = this.permissionForm.get('selectedRoles').value ?? [];
        if (selectedRoles?.length == 0) {
            this.toastrService.error(
                this.translationService.getValue('PLEASE_SELECT_ATLEAST_ONE_ROLE')
            );
            return;
        }
        const paperRolePermissions = selectedRoles.map((role) => {
            return {
                ...this.permissionForm.value,
                id: '',
                paperId: this.data.paperId,
                roleId: role.id,
            };
        });

        this.paperService
            .addRolePermission(paperRolePermissions)
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
