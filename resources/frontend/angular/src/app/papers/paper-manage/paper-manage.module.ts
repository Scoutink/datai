import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PaperManageRoutingModule } from './paper-manage-routing.module';
import { PaperManageComponent } from './paper-manage.component';
import { PaperEditorComponent } from '../paper-editor/paper-editor.component';
import { SharedModule } from '@shared/shared.module';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatSelectModule } from '@angular/material/select';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { NgSelectModule } from '@ng-select/ng-select';
import { TranslateModule } from '@ngx-translate/core';

@NgModule({
    declarations: [
        PaperManageComponent
    ],
    imports: [
        CommonModule,
        PaperManageRoutingModule,
        SharedModule,
        ReactiveFormsModule,
        FormsModule,
        MatButtonModule,
        MatIconModule,
        MatSelectModule,
        MatFormFieldModule,
        MatInputModule,
        NgSelectModule,
        TranslateModule,
        PaperEditorComponent
    ]
})
export class PaperManageModule { }
