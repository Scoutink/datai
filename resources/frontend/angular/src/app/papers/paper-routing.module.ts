import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PaperListComponent } from './paper-list/paper-list.component';
import { AuthGuard } from '@core/security/auth.guard';
import { PaperDetailComponent } from './paper-details/paper-detail.component';
import { paperDetailsResolver } from './paper-details.resolver';

const routes: Routes = [
    {
        path: '',
        component: PaperListComponent,
        data: { claimType: 'ALL_PAPERS_VIEW_PAPERS', isAssigned: false },
        canActivate: [AuthGuard],
    },
    {
        path: 'assigned',
        component: PaperListComponent,
        data: { claimType: 'ALL_PAPERS_VIEW_PAPERS', isAssigned: true },
        canActivate: [AuthGuard],
    },
    {
        path: 'manage',
        loadChildren: () => import('./paper-manage/paper-manage.module').then(m => m.PaperManageModule)
    },
    {
        path: 'manage/:id',
        loadChildren: () => import('./paper-manage/paper-manage.module').then(m => m.PaperManageModule)
    },
    {
        path: ':id',
        component: PaperDetailComponent,
        data: { claimType: 'ALL_PAPERS_VIEW_PAPERS' },
        canActivate: [AuthGuard],
        resolve: { paper: paperDetailsResolver }
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class PaperRoutingModule { }
