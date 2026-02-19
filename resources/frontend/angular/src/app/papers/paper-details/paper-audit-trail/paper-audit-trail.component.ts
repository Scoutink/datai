import { AfterViewInit, Component, inject, Input, OnChanges, OnInit, SimpleChanges, ViewChild } from '@angular/core';
import { MatPaginator, MatPaginatorModule } from '@angular/material/paginator';
import { MatSort, MatSortModule } from '@angular/material/sort';
import { MatTableDataSource, MatTableModule } from '@angular/material/table';
import { TranslateModule } from '@ngx-translate/core';
import { PipesModule } from '@shared/pipes/pipes.module';
import { NgIf, CommonModule } from '@angular/common';
import { BaseComponent } from 'src/app/base.component';
import { PaperService } from '../../paper.service';

@Component({
    selector: 'app-paper-audit-trail',
    standalone: true,
    imports: [
        CommonModule,
        TranslateModule,
        PipesModule,
        MatTableModule,
        MatPaginatorModule,
        MatSortModule
    ],
    templateUrl: './paper-audit-trail.component.html',
    styleUrls: ['./paper-audit-trail.component.scss']
})
export class PaperAuditTrailComponent extends BaseComponent implements OnChanges, OnInit {
    @Input() paperId: string = '';
    @Input() shouldLoad = false;

    dataSource = new MatTableDataSource<any>();
    displayedColumns: string[] = [
        'createdDate',
        'operationName',
        'createdBy',
        'permissionUser',
        'permissionRole',
    ];

    @ViewChild(MatPaginator) paginator: MatPaginator;
    @ViewChild(MatSort) sort: MatSort;

    private paperService = inject(PaperService);

    ngOnInit(): void {
        // Initial load will happen in ngOnChanges if shouldLoad is true
    }

    ngOnChanges(changes: SimpleChanges): void {
        if (changes['shouldLoad'] && this.shouldLoad && this.paperId) {
            this.getAuditTrails();
        }
    }

    getAuditTrails() {
        this.paperService.getAuditTrails(this.paperId).subscribe((data: any[]) => {
            this.dataSource.data = data;
            this.dataSource.paginator = this.paginator;
            this.dataSource.sort = this.sort;
        });
    }
}
