import { Component, inject, Input, OnChanges, SimpleChanges, ViewChild } from '@angular/core';
import { TranslateModule } from '@ngx-translate/core';
import { NgIf, NgFor, CommonModule } from '@angular/common';
import { MatTableDataSource, MatTableModule } from '@angular/material/table';
import { MatPaginator, MatPaginatorModule } from '@angular/material/paginator';
import { SharedModule } from '@shared/shared.module';
import { MatDialog } from '@angular/material/dialog';
import { CommonDialogService } from '@core/common-dialog/common-dialog.service';
import { TranslationService } from '@core/services/translation.service';
import { ToastrService } from 'ngx-toastr';
import { PaperService } from '../../paper.service';
import { CommonService } from '@core/services/common.service';
import { BaseComponent } from 'src/app/base.component';
import { ManagePaperUserPermissionComponent } from './manage-paper-user-permission.component';
import { ManagePaperRolePermissionComponent } from './manage-paper-role-permission.component';

@Component({
    selector: 'app-paper-permissions',
    standalone: true,
    imports: [
        CommonModule,
        NgIf,
        MatTableModule,
        TranslateModule,
        MatPaginatorModule,
        SharedModule
    ],
    templateUrl: './paper-permissions.component.html',
    styleUrls: ['./paper-permissions.component.scss']
})
export class PaperPermissionComponent extends BaseComponent implements OnChanges {
    @Input() paperId: string;
    @Input() shouldLoad = false;

    permissionsDataSource: MatTableDataSource<any>;
    @ViewChild(MatPaginator) paginator: MatPaginator;

    displayedColumns = [
        'action',
        'isAllowDownload',
        'type',
        'name',
        'email',
        'startDate',
        'endDate'
    ];

    private paperService = inject(PaperService);
    private commonDialogService = inject(CommonDialogService);
    private translationService = inject(TranslationService);
    private toastrService = inject(ToastrService);
    private commonService = inject(CommonService);
    private dialog = inject(MatDialog);

    ngOnChanges(changes: SimpleChanges): void {
        if (changes['shouldLoad'] && this.shouldLoad && this.paperId) {
            this.getPaperPermissions();
        }
    }

    getPaperPermissions() {
        this.paperService
            .getPermissions(this.paperId)
            .subscribe((permission: any[]) => {
                this.permissionsDataSource = new MatTableDataSource(permission);
                this.permissionsDataSource.paginator = this.paginator;
            });
    }

    deleteUserPermission(permission: any) {
        this.commonDialogService
            .deleteConformationDialog(
                this.translationService.getValue('ARE_YOU_SURE_YOU_WANT_TO_DELETE')
            )
            .subscribe((isTrue: boolean) => {
                if (isTrue) {
                    this.paperService
                        .deleteUserPermission(permission.id)
                        .subscribe(() => {
                            this.toastrService.success(
                                this.translationService.getValue('PERMISSION_DELETED_SUCCESSFULLY')
                            );
                            this.getPaperPermissions();
                        });
                }
            });
    }

    deleteRolePermission(permission: any) {
        this.commonDialogService
            .deleteConformationDialog(
                this.translationService.getValue('ARE_YOU_SURE_YOU_WANT_TO_DELETE')
            )
            .subscribe((isTrue: boolean) => {
                if (isTrue) {
                    this.paperService
                        .deleteRolePermission(permission.id)
                        .subscribe(() => {
                            this.toastrService.success(
                                this.translationService.getValue('PERMISSION_DELETED_SUCCESSFULLY')
                            );
                            this.getPaperPermissions();
                        });
                }
            });
    }

    addPaperUserPermission(): void {
        this.commonService.getUsersForDropdown().subscribe((users: any[]) => {
            const dialogRef = this.dialog.open(ManagePaperUserPermissionComponent, {
                width: '600px',
                data: { users: users, paperId: this.paperId },
            });
            dialogRef.afterClosed().subscribe((result: boolean) => {
                if (result) {
                    this.getPaperPermissions();
                }
            });
        });
    }

    addPaperRolePermission(): void {
        this.commonService.getRolesForDropdown().subscribe((roles: any[]) => {
            const dialogRef = this.dialog.open(ManagePaperRolePermissionComponent, {
                width: '600px',
                data: { roles: roles, paperId: this.paperId },
            });
            dialogRef.afterClosed().subscribe((result: boolean) => {
                if (result) {
                    this.getPaperPermissions();
                }
            });
        });
    }
}
