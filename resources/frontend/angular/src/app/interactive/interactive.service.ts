import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
    providedIn: 'root'
})
export class InteractiveService {
    private apiUrl = 'interactive';

    constructor(private http: HttpClient) { }

    getContent(
        searchInfo: string,
        sortColumn: string,
        sortOrder: string,
        pageIndex: number,
        pageSize: number
    ): Observable<any> {
        let params = new HttpParams()
            .set('search', searchInfo)
            .set('sortColumn', sortColumn)
            .set('sortOrder', sortOrder)
            .set('pageIndex', pageIndex.toString())
            .set('pageSize', pageSize.toString());

        return this.http.get<any>(`${this.apiUrl}/content`, { params });
    }

    getLibraries(): Observable<any[]> {
        return this.http.get<any[]>(`${this.apiUrl}/libraries`);
    }

    getEditorSettings(id?: number): Observable<any> {
        const url = id ? `${this.apiUrl}/editor/settings/${id}` : `${this.apiUrl}/editor/settings`;
        return this.http.get<any>(url);
    }

    saveContent(data: any): Observable<any> {
        return this.http.post<any>(`${this.apiUrl}/editor/store`, data);
    }

    deleteContent(id: number): Observable<any> {
        return this.http.delete(`${this.apiUrl}/content/${id}`);
    }
}
