import { Component, ElementRef, EventEmitter, Input, OnDestroy, OnInit, Output, ViewChild, AfterViewInit, OnChanges, SimpleChanges } from '@angular/core';
import { Univer, UniverInstanceType, LocaleType, Tools, IUniverInstanceService } from '@univerjs/core';
import { FUniver } from '@univerjs/core/lib/facade';
import { UniverDocsCorePreset } from '@univerjs/preset-docs-core';
import { UniverSheetsCorePreset } from '@univerjs/preset-sheets-core';

import { UniverDocsPlugin } from '@univerjs/docs';
import { UniverDocsUIPlugin } from '@univerjs/docs-ui';
import { UniverSheetsPlugin } from '@univerjs/sheets';
import { UniverSheetsUIPlugin } from '@univerjs/sheets-ui';
import { UniverSheetsFormulaPlugin } from '@univerjs/sheets-formula';
import { UniverSheetsFormulaUIPlugin } from '@univerjs/sheets-formula-ui';
import { UniverRenderEnginePlugin } from '@univerjs/engine-render';
import { UniverFormulaEnginePlugin } from '@univerjs/engine-formula';
import { UniverUIPlugin } from '@univerjs/ui';
import { UniverNetworkPlugin } from '@univerjs/network';
import { UniverDrawingPlugin } from '@univerjs/drawing';
import { UniverDrawingUIPlugin } from '@univerjs/drawing-ui';
import { UniverDocsDrawingPlugin } from '@univerjs/docs-drawing';
import { UniverDocsDrawingUIPlugin } from '@univerjs/docs-drawing-ui';
import { UniverDocsHyperLinkPlugin } from '@univerjs/docs-hyper-link';
import { UniverDocsHyperLinkUIPlugin } from '@univerjs/docs-hyper-link-ui';
import { UniverSheetsDrawingPlugin } from '@univerjs/sheets-drawing';
import { UniverSheetsDrawingUIPlugin } from '@univerjs/sheets-drawing-ui';
import { UniverSheetsHyperLinkPlugin } from '@univerjs/sheets-hyper-link';
import { UniverSheetsHyperLinkUIPlugin } from '@univerjs/sheets-hyper-link-ui';

import { HttpClient } from '@angular/common/http';
import { lastValueFrom, defaultIfEmpty } from 'rxjs';
import { IImageIoService, ImageSourceType, ImageUploadStatusType } from '@univerjs/core';

import "@univerjs/core/lib/facade";
import "@univerjs/docs-ui/lib/facade";
import "@univerjs/sheets-ui/lib/facade";

import DocsEnUS from '@univerjs/preset-docs-core/locales/en-US';
import SheetsEnUS from '@univerjs/preset-sheets-core/locales/en-US';
import DesignEnUS from '@univerjs/design/locale/en-US';
import UIEnUS from '@univerjs/ui/locale/en-US';

// Locales (Simplified to avoid build errors; branding masked via container/loader)

