import { ActivatedRouteSnapshot, ResolveFn, Router } from '@angular/router';
import { inject } from '@angular/core';
import { Observable } from 'rxjs';
import { PaperService } from './paper.service';

export const paperDetailsResolver: ResolveFn<any> = (route: ActivatedRouteSnapshot) => {
    const paperService = inject(PaperService);
    const router = inject(Router);
    const id = route.params['id'];
    if (id != null) {
        return paperService.getPaper(id) as Observable<any>;
    } else {
        router.navigate(['/papers']);
        return null;
    }
};
