import { HttpClient, HttpParams, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { CommonHttpErrorService } from '@core/error-handler/common-http-error.service';
import { Observable } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { CommonError } from '@core/error-handler/common-error';

@Injectable({
  providedIn: 'root',
})
export class PaperService {
  constructor(
    private httpClient: HttpClient,
    private commonHttpErrorService: CommonHttpErrorService
  ) { }

  getPapers(resource: any): Observable<HttpResponse<any[]> | CommonError> {
    const url = `papers`;
    let params = new HttpParams()
      .set('pageSize', resource.pageSize.toString())
      .set('skip', resource.skip.toString())
      .set('orderBy', resource.orderBy || 'createdDate desc');

    if (resource.categoryId) params = params.set('categoryId', resource.categoryId);
    if (resource.name) params = params.set('name', resource.name);
    if (resource.clientId) params = params.set('clientId', resource.clientId);
    if (resource.statusId) params = params.set('statusId', resource.statusId);
    if (resource.metaTags) params = params.set('metaTags', resource.metaTags);

    return this.httpClient
      .get<any[]>(url, { params, observe: 'response' })
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getAssignedPapers(resource: any): Observable<HttpResponse<any[]> | CommonError> {
    const url = `papers/assigned`;
    let params = new HttpParams()
      .set('pageSize', resource.pageSize.toString())
      .set('skip', resource.skip.toString());

    if (resource.categoryId) params = params.set('categoryId', resource.categoryId);
    if (resource.name) params = params.set('name', resource.name);

    return this.httpClient
      .get<any[]>(url, { params, observe: 'response' })
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getPaper(id: string): Observable<any | CommonError> {
    return this.httpClient
      .get<any>(`papers/${id}`)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  addPaper(paper: any): Observable<any | CommonError> {
    return this.httpClient
      .post<any>(`papers`, paper)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  updatePaper(id: string, paper: any): Observable<any | CommonError> {
    return this.httpClient
      .put<any>(`papers/${id}`, paper)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  deletePaper(id: string): Observable<any | CommonError> {
    return this.httpClient
      .delete<any>(`papers/${id}`)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  // Permissions
  getPermissions(paperId: string): Observable<any | CommonError> {
    return this.httpClient
      .get<any>(`papers/${paperId}/permissions`)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  addRolePermission(permission: any): Observable<any | CommonError> {
    return this.httpClient
      .post<any>(`papers/permissions/role`, permission)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  addUserPermission(permission: any): Observable<any | CommonError> {
    return this.httpClient
      .post<any>(`papers/permissions/user`, permission)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  deleteRolePermission(id: string): Observable<any | CommonError> {
    return this.httpClient
      .delete<any>(`papers/permissions/role/${id}`)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  deleteUserPermission(id: string): Observable<any | CommonError> {
    return this.httpClient
      .delete<any>(`papers/permissions/user/${id}`)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  // History / Versions
  getVersions(paperId: string): Observable<any[] | CommonError> {
    return this.httpClient
      .get<any[]>(`papers/${paperId}/versions`)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  restoreVersion(versionId: string): Observable<any | CommonError> {
    return this.httpClient
      .post<any>(`papers/versions/${versionId}/restore`, {})
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  // Comments
  getComments(paperId: string): Observable<any[] | CommonError> {
    return this.httpClient
      .get<any[]>(`papers/${paperId}/comments`)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  addComment(comment: any): Observable<any | CommonError> {
    return this.httpClient
      .post<any>(`papers/comments`, comment)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  deleteComment(id: string): Observable<any | CommonError> {
    return this.httpClient
      .delete<any>(`papers/comments/${id}`)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  // Audit
  getAuditTrails(paperId: string): Observable<any[] | CommonError> {
    return this.httpClient
      .get<any[]>(`papers/${paperId}/audit`)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  // Share Link
  getShareLink(paperId: string): Observable<any | CommonError> {
    return this.httpClient
      .get<any>(`papers/${paperId}/share-link`)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  saveShareLink(link: any): Observable<any | CommonError> {
    return this.httpClient
      .post<any>(`papers/share-link`, link)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  deleteShareLink(id: string): Observable<any | CommonError> {
    return this.httpClient
      .delete<any>(`papers/share-link/${id}`)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }
}