@Component({
    selector: 'app-unified-editor',
    template: `
        <div class="unified-editor-container">
            <!-- Light Viewer Mode (100% stable, no UniverJS engine) -->
            <div *ngIf="readOnly && !isPreview" class="light-viewer" #lightViewer>
                <div *ngIf="mode === 'DOC'" [innerHTML]="staticHtml" class="doc-viewer-content"></div>
                <!-- Static Sheet Viewer -->
                <div *ngIf="mode === 'SHEET'" class="sheet-static-viewer">
                    <table class="static-grid">
                        <tr *ngFor="let row of staticSheetData; let rowIndex = index">
                            <td *ngFor="let cell of row; let colIndex = index" 
                                [style.background-color]="cell.bg"
                                [style.color]="cell.cl"
                                [style.font-weight]="cell.bl ? 'bold' : 'normal'">
                                {{ cell.v }}
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <!-- Heavy Editor / Preview Mode (UniverJS) -->
            <div *ngIf="!readOnly || isPreview" class="heavy-editor" [class.preview-mode]="isPreview">
                <div *ngIf="isLoading" class="editor-loader">
                    <mat-progress-spinner mode="indeterminate" diameter="40"></mat-progress-spinner>
                    <p>{{ 'LOADING_EDITOR' | translate }}</p>
                </div>
                <div #editorContainer class="editor-mount-point"></div>
            </div>
        </div>
    `,
    styles: [`
        .unified-editor-container {
            width: 100%;
            height: 100%;
            min-height: 500px;
            position: relative;
        }
        .light-viewer {
            padding: 20px;
            background: white;
            border: 1px solid #eee;
            border-radius: 4px;
            height: 100%;
            overflow: auto;
        }
        .doc-viewer-content {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
            color: #333;
        }
        .static-grid {
            border-collapse: collapse;
            font-size: 13px;
        }
        .static-grid td {
            border: 1px solid #d4d4d4;
            padding: 4px 8px;
            min-width: 80px;
            height: 22px;
        }
        .heavy-editor {
            width: 100%;
            height: 80vh;
            position: relative;
        }
        .editor-mount-point {
            width: 100% !important;
            height: 100% !important;
            display: block;
        }
        .editor-loader {
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            display: flex; flex-direction: column;
            align-items: center; justify-content: center;
            z-index: 1000;
            background: rgba(255,255,255,0.8);
        }
        :host ::ng-deep .univer-toolbar-item[title*="Table"] { display: none !important; }
        
        /* Clean UI for Preview Mode */
        .preview-mode ::ng-deep .univer-workbench-container-header,
        .preview-mode ::ng-deep .univer-workbench-container-footer-toolbar,
        .preview-mode ::ng-deep .univer-doc-ui-toolbar,
        .preview-mode ::ng-deep .univer-sheet-ui-toolbar {
            display: none !important;
        }
        .preview-mode ::ng-deep .univer-workbench-container-content {
            top: 0 !important;
            bottom: 30px !important; /* Keep sheet tabs visible */
        }
        .preview-mode.mode-doc ::ng-deep .univer-workbench-container-footer {
             display: none !important;
        }
    `]
})
export class UnifiedEditorComponent implements OnInit, AfterViewInit, OnDestroy, OnChanges {
    @Input() mode: 'DOC' | 'SHEET' | 'SLIDE' = 'DOC';
    @Input() initialData: any = null;
    @Input() paperId: string = '';
    @Input() readOnly: boolean = false;
    @Input() isPreview: boolean = false; // New: High-fidelity preview mode
    @Input() contentHtml: string = ''; // New: pre-rendered HTML for light view
    @Output() onDataChange = new EventEmitter<any>();
    @Output() onReady = new EventEmitter<void>();

    @ViewChild('editorContainer') editorContainer!: ElementRef<HTMLDivElement>;

    public isLoading: boolean = true;
    public staticHtml: string = '';
    public staticSheetData: any[][] = [];

    private univer: any = null;
    private univerAPI: any = null;
    private isDestroyed: boolean = false;
    private readOnlyKeydownHandler: ((event: KeyboardEvent) => void) | null = null;
    private readOnlyPasteHandler: ((event: ClipboardEvent) => void) | null = null;
    private readOnlyCutHandler: ((event: ClipboardEvent) => void) | null = null;

    constructor(private http: HttpClient) { }

    ngOnInit(): void {
        if (this.readOnly && !this.isPreview) {
            this.prepareLightView();
        }
    }

    ngOnChanges(changes: SimpleChanges): void {
        if (this.readOnly && !this.isPreview) {
            this.prepareLightView();
            return;
        }

        const modeChanged = changes['mode'] && !changes['mode'].firstChange;
        const dataChanged = changes['initialData'] && !changes['initialData'].firstChange;
        const readOnlyChanged = changes['readOnly'] && !changes['readOnly'].firstChange;
        const previewChanged = changes['isPreview'] && !changes['isPreview'].firstChange;

        if (modeChanged || dataChanged || readOnlyChanged || previewChanged) {
            this.reinitEditor();
        }
    }

    private prepareLightView() {
        this.isLoading = false;
        if (this.mode === 'DOC') {
            // User can pass direct HTML or we derive from initialData if missing
            this.staticHtml = this.contentHtml || this.deriveHtmlFromDoc(this.initialData);
        } else if (this.mode === 'SHEET') {
            this.staticSheetData = this.deriveGridFromSheet(this.initialData);
        }
    }

    private deriveHtmlFromDoc(data: any): string {
        if (!data || !data.body || !data.body.dataStream) return '<i>No content</i>';
        // Simple text-to-html converter (fallback)
        let html = data.body.dataStream.replace(/\r\n/g, '<br>').replace(/\n/g, '<br>');
        return `<div class="univer-doc-mock">${html}</div>`;
    }

