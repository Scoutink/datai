import { HttpEvent, HttpEventType } from '@angular/common/http';
import { Component, Input, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TranslateModule } from '@ngx-translate/core';
import { MaterialModule } from '@shared/material.module';
import { FeatherIconsModule } from 'src/app/feather-icons/feather-icons.module';
import { BaseComponent } from 'src/app/base.component';
import { PaperService } from '../../paper.service';
import { PaperEditorComponent } from '../../paper-editor/paper-editor.component';

@Component({
    selector: 'app-paper-preview',
    standalone: true,
    imports: [
        CommonModule,
        TranslateModule,
        MaterialModule,
        FeatherIconsModule,
        PaperEditorComponent
    ],
    templateUrl: './paper-preview.component.html',
    styleUrls: ['./paper-preview.component.scss']
})
export class PaperPreviewComponent extends BaseComponent implements OnInit {
    @Input() paperId: string;
    @Input() paperInfo: any;
    @Input() editorData: any;
    @Input() viewOnlyMode = true;

    documentUrl: Blob | string = null;
    isLoading = false;

    private paperService = inject(PaperService);

    ngOnInit(): void {
    }

    download() {
        this.paperService.downloadPaperPdf(this.paperId).subscribe((event: HttpEvent<Blob>) => {
            if (event.type === HttpEventType.Response) {
                const url = window.URL.createObjectURL(event.body);
                const a = document.createElement('a');
                a.href = url;
                a.download = `${this.paperInfo.name || 'paper'}.pdf`;
                a.click();
                window.URL.revokeObjectURL(url);
            }
        });
    }
}
