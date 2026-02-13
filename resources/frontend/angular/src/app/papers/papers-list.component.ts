import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { HasClaimDirective } from '../shared/has-claim.directive';
import { PaperListItem, PapersService } from './papers.service';

@Component({
  selector: 'app-papers-list',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink, TranslateModule, HasClaimDirective],
  templateUrl: './papers-list.component.html'
})
export class PapersListComponent implements OnInit {
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
    this.papersService.getPapers(0, 50, this.searchQuery).subscribe({
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
