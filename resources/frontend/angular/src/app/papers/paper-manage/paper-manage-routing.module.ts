import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PaperManageComponent } from './paper-manage.component';

const routes: Routes = [
    {
        path: '',
        component: PaperManageComponent
    }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class PaperManageRoutingModule { }
