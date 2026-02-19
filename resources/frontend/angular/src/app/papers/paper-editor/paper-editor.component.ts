import { Component, Input, OnDestroy, OnInit, ViewChild, Output, EventEmitter, OnChanges, SimpleChanges } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TranslateModule } from '@ngx-translate/core';
import { UnifiedEditorComponent } from '../../shared/unified-editor/unified-editor.component';
import { SharedModule } from '../../shared/shared.module';

@Component({
    selector: 'app-paper-editor',
    standalone: true,
    imports: [CommonModule, TranslateModule, SharedModule],
    templateUrl: './paper-editor.component.html',
    styleUrls: ['./paper-editor.component.scss']
})
export class PaperEditorComponent implements OnInit, OnDestroy, OnChanges {
    @ViewChild('unifiedEditor') unifiedEditor: UnifiedEditorComponent;
    @Input() data: any;
    @Input() readOnly: boolean = false;
    @Input() paperId: string;
    @Input() mode: 'DOC' | 'SHEET' | 'SLIDE' = 'DOC';
    @Input() contentHtml: string = '';
    @Input() isPreview: boolean = false;
    @Output() onChange = new EventEmitter<any>();

    constructor() { }

    ngOnChanges(changes: SimpleChanges): void {
        // Data updates are handled by the bridge's initialData input
    }

    ngOnInit(): void {
        // We no longer pre-load the PDF for the "PREVIEW" tab.
        // It's rendered natively via Univer for better fidelity.
    }

    ngOnDestroy(): void {
    }

    onBridgeDataChange(event: any) {
        this.onChange.emit(event);
    }

    async save() {
        if (this.unifiedEditor) {
            return await this.unifiedEditor.getData();
        }
        return this.data;
    }
}