    private deriveGridFromSheet(data: any): any[][] {
        if (!data || !data.sheets) return [];
        const firstSheetKey = Object.keys(data.sheets)[0];
        const sheet = data.sheets[firstSheetKey];
        if (!sheet || !sheet.cellData) return [];

        const grid: any[][] = [];
        const rows = Math.min(sheet.rowCount || 20, 50); // Cap view for performance
        const cols = Math.min(sheet.columnCount || 10, 26);

        for (let r = 0; r < rows; r++) {
            const rowArr = [];
            for (let c = 0; c < cols; c++) {
                const cell = (sheet.cellData[r] && sheet.cellData[r][c]) ? sheet.cellData[r][c] : {};
                rowArr.push({
                    v: cell.v || '',
                    bg: cell.s ? '#f9f9f9' : 'transparent', // Minimal styling mock
                    cl: '#000',
                    bl: false
                });
            }
            grid.push(rowArr);
        }
        return grid;
    }

    private reinitEditor() {
        this.disposeUniver();
        this.isLoading = true;
        setTimeout(() => {
            if (this.isDestroyed) return;
            this.ensureContainerReady();
        }, 100);
    }

    ngAfterViewInit(): void {
        if (!this.readOnly || this.isPreview) {
            this.ensureContainerReady();
        }
    }

    private ensureContainerReady(attempts = 0) {
        if (this.univer || this.isDestroyed) return;

        const container = this.editorContainer?.nativeElement;
        if (!container) {
            if (attempts < 10) setTimeout(() => this.ensureContainerReady(attempts + 1), 100);
            return;
        }

        if (container.offsetWidth === 0 || container.offsetHeight === 0) {
            if (attempts > 30) {
                console.warn('[UnifiedEditor] Container 0-size timeout. Proceeding.');
                this.initEditor();
                return;
            }
            setTimeout(() => this.ensureContainerReady(attempts + 1), 50);
            return;
        }

        this.initEditor();
    }

    private initEditor() {
        if (this.univer || this.isDestroyed) return;

        const container = this.editorContainer.nativeElement;

        try {
            // 1. Core Instance
            const univer = new Univer({
                locale: LocaleType.EN_US,
                locales: { [LocaleType.EN_US]: Tools.deepMerge(DesignEnUS, UIEnUS, DocsEnUS, SheetsEnUS) }
            });

            // 2. Foundation (NO UI YET)
            univer.registerPlugin(UniverNetworkPlugin);
            univer.registerPlugin(UniverRenderEnginePlugin);
            univer.registerPlugin(UniverDrawingPlugin);
            univer.registerPlugin(UniverFormulaEnginePlugin);

            // 3. Mode Specific Logic (CRITICAL: SHEET NEEDS DOC PLUGINS FOR EDITORS)
            univer.registerPlugin(UniverDocsPlugin);
            if (this.mode === 'SHEET') {
                univer.registerPlugin(UniverSheetsPlugin);
                univer.registerPlugin(UniverSheetsFormulaPlugin);
            }

            // 4. Create Unit IMMEDIATELY after logic (Before UI)
            // This ensures internal dependencies for the unit are registered
            const unitType = this.mode === 'DOC' ? UniverInstanceType.UNIVER_DOC : UniverInstanceType.UNIVER_SHEET;
            const unit = univer.createUnit(unitType, this.initialData || this.getDefaultSnapshot());

            // 5. Register UI Plugins LAST (Attaches components to render unit)
            // If in preview mode, we use very minimal UI config
            const uiConfig = this.isPreview ? {
                container: container,
                header: false, footer: this.mode === 'SHEET', toolbar: false, contextMenu: false
            } : {
                container: container,
                header: true, footer: true, toolbar: true, contextMenu: true
            };

            univer.registerPlugin(UniverUIPlugin, uiConfig);
            univer.registerPlugin(UniverDocsUIPlugin);

            if (this.mode === 'SHEET') {
                univer.registerPlugin(UniverSheetsUIPlugin);
                univer.registerPlugin(UniverSheetsFormulaUIPlugin);
            }

            this.overrideImageUpload(univer);

            this.univer = univer;
            this.univerAPI = FUniver.newAPI(univer);

            if (this.readOnly && this.isPreview) {
                this.applyReadOnlyInteractionGuards(container);
            }

            this.isLoading = false;
            this.onReady.emit();

        } catch (error) {
            console.error('[UnifiedEditor] Init Failed:', error);
            this.isLoading = false;
        }
    }

