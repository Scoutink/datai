import { HttpClient, HttpParams, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

export interface PaperListItem {
  id: string;
  name: string;
  description?: string;
  categoryName?: string;
  createdByName?: string;
  createdDate?: string;
  statusName?: string;
}

@Injectable({ providedIn: 'root' })
export class PapersService {
  constructor(private httpClient: HttpClient) {}

  getPapers(skip = 0, pageSize = 20, searchQuery = ''): Observable<HttpResponse<PaperListItem[]>> {
    const params = new HttpParams()
      .set('skip', skip)
      .set('pageSize', pageSize)
      .set('orderBy', 'papers.createdDate desc')
      .set('searchQuery', searchQuery);

    return this.httpClient.get<PaperListItem[]>('papers', { params, observe: 'response' });
  }

  getAssignedPapers(skip = 0, pageSize = 20, searchQuery = ''): Observable<HttpResponse<PaperListItem[]>> {
    const params = new HttpParams()
      .set('skip', skip)
      .set('pageSize', pageSize)
      .set('orderBy', 'papers.createdDate desc')
      .set('searchQuery', searchQuery);

    return this.httpClient.get<PaperListItem[]>('paper/assignedPapers', { params, observe: 'response' });
  }

  createPaper(payload: {
    name: string;
    description?: string;
    categoryId: string;
    clientId?: string;
    statusId?: string;
    contentJson: string;
    contentHtmlSanitized: string;
  }): Observable<PaperListItem> {
    return this.httpClient.post<PaperListItem>('paper', payload);
  }
}
