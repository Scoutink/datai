import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PaperRoutingModule } from './paper-routing.module';
import { PaperListComponent } from './paper-list/paper-list.component';
import { PaperDetailComponent } from './paper-details/paper-detail.component';
import { SharedModule } from '@shared/shared.module';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatSortModule } from '@angular/material/sort';
import { MatMenuModule } from '@angular/material/menu';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';
import { MatDividerModule } from '@angular/material/divider';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { TranslateModule } from '@ngx-translate/core';

@NgModule({
    declarations: [
        PaperListComponent
    ],
    imports: [
        CommonModule,
        PaperRoutingModule,
        SharedModule,
        MatTableModule,
        MatPaginatorModule,
        MatSortModule,
        MatMenuModule,
        MatIconModule,
        MatButtonModule,
        MatInputModule,
        MatFormFieldModule,
        MatSelectModule,
        MatDividerModule,
        MatProgressSpinnerModule,
        ReactiveFormsModule,
        FormsModule,
        TranslateModule
    ]
})
export class PaperModule { }
