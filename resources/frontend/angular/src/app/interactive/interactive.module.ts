import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { InteractiveRoutingModule } from './interactive-routing.module';
import { InteractiveListComponent } from './interactive-list/interactive-list.component';
import { SharedModule } from '@shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MaterialModule } from '@shared/material.module';

@NgModule({
    import { InteractiveEditorComponent } from './interactive-editor/interactive-editor.component';

@NgModule({
        declarations: [
            InteractiveListComponent,
            InteractiveEditorComponent
        ],
        imports: [
            CommonModule,
            InteractiveRoutingModule,
            SharedModule,
            MaterialModule,
            FormsModule,
            ReactiveFormsModule
        ]
    })
    export class InteractiveModule { }
