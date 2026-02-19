import { Component, Input, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { BaseComponent } from 'src/app/base.component';

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

    viewMode: 'PREVIEW' | 'LIVE' = 'PREVIEW';
    documentUrl: Blob | string = null;
    isLoading = false;

    private paperService = inject(PaperService);
    private toastrService = inject(ToastrService);

    ngOnInit(): void {
    }

    toggleViewMode() {
        this.viewMode = this.viewMode === 'PREVIEW' ? 'LIVE' : 'PREVIEW';
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
