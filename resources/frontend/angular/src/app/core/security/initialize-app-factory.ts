import { SecurityService } from './security.service';
import { LicenseInitializerService } from '@mlglobtech/license-validator-docphp';
import { ToastrService } from 'ngx-toastr';
import { environment } from '@environments/environment';
import { firstValueFrom } from 'rxjs';
import { LicenseStatusService } from './license-status.service';

export function initializeApp(licenseService: LicenseInitializerService, toastrService: ToastrService, securityService: SecurityService, licenseStatusService: LicenseStatusService): () => Promise<void> {
  return () => new Promise<void>(async (resolve, reject) => {
    if (!environment.production && environment.licenseBypassForDevelopment) {
      console.warn('License validation is bypassed in development mode.');
      return resolve();
    }

    try {
      const isLocallyLicensed = await firstValueFrom(licenseStatusService.isLicensed());
      if (isLocallyLicensed) {
        return resolve();
      }
    } catch (error) {
      console.warn('Unable to confirm local license status, falling back to legacy initializer.', error);
    }

    return licenseService.initialize().then((result) => {
      if (result == "success") {
        return resolve();
      }
      if (result == "tokenremoved") {
        securityService.resetSecurityObject();
        setTimeout(() => {
          toastrService.success("License key removed successfully.");
          return resolve();
        }, 200);
      }
      else if (result == "tokenadded") {
        securityService.resetSecurityObject();
        setTimeout(() => {
          toastrService.success("License key activated successfully.");
          return resolve();
        }, 200);
      }
      else if (result == "notupdated" || result == "error") {
        toastrService.error("The license key is not updated. Please try again.");
        return resolve();
      }
      else if (result == "error_msg") {
        return resolve();
      }
    }).catch((error) => {
      console.error("License initialization failed", error);
      return reject();
    }
    );
  });
}

