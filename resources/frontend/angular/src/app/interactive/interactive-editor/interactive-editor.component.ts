import { Component, OnInit, ElementRef, ViewChild, ViewEncapsulation } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { InteractiveService } from '../interactive.service';
import { ToastrService } from 'ngx-toastr';

declare var H5P: any;
declare var H5PEditor: any;
declare var H5PIntegration: any;

@Component({
    selector: 'app-interactive-editor',
    templateUrl: './interactive-editor.component.html',
    styleUrls: ['./interactive-editor.component.css'],
    encapsulation: ViewEncapsulation.None // Important for H5P styles
})
export class InteractiveEditorComponent implements OnInit {
    loading = true;
    settings: any;
    title: string = '';

    constructor(
        private interactiveService: InteractiveService,
        private route: ActivatedRoute,
        private router: Router,
        private toastr: ToastrService
    ) { }

    ngOnInit(): void {
        this.interactiveService.getEditorSettings().subscribe({
            next: (settings) => {
                this.settings = settings;
                this.initializeH5P(settings);
            },
            error: (err) => {
                this.loading = false;
                this.toastr.error('Failed to load editor settings.');
                console.error(err);
            }
        });
    }

    initializeH5P(settings: any) {
        // 1. Set global H5PIntegration variable
        (window as any).H5PIntegration = settings;

        // 2. Load Assets dynamically
        this.loadAssets(settings.core.scripts, settings.core.styles, settings.editor.assets.js, settings.editor.assets.css)
            .then(() => {
                this.loading = false;
                // 3. Initialize Editor
                const $ = (window as any).H5P.jQuery;
                const $form = $('#h5p-editor-form');

                // H5PEditor.init uses the form to find the container
                // It expects an element with class .h5p-editor
                // And it often attaches to a form submit or similar.

                // We manually trigger initiation.
                // H5PEditor.getAjaxUrl = (action, params) => ...
                // We might need to override getAjaxUrl if the settings don't stick.

                new H5PEditor.Editor(undefined, undefined, $form.find('.h5p-editor'));
            });
    }

    loadAssets(coreScripts: string[], coreStyles: string[], editorScripts: string[], editorStyles: string[]): Promise<void> {
        const scripts = [...coreScripts, ...editorScripts];
        const styles = [...coreStyles, ...editorStyles];

        const loadScript = (src: string) => {
            return new Promise<void>((resolve, reject) => {
                if (document.querySelector(`script[src="${src}"]`)) {
                    resolve();
                    return;
                }
                const script = document.createElement('script');
                script.src = src;
                script.onload = () => resolve();
                script.onerror = () => reject();
                document.body.appendChild(script);
            });
        };

        const loadStyle = (href: string) => {
            if (document.querySelector(`link[href="${href}"]`)) return;
            const link = document.createElement('link');
            link.rel = 'stylesheet';
            link.href = href;
            document.head.appendChild(link);
        };

        styles.forEach(s => loadStyle(s));

        // Scripts must be loaded sequentially for dependencies
        return scripts.reduce((promise, src) => {
            return promise.then(() => loadScript(src));
        }, Promise.resolve());
    }

    save() {
        const $ = (window as any).H5P.jQuery;
        // H5PEditor.getLibraryData returns the library string
        // We need to extract the parameters.
        // Use H5PEditor.getInstance().getParams()

        // The editor usually binds to a form. 
        // We can manually harvest the data.

        const h5pEditor = (window as any).H5PEditor.Html;
        // There isn't a global single instance easily accessible unless we kept the reference.
        // Often we can trigger a form submit or use getParams on the window instance if it exposed it.

        // Looking at h5peditor-editor.js:
        // It finds the 'h5p-editor' class.

        // Simplest way: The Editor library populates the hidden fields in the form on submit/save.
        // If we passed the $form to the constructor, calling .submit() might trigger extraction.

        // Let's implement a manual gather.
        // Actually, `H5PEditor.getInstance()` might work if it's singleton-ish, but usually it registers itself.

        // We can try to access the editor instance attached to the DOM element.
        const editor = (window as any).H5PEditor.instances[0]; // Assuming one editor per page
        if (!editor) {
            this.toastr.error("Editor instance not found");
            return;
        }

        const params = editor.getParams();
        const library = editor.getLibrary();

        if (!params || !library) {
            this.toastr.warning("Please select content type.");
            return;
        }

        const payload = {
            title: this.title || 'Untitled',
            library: library,
            params: JSON.stringify(params)
        };

        this.interactiveService.saveContent(payload).subscribe({
            next: (res) => {
                this.toastr.success("Saved successfully!");
                this.router.navigate(['/interactive']);
            },
            error: (err) => this.toastr.error("Failed to save.")
        });
    }
}
