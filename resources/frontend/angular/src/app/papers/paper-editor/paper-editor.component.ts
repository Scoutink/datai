import { Component, ElementRef, Input, OnDestroy, OnInit, ViewChild, Output, EventEmitter, ViewEncapsulation, OnChanges, SimpleChanges } from '@angular/core';
import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header';
import List from '@editorjs/list';
import ImageTool from '@editorjs/image';
import InlineCode from '@editorjs/inline-code';
import Table from '@editorjs/table';
import LinkTool from '@editorjs/link';
import Embed from '@editorjs/embed';
import Quote from '@editorjs/quote';
import Marker from '@editorjs/marker';
import Checklist from '@editorjs/checklist';
import Delimiter from '@editorjs/delimiter';
import Warning from '@editorjs/warning';
import CodeTool from '@editorjs/code';
import { environment } from '@environments/environment';
import { CommonModule } from '@angular/common';
import { TranslateModule } from '@ngx-translate/core';

@Component({
    selector: 'app-paper-editor',
    standalone: true,
    imports: [CommonModule, TranslateModule],
    templateUrl: './paper-editor.component.html',
    styleUrls: ['./paper-editor.component.scss']
})
export class PaperEditorComponent implements OnInit, OnDestroy, OnChanges {
    @ViewChild('editorContainer', { static: true }) editorContainer: ElementRef;
    @Input() data: any;
    @Input() readOnly: boolean = false;
    @Input() paperId: string;
    @Output() onChange = new EventEmitter<any>();

    private editor: EditorJS;

    constructor() { }

    ngOnChanges(changes: SimpleChanges): void {
        if (changes['data'] && !changes['data'].firstChange && this.editor) {
            this.editor.isReady.then(() => {
                this.editor.render(this.data);
            });
        }
    }

    ngOnInit(): void {
        this.initEditor();
    }

    ngOnDestroy(): void {
        if (this.editor) {
            this.editor.destroy();
        }
    }

    private initEditor() {
        this.editor = new EditorJS({
            holder: this.editorContainer.nativeElement,
            readOnly: this.readOnly,
            data: this.data || {},
            tools: {
                header: {
                    class: Header,
                    shortcut: 'CMD+SHIFT+H',
                    config: { placeholder: 'Enter a header', levels: [1, 2, 3, 4], defaultLevel: 2 }
                },
                list: { class: List, inlineToolbar: true },
                checklist: { class: Checklist, inlineToolbar: true },
                image: {
                    class: ImageTool,
                    config: {
                        endpoints: {
                            byFile: `${environment.apiUrl}api/papers/assets/upload`,
                        },
                        additionalRequestData: {
                            paperId: this.paperId
                        }
                    }
                },
                table: { class: Table as any, inlineToolbar: true },
                linkTool: {
                    class: LinkTool,
                    config: {
                        endpoint: `${environment.apiUrl}api/papers/assets/fetch-url`,
                    }
                },
                embed: { class: Embed, inlineToolbar: true },
                quote: { class: Quote, inlineToolbar: true },
                marker: { class: Marker },
                inlineCode: { class: InlineCode },
                code: { class: CodeTool },
                delimiter: { class: Delimiter },
                warning: { class: Warning, inlineToolbar: true }
            },
            onChange: async () => {
                const savedData = await this.editor.save();
                this.onChange.emit(savedData);
            },
            placeholder: 'Let`s write an awesome story!'
        });
    }

    async save() {
        return await this.editor.save();
    }
}
