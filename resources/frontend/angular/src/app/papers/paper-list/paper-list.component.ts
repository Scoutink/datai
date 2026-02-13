import { AfterViewInit, Component, ElementRef, OnInit, ViewChild, inject } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { FormControl } from '@angular/forms';
import { SelectionModel } from '@angular/cdk/collections';
import { Direction } from '@angular/cdk/bidi';
import { fromEvent, merge } from 'rxjs';
import { debounceTime, distinctUntilChanged, tap } from 'rxjs/operators';
import { BaseComponent } from 'src/app/base.component';
import { PaperDataSource } from './paper-datasource';
import { PaperResource } from '@core/domain-classes/paper-resource';
import { PaperService } from '../paper.service';
import { TranslationService } from '@core/services/translation.service';
import { ToastrService } from 'ngx-toastr';
import { CategoryStore } from 'src/app/category/store/category-store';
import { ClientStore } from 'src/app/client/client-store';
import { DocumentStatusStore } from 'src/app/document-status/store/document-status.store';
import { CommonDialogService } from '@core/common-dialog/common-dialog.service';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
    selector: 'app-paper-list',
    templateUrl: './paper-list.component.html',
    styleUrls: ['./paper-list.component.scss']
})
export class PaperListComponent extends BaseComponent implements OnInit, AfterViewInit {
    dataSource: PaperDataSource;
    displayedColumns: string[] = [
        'action',
        'name',
        'categoryName',
        'createdDate',
        'companyName',
        'statusName',
        'createdBy'
    ];
    paperResource: PaperResource;
    selection = new SelectionModel<any>(true, []);
    direction: Direction;
    isAssigned: boolean = false;

    @ViewChild(MatPaginator) paginator: MatPaginator;
    @ViewChild(MatSort) sort: MatSort;
    @ViewChild('input') input: ElementRef;

    public categoryStore = inject(CategoryStore);
    public clientStore = inject(ClientStore);
    public documentStatusStore = inject(DocumentStatusStore);

    constructor(
        private paperService: PaperService,
        private translationService: TranslationService,
        private toastrService: ToastrService,
        private dialog: MatDialog,
        private commonDialogService: CommonDialogService,
        private router: Router,
        private route: ActivatedRoute
    ) {
        super();
        this.paperResource = new PaperResource();
        this.paperResource.pageSize = 10;
        this.paperResource.orderBy = 'createdDate desc';
    }

    ngOnInit(): void {
        this.isAssigned = this.route.snapshot.data['isAssigned'] || false;
        this.dataSource = new PaperDataSource(this.paperService);
        this.loadData();
        this.sub$.sink = this.translationService.lanDir$.subscribe(
            (c: Direction) => (this.direction = c)
        );
    }

    ngAfterViewInit() {
        this.sort.sortChange.subscribe(() => (this.paginator.pageIndex = 0));

        this.sub$.sink = merge(this.sort.sortChange, this.paginator.page)
            .pipe(
                tap(() => {
                    this.paperResource.skip = this.paginator.pageIndex * this.paginator.pageSize;
                    this.paperResource.pageSize = this.paginator.pageSize;
                    this.paperResource.orderBy = this.sort.active + ' ' + this.sort.direction;
                    this.loadData();
                })
            )
            .subscribe();

        this.sub$.sink = fromEvent(this.input.nativeElement, 'keyup')
            .pipe(
                debounceTime(1000),
                distinctUntilChanged(),
                tap(() => {
                    this.paginator.pageIndex = 0;
                    this.paperResource.skip = 0;
                    this.paperResource.name = this.input.nativeElement.value;
                    this.loadData();
                })
            )
            .subscribe();
    }

    loadData() {
        if (this.isAssigned) {
            this.dataSource.loadAssignedPapers(this.paperResource);
        } else {
            this.dataSource.loadPapers(this.paperResource);
        }
    }

    onCategoryChange(filterValue: any) {
        this.paperResource.categoryId = filterValue === '0' ? '' : filterValue;
        this.paginator.pageIndex = 0;
        this.paperResource.skip = 0;
        this.loadData();
    }

    onClientChange(filterValue: any) {
        this.paperResource.clientId = filterValue === '0' ? '' : filterValue;
        this.paginator.pageIndex = 0;
        this.paperResource.skip = 0;
        this.loadData();
    }

    onStatusChange(filterValue: any) {
        this.paperResource.statusId = filterValue === '0' ? '' : filterValue;
        this.paginator.pageIndex = 0;
        this.paperResource.skip = 0;
        this.loadData();
    }

    onComment(paper: any) {
        this.router.navigate(['/papers', paper.id], { queryParams: { tab: 'comment' } });
    }

    addPaper() {
        this.router.navigate(['/papers/manage']);
    }

    editPaper(paper: any) {
        this.router.navigate(['/papers/manage', paper.id]);
    }

    viewPaper(paper: any) {
        this.router.navigate(['/papers', paper.id]);
    }

    deletePaper(paper: any) {
        this.sub$.sink = this.commonDialogService
            .deleteConformationDialog(`Are you sure you want to delete ${paper.name}?`)
            .subscribe((isTrue: boolean) => {
                if (isTrue) {
                    this.sub$.sink = this.paperService.deletePaper(paper.id).subscribe(() => {
                        this.toastrService.success('Paper deleted successfully');
                        this.loadData();
                    });
                }
            });
    }

    onShareLink(paper: any) {
        // TODO: Open Share dialog
    }

    onPermission(paper: any) {
        // TODO: Open Permission dialog
    }

    onVersionHistory(paper: any) {
        // TODO: Open Version History dialog
    }

    onAuditTrail(paper: any) {
        // TODO: Open Audit Trail dialog
    }
}
