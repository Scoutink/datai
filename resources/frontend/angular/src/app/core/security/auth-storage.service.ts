import { Injectable } from '@angular/core';
import { JwtHelperService } from '@auth0/angular-jwt';
import { AuthToken, UserAuth } from '../domain-classes/user-auth';
import { User } from '@core/domain-classes/user';

@Injectable({ providedIn: 'root' })
export class AuthStorageService {
  private readonly authObjKey = 'authObj';
  private readonly bearerTokenKey = 'bearerToken';

  constructor(private jwtHelperService: JwtHelperService) {}

  setTokenUserValue(entity: UserAuth): void {
    if (entity?.authorisation?.token) {
      localStorage.setItem(this.bearerTokenKey, entity.authorisation.token);
    }

    if (entity?.user) {
      localStorage.setItem(this.authObjKey, JSON.stringify(entity.user));
    }
  }

  getJWtToken(): AuthToken | null {
    const token = this.getBearerToken();
    if (!token) {
      return null;
    }

    return this.jwtHelperService.decodeToken(token);
  }

  getAuthObject(): User | null {
    const value = localStorage.getItem(this.authObjKey);
    if (!value || value === 'undefined' || value === 'null') {
      return null;
    }

    return JSON.parse(value) as User;
  }

  getBearerToken(): string {
    const token = localStorage.getItem(this.bearerTokenKey);
    if (!token || token === 'undefined' || token === 'null') {
      return '';
    }

    return token;
  }

  removeToken(): void {
    localStorage.removeItem(this.authObjKey);
    localStorage.removeItem(this.bearerTokenKey);
  }
}
