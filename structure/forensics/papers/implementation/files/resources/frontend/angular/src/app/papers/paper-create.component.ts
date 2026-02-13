import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { PapersService } from './papers.service';

@Component({
  selector: 'app-paper-create',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink, TranslateModule],
  templateUrl: './paper-create.component.html'
})
export class PaperCreateComponent {
  model = {
    name: '',
    description: '',
    categoryId: '',
    contentHtmlSanitized: '<p></p>'
  };

  loading = false;
  error = '';

  constructor(private papersService: PapersService, private router: Router) {}

  save(): void {
    this.error = '';
    if (!this.model.name || !this.model.categoryId) {
      this.error = 'Name and Category ID are required.';
      return;
    }

    this.loading = true;
    const payload = {
      name: this.model.name,
      description: this.model.description,
      categoryId: this.model.categoryId,
      contentHtmlSanitized: this.model.contentHtmlSanitized,
      contentJson: JSON.stringify({ blocks: [] })
    };

    this.papersService.createPaper(payload).subscribe({
      next: () => {
        this.loading = false;
        this.router.navigate(['/papers']);
      },
      error: () => {
        this.loading = false;
        this.error = 'Failed to create paper. Please verify required fields and permissions.';
      }
    });
  }
}
