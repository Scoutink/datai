import { Component, OnInit, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { merge, Subject } from 'rxjs';
import { tap, debounceTime, distinctUntilChanged } from 'rxjs/operators';
import { InteractiveService } from '../interactive.service';
import { InteractiveDataSource } from '../interactive.datasource';

@Component({
    selector: 'app-interactive-list',
    templateUrl: './interactive-list.component.html',
    styleUrls: ['./interactive-list.component.scss']
})
export class InteractiveListComponent implements OnInit {
    displayedColumns: string[] = ['title', 'library', 'author', 'created_at', 'actions'];
    dataSource: InteractiveDataSource;

    @ViewChild(MatPaginator) paginator: MatPaginator;
    @ViewChild(MatSort) sort: MatSort;

    searchString: string = '';
    private searchSubject = new Subject<string>();

    constructor(private interactiveService: InteractiveService) { }

    ngOnInit(): void {
        this.dataSource = new InteractiveDataSource(this.interactiveService);
        this.dataSource.loadContent();

        this.searchSubject.pipe(
            debounceTime(300),
            distinctUntilChanged()
        ).subscribe(searchText => {
            this.dataSource.loadContent(searchText);
        });
    }

    ngAfterViewInit() {
        this.sort.sortChange.subscribe(() => this.paginator.pageIndex = 0);

        merge(this.sort.sortChange, this.paginator.page)
            .pipe(
                tap(() => this.loadContentPage())
            )
            .subscribe();
    }

    loadContentPage() {
        this.dataSource.loadContent(
            this.searchString,
            this.sort.active,
            this.sort.direction,
            this.paginator.pageIndex,
            this.paginator.pageSize
        );
    }

    onSearch(searchValue: string) {
        this.searchString = searchValue;
        this.searchSubject.next(searchValue);
    }

    deleteContent(id: number) {
        // TODO: Implement delete confirmation and call
    }
}
