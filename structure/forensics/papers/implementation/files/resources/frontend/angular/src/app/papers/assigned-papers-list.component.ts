import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { TranslateModule } from '@ngx-translate/core';
import { PaperListItem, PapersService } from './papers.service';

@Component({
  selector: 'app-assigned-papers-list',
  standalone: true,
  imports: [CommonModule, FormsModule, TranslateModule],
  templateUrl: './assigned-papers-list.component.html'
})
export class AssignedPapersListComponent implements OnInit {
  papers: PaperListItem[] = [];
  searchQuery = '';
  totalCount = 0;
  loading = false;

  constructor(private papersService: PapersService) {}

  ngOnInit(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.papersService.getAssignedPapers(0, 50, this.searchQuery).subscribe({
      next: (res) => {
        this.papers = res.body ?? [];
        this.totalCount = Number(res.headers.get('totalCount') ?? this.papers.length);
        this.loading = false;
      },
      error: () => {
        this.loading = false;
      }
    });
  }
}
