import { Component, inject, Input, OnChanges, SimpleChanges } from '@angular/core';
import { TranslateModule } from '@ngx-translate/core';
import { NgFor, NgIf, CommonModule } from '@angular/common';
import { MatIconModule } from '@angular/material/icon';
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
        TranslateModule,
        NgFor,
        NgIf,
        MatIconModule,
        SharedModule
    ],
    templateUrl: './paper-versions.component.html',
    styleUrls: ['./paper-versions.component.scss']
})
export class PaperVersionHistoryComponent extends BaseComponent implements OnChanges {
    @Input() paperId: string = '';
    @Input() shouldLoad = false;
    paperVersions: any[] = [];

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
                this.paperVersions = versions;
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
