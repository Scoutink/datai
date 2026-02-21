import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map, Observable } from 'rxjs';

interface LicenseStatusResponse {
  isLicensed: boolean;
}

@Injectable({ providedIn: 'root' })
export class LicenseStatusService {
  constructor(private http: HttpClient) {}

  isLicensed(): Observable<boolean> {
    return this.http
      .get<LicenseStatusResponse>('license/status')
      .pipe(map((response) => Boolean(response?.isLicensed)));
  }
}