    private getDefaultSnapshot() {
        if (this.mode === 'DOC') {
            return { id: 'doc-new', body: { dataStream: '\r\n', textRuns: [], paragraphs: [{ startIndex: 0 }], sectionBreaks: [{ startIndex: 1 }] } };
        }
        return {
            id: 'sheet-new',
            sheets: { 's1': { id: 's1', name: 'Sheet1', rowCount: 100, columnCount: 20, cellData: {} } },
            sheetOrder: ['s1']
        };
    }

    public async getData(): Promise<any> {
        if (!this.univer) return this.initialData;
        try {
            const type = this.mode === 'DOC' ? UniverInstanceType.UNIVER_DOC : UniverInstanceType.UNIVER_SHEET;
            const unit = this.univer.__getInjector().get(IUniverInstanceService).getCurrentUnitForType(type);
            return unit ? unit.getSnapshot() : this.initialData;
        } catch (e) {
            return this.initialData;
        }
    }

    private overrideImageUpload(univer: Univer) {
        const injector = univer.__getInjector();
        if (injector.has(IImageIoService)) return;

        const platformImageIoService = {
            saveImage: async (imageFile: File) => {
                const fd = new FormData();
                fd.append('image', imageFile);
                fd.append('paperId', this.paperId);
                try {
                    const res: any = await lastValueFrom(this.http.post('/api/papers/assets/upload', fd).pipe(defaultIfEmpty(null)));
                    if (res?.success) {
                        return { imageId: res.file.assetId, imageSourceType: ImageSourceType.URL, source: res.file.url, status: ImageUploadStatusType.SUCCUSS };
                    }
                } catch (e) { }
                return null;
            }
        };
        injector.add([IImageIoService, { useValue: platformImageIoService }]);
    }


    private applyReadOnlyInteractionGuards(container: HTMLElement) {
        this.removeReadOnlyInteractionGuards(container);

        this.readOnlyKeydownHandler = (event: KeyboardEvent) => {
            const key = event.key?.toLowerCase();
            const ctrlOrMeta = event.ctrlKey || event.metaKey;

            const allowCombination = ctrlOrMeta && (key === 'c' || key === 'a');
            const allowNavigation = [
                'arrowup', 'arrowdown', 'arrowleft', 'arrowright',
                'pageup', 'pagedown', 'home', 'end', 'tab', 'escape'
            ].includes(key);

            if (allowCombination || allowNavigation) {
                return;
            }

            const shouldBlock =
                key === 'enter' ||
                key === 'backspace' ||
                key === 'delete' ||
                key === ' ' ||
                key.length === 1 ||
                (ctrlOrMeta && (key === 'v' || key === 'x' || key === 'z' || key === 'y' || key === 'b' || key === 'i' || key === 'u'));

            if (shouldBlock) {
                event.preventDefault();
                event.stopPropagation();
            }
        };

        this.readOnlyPasteHandler = (event: ClipboardEvent) => {
            event.preventDefault();
            event.stopPropagation();
        };

        this.readOnlyCutHandler = (event: ClipboardEvent) => {
            event.preventDefault();
            event.stopPropagation();
        };

        container.addEventListener('keydown', this.readOnlyKeydownHandler, true);
        container.addEventListener('paste', this.readOnlyPasteHandler, true);
        container.addEventListener('cut', this.readOnlyCutHandler, true);
    }

    private removeReadOnlyInteractionGuards(container: HTMLElement | null) {
        if (!container) return;
        if (this.readOnlyKeydownHandler) {
            container.removeEventListener('keydown', this.readOnlyKeydownHandler, true);
            this.readOnlyKeydownHandler = null;
        }
        if (this.readOnlyPasteHandler) {
            container.removeEventListener('paste', this.readOnlyPasteHandler, true);
            this.readOnlyPasteHandler = null;
        }
        if (this.readOnlyCutHandler) {
            container.removeEventListener('cut', this.readOnlyCutHandler, true);
            this.readOnlyCutHandler = null;
        }
    }

    private disposeUniver() {
        this.removeReadOnlyInteractionGuards(this.editorContainer?.nativeElement ?? null);

        if (this.univer) {
            try {
                this.univer.dispose();
            } catch (e) {
                console.warn('[UnifiedEditor] Dispose error:', e);
            }
            this.univer = null;
        }
    }

    ngOnDestroy(): void {
        this.isDestroyed = true;
        this.disposeUniver();
    }
}
