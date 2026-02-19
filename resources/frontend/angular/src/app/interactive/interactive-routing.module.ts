import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { InteractiveListComponent } from './interactive-list/interactive-list.component';
import { InteractiveEditorComponent } from './interactive-editor/interactive-editor.component';
import { AuthGuard } from '@core/security/auth.guard';

const routes: Routes = [
    {
        path: 'create',
        component: InteractiveEditorComponent,
        canActivate: [AuthGuard],
        data: { claimType: 'MANAGE_INTERACTIVE_CONTENT' }
    },
    {
        path: 'edit/:id',
        component: InteractiveEditorComponent,
        canActivate: [AuthGuard],
        data: { claimType: 'MANAGE_INTERACTIVE_CONTENT' }
    },
    {
        path: '',
        component: InteractiveListComponent,
        canActivate: [AuthGuard],
        data: { claimType: 'MANAGE_INTERACTIVE_CONTENT' }
    },
    {
        path: 'content',
        redirectTo: '',
        pathMatch: 'full'
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class InteractiveRoutingModule { }
