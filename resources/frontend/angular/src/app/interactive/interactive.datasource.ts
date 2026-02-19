import { CollectionViewer, DataSource } from '@angular/cdk/collections';
import { Observable, BehaviorSubject, of } from 'rxjs';
import { catchError, finalize } from 'rxjs/operators';
import { InteractiveService } from './interactive.service';

export class InteractiveDataSource implements DataSource<any> {
    private contentSubject = new BehaviorSubject<any[]>([]);
    private loadingSubject = new BehaviorSubject<boolean>(false);
    private totalCountSubject = new BehaviorSubject<number>(0);

    public loading$ = this.loadingSubject.asObservable();
    public totalCount$ = this.totalCountSubject.asObservable();

    constructor(private interactiveService: InteractiveService) { }

    connect(collectionViewer: CollectionViewer): Observable<any[]> {
        return this.contentSubject.asObservable();
    }

    disconnect(collectionViewer: CollectionViewer): void {
        this.contentSubject.complete();
        this.loadingSubject.complete();
        this.totalCountSubject.complete();
    }

    loadContent(
        searchInfo: string = '',
        sortColumn: string = 'id',
        sortOrder: string = 'desc',
        pageIndex: number = 0,
        pageSize: number = 10
    ) {
        this.loadingSubject.next(true);

        this.interactiveService.getContent(
            searchInfo,
            sortColumn,
            sortOrder,
            pageIndex + 1, // Laravel Paginate is 1-indexed
            pageSize
        ).pipe(
            catchError(() => of({ data: [], total: 0 })),
            finalize(() => this.loadingSubject.next(false))
        ).subscribe(response => {
            this.contentSubject.next(response.data);
            this.totalCountSubject.next(response.total);
        });
    }
}
