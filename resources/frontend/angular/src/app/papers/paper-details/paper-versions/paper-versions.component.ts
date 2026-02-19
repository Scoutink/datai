import { Component, inject, Input, OnChanges, SimpleChanges, ViewChild } from '@angular/core';
import { TranslateModule } from '@ngx-translate/core';
import { NgFor, NgIf, CommonModule } from '@angular/common';
import { MatIconModule } from '@angular/material/icon';
import { MatPaginator, MatPaginatorModule } from '@angular/material/paginator';
import { MatTableDataSource, MatTableModule } from '@angular/material/table';
import { SharedModule } from '@shared/shared.module';
import { PaperService } from '../../paper.service';
import { ToastrService } from 'ngx-toastr';
import { TranslationService } from '@core/services/translation.service';
import { CommonDialogService } from '@core/common-dialog/common-dialog.service';
import { BaseComponent } from 'src/app/base.component';

@Component({
    selector: 'app-paper-versions',
    standalone: true,
    imports: [
        CommonModule,
        MatTableModule,
        TranslateModule,
        MatPaginatorModule,
        MatIconModule,
        SharedModule
    ],
    templateUrl: './paper-versions.component.html',
    styleUrls: ['./paper-versions.component.scss']
})
export class PaperVersionHistoryComponent extends BaseComponent implements OnChanges {
    @Input() paperId: string = '';
    @Input() shouldLoad = false;

    dataSource = new MatTableDataSource<any>();
    displayedColumns: string[] = ['version', 'createdBy', 'createdDate', 'action'];

    @ViewChild(MatPaginator) paginator: MatPaginator;

    private paperService = inject(PaperService);
    private toastrService = inject(ToastrService);
    private translationService = inject(TranslationService);
    private commandDialogService = inject(CommonDialogService);

    ngOnChanges(changes: SimpleChanges): void {
        if (changes['shouldLoad'] && this.shouldLoad && this.paperId) {
            this.getPaperVersions();
        }
    }

    getPaperVersions() {
        this.paperService
            .getVersions(this.paperId)
            .subscribe((versions: any[]) => {
                this.dataSource.data = versions;
                this.dataSource.paginator = this.paginator;
            });
    }

    restoreVersion(version: any) {
        this.commandDialogService
            .deleteConformationDialog(
                `${this.translationService.getValue(
                    'ARE_YOU_SURE_YOU_WANT_TO_RESTORE_THIS_TO_CURRENT_VERSION'
                )}?`
            )
            .subscribe((isTrue) => {
                if (isTrue) {
                    this.paperService
                        .restoreVersion(version.id)
                        .subscribe(() => {
                            this.toastrService.success(this.translationService.getValue('VERSION_RESTORED_SUCCESSFULLY'));
                            this.getPaperVersions();
                            // Optionally trigger a page refresh or notify parent to reload content
                        });
                }
            });
    }
}
