import { DataSource } from '@angular/cdk/collections';
import { HttpResponse } from '@angular/common/http';
import { PaperResource } from '@core/domain-classes/paper-resource';
import { BehaviorSubject, Observable, of } from 'rxjs';
import { catchError, finalize } from 'rxjs/operators';
import { PaperService } from '../paper.service';

export class PaperDataSource implements DataSource<any> {
    private paperSubject = new BehaviorSubject<any[]>([]);
    private responseHeaderSubject = new BehaviorSubject<any>(null);
    private loadingSubject = new BehaviorSubject<boolean>(false);

    public loading$ = this.loadingSubject.asObservable();
    public responseHeader$ = this.responseHeaderSubject.asObservable();

    constructor(private paperService: PaperService) { }

    connect(): Observable<any[]> {
        return this.paperSubject.asObservable();
    }

    disconnect(): void {
        this.paperSubject.complete();
        this.loadingSubject.complete();
        this.responseHeaderSubject.complete();
    }

    loadPapers(resource: PaperResource) {
        this.loadingSubject.next(true);
        this.paperService
            .getPapers(resource)
            .pipe(
                catchError(() => of([])),
                finalize(() => this.loadingSubject.next(false))
            )
            .subscribe((resp: HttpResponse<any[]>) => {
                if (resp && resp.headers) {
                    const paginationHeader = {
                        totalCount: resp.headers.get('totalCount'),
                        pageSize: resp.headers.get('pageSize'),
                        skip: resp.headers.get('skip'),
                    };
                    this.responseHeaderSubject.next(paginationHeader);
                    this.paperSubject.next(resp.body);
                }
            });
    }

    loadAssignedPapers(resource: PaperResource) {
        this.loadingSubject.next(true);
        this.paperService
            .getAssignedPapers(resource)
            .pipe(
                catchError(() => of([])),
                finalize(() => this.loadingSubject.next(false))
            )
            .subscribe((resp: HttpResponse<any[]>) => {
                if (resp && resp.headers) {
                    const paginationHeader = {
                        totalCount: resp.headers.get('totalCount'),
                        pageSize: resp.headers.get('pageSize'),
                        skip: resp.headers.get('skip'),
                    };
                    this.responseHeaderSubject.next(paginationHeader);
                    this.paperSubject.next(resp.body);
                }
            });
    }
}
