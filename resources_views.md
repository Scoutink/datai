----------------------
File: angular.blade.php
Content:
<!doctype html>
<html lang="en" data-critters-container>
<head><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <meta charset="utf-8">
  <title>Document Management</title>
  <base href="/assets/angular/browser/">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
  <style>@font-face{font-family:'Material Icons';font-style:normal;font-weight:400;src:url(https://fonts.gstatic.com/s/materialicons/v145/flUhRq6tzZclQEJ-Vdg-IuiaDsNc.woff2) format('woff2');}@font-face{font-family:'Material Icons Outlined';font-style:normal;font-weight:400;src:url(https://fonts.gstatic.com/s/materialiconsoutlined/v110/gok-H7zzDkdnRel8-DQ6KAXJ69wP1tGnf4ZGhUce.woff2) format('woff2');}@font-face{font-family:'Material Icons Round';font-style:normal;font-weight:400;src:url(https://fonts.gstatic.com/s/materialiconsround/v109/LDItaoyNOAY6Uewc665JcIzCKsKc_M9flwmP.woff2) format('woff2');}@font-face{font-family:'Material Icons Sharp';font-style:normal;font-weight:400;src:url(https://fonts.gstatic.com/s/materialiconssharp/v110/oPWQ_lt5nv4pWNJpghLP75WiFR4kLh3kvmvR.woff2) format('woff2');}@font-face{font-family:'Material Icons Two Tone';font-style:normal;font-weight:400;src:url(https://fonts.gstatic.com/s/materialiconstwotone/v113/hESh6WRmNCxEqUmNyh3JDeGxjVVyMg4tHGctNCu0.woff2) format('woff2');}body{--google-font-color-materialiconstwotone:none;}.material-icons{font-family:'Material Icons';font-weight:normal;font-style:normal;font-size:24px;line-height:1;letter-spacing:normal;text-transform:none;display:inline-block;white-space:nowrap;word-wrap:normal;direction:ltr;-webkit-font-feature-settings:'liga';-webkit-font-smoothing:antialiased;}.material-icons-outlined{font-family:'Material Icons Outlined';font-weight:normal;font-style:normal;font-size:24px;line-height:1;letter-spacing:normal;text-transform:none;display:inline-block;white-space:nowrap;word-wrap:normal;direction:ltr;-webkit-font-feature-settings:'liga';-webkit-font-smoothing:antialiased;}.material-icons-round{font-family:'Material Icons Round';font-weight:normal;font-style:normal;font-size:24px;line-height:1;letter-spacing:normal;text-transform:none;display:inline-block;white-space:nowrap;word-wrap:normal;direction:ltr;-webkit-font-feature-settings:'liga';-webkit-font-smoothing:antialiased;}.material-icons-sharp{font-family:'Material Icons Sharp';font-weight:normal;font-style:normal;font-size:24px;line-height:1;letter-spacing:normal;text-transform:none;display:inline-block;white-space:nowrap;word-wrap:normal;direction:ltr;-webkit-font-feature-settings:'liga';-webkit-font-smoothing:antialiased;}.material-icons-two-tone{font-family:'Material Icons Two Tone';font-weight:normal;font-style:normal;font-size:24px;line-height:1;letter-spacing:normal;text-transform:none;display:inline-block;white-space:nowrap;word-wrap:normal;direction:ltr;-webkit-font-feature-settings:'liga';-webkit-font-smoothing:antialiased;}</style>
  <style>@font-face{font-family:'Roboto';font-style:normal;font-weight:300;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3GUBGEe.woff2) format('woff2');unicode-range:U+0460-052F, U+1C80-1C8A, U+20B4, U+2DE0-2DFF, U+A640-A69F, U+FE2E-FE2F;}@font-face{font-family:'Roboto';font-style:normal;font-weight:300;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3iUBGEe.woff2) format('woff2');unicode-range:U+0301, U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;}@font-face{font-family:'Roboto';font-style:normal;font-weight:300;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3CUBGEe.woff2) format('woff2');unicode-range:U+1F00-1FFF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:300;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3-UBGEe.woff2) format('woff2');unicode-range:U+0370-0377, U+037A-037F, U+0384-038A, U+038C, U+038E-03A1, U+03A3-03FF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:300;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMawCUBGEe.woff2) format('woff2');unicode-range:U+0302-0303, U+0305, U+0307-0308, U+0310, U+0312, U+0315, U+031A, U+0326-0327, U+032C, U+032F-0330, U+0332-0333, U+0338, U+033A, U+0346, U+034D, U+0391-03A1, U+03A3-03A9, U+03B1-03C9, U+03D1, U+03D5-03D6, U+03F0-03F1, U+03F4-03F5, U+2016-2017, U+2034-2038, U+203C, U+2040, U+2043, U+2047, U+2050, U+2057, U+205F, U+2070-2071, U+2074-208E, U+2090-209C, U+20D0-20DC, U+20E1, U+20E5-20EF, U+2100-2112, U+2114-2115, U+2117-2121, U+2123-214F, U+2190, U+2192, U+2194-21AE, U+21B0-21E5, U+21F1-21F2, U+21F4-2211, U+2213-2214, U+2216-22FF, U+2308-230B, U+2310, U+2319, U+231C-2321, U+2336-237A, U+237C, U+2395, U+239B-23B7, U+23D0, U+23DC-23E1, U+2474-2475, U+25AF, U+25B3, U+25B7, U+25BD, U+25C1, U+25CA, U+25CC, U+25FB, U+266D-266F, U+27C0-27FF, U+2900-2AFF, U+2B0E-2B11, U+2B30-2B4C, U+2BFE, U+3030, U+FF5B, U+FF5D, U+1D400-1D7FF, U+1EE00-1EEFF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:300;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMaxKUBGEe.woff2) format('woff2');unicode-range:U+0001-000C, U+000E-001F, U+007F-009F, U+20DD-20E0, U+20E2-20E4, U+2150-218F, U+2190, U+2192, U+2194-2199, U+21AF, U+21E6-21F0, U+21F3, U+2218-2219, U+2299, U+22C4-22C6, U+2300-243F, U+2440-244A, U+2460-24FF, U+25A0-27BF, U+2800-28FF, U+2921-2922, U+2981, U+29BF, U+29EB, U+2B00-2BFF, U+4DC0-4DFF, U+FFF9-FFFB, U+10140-1018E, U+10190-1019C, U+101A0, U+101D0-101FD, U+102E0-102FB, U+10E60-10E7E, U+1D2C0-1D2D3, U+1D2E0-1D37F, U+1F000-1F0FF, U+1F100-1F1AD, U+1F1E6-1F1FF, U+1F30D-1F30F, U+1F315, U+1F31C, U+1F31E, U+1F320-1F32C, U+1F336, U+1F378, U+1F37D, U+1F382, U+1F393-1F39F, U+1F3A7-1F3A8, U+1F3AC-1F3AF, U+1F3C2, U+1F3C4-1F3C6, U+1F3CA-1F3CE, U+1F3D4-1F3E0, U+1F3ED, U+1F3F1-1F3F3, U+1F3F5-1F3F7, U+1F408, U+1F415, U+1F41F, U+1F426, U+1F43F, U+1F441-1F442, U+1F444, U+1F446-1F449, U+1F44C-1F44E, U+1F453, U+1F46A, U+1F47D, U+1F4A3, U+1F4B0, U+1F4B3, U+1F4B9, U+1F4BB, U+1F4BF, U+1F4C8-1F4CB, U+1F4D6, U+1F4DA, U+1F4DF, U+1F4E3-1F4E6, U+1F4EA-1F4ED, U+1F4F7, U+1F4F9-1F4FB, U+1F4FD-1F4FE, U+1F503, U+1F507-1F50B, U+1F50D, U+1F512-1F513, U+1F53E-1F54A, U+1F54F-1F5FA, U+1F610, U+1F650-1F67F, U+1F687, U+1F68D, U+1F691, U+1F694, U+1F698, U+1F6AD, U+1F6B2, U+1F6B9-1F6BA, U+1F6BC, U+1F6C6-1F6CF, U+1F6D3-1F6D7, U+1F6E0-1F6EA, U+1F6F0-1F6F3, U+1F6F7-1F6FC, U+1F700-1F7FF, U+1F800-1F80B, U+1F810-1F847, U+1F850-1F859, U+1F860-1F887, U+1F890-1F8AD, U+1F8B0-1F8BB, U+1F8C0-1F8C1, U+1F900-1F90B, U+1F93B, U+1F946, U+1F984, U+1F996, U+1F9E9, U+1FA00-1FA6F, U+1FA70-1FA7C, U+1FA80-1FA89, U+1FA8F-1FAC6, U+1FACE-1FADC, U+1FADF-1FAE9, U+1FAF0-1FAF8, U+1FB00-1FBFF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:300;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3OUBGEe.woff2) format('woff2');unicode-range:U+0102-0103, U+0110-0111, U+0128-0129, U+0168-0169, U+01A0-01A1, U+01AF-01B0, U+0300-0301, U+0303-0304, U+0308-0309, U+0323, U+0329, U+1EA0-1EF9, U+20AB;}@font-face{font-family:'Roboto';font-style:normal;font-weight:300;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3KUBGEe.woff2) format('woff2');unicode-range:U+0100-02BA, U+02BD-02C5, U+02C7-02CC, U+02CE-02D7, U+02DD-02FF, U+0304, U+0308, U+0329, U+1D00-1DBF, U+1E00-1E9F, U+1EF2-1EFF, U+2020, U+20A0-20AB, U+20AD-20C0, U+2113, U+2C60-2C7F, U+A720-A7FF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:300;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3yUBA.woff2) format('woff2');unicode-range:U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;}@font-face{font-family:'Roboto';font-style:normal;font-weight:400;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3GUBGEe.woff2) format('woff2');unicode-range:U+0460-052F, U+1C80-1C8A, U+20B4, U+2DE0-2DFF, U+A640-A69F, U+FE2E-FE2F;}@font-face{font-family:'Roboto';font-style:normal;font-weight:400;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3iUBGEe.woff2) format('woff2');unicode-range:U+0301, U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;}@font-face{font-family:'Roboto';font-style:normal;font-weight:400;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3CUBGEe.woff2) format('woff2');unicode-range:U+1F00-1FFF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:400;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3-UBGEe.woff2) format('woff2');unicode-range:U+0370-0377, U+037A-037F, U+0384-038A, U+038C, U+038E-03A1, U+03A3-03FF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:400;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMawCUBGEe.woff2) format('woff2');unicode-range:U+0302-0303, U+0305, U+0307-0308, U+0310, U+0312, U+0315, U+031A, U+0326-0327, U+032C, U+032F-0330, U+0332-0333, U+0338, U+033A, U+0346, U+034D, U+0391-03A1, U+03A3-03A9, U+03B1-03C9, U+03D1, U+03D5-03D6, U+03F0-03F1, U+03F4-03F5, U+2016-2017, U+2034-2038, U+203C, U+2040, U+2043, U+2047, U+2050, U+2057, U+205F, U+2070-2071, U+2074-208E, U+2090-209C, U+20D0-20DC, U+20E1, U+20E5-20EF, U+2100-2112, U+2114-2115, U+2117-2121, U+2123-214F, U+2190, U+2192, U+2194-21AE, U+21B0-21E5, U+21F1-21F2, U+21F4-2211, U+2213-2214, U+2216-22FF, U+2308-230B, U+2310, U+2319, U+231C-2321, U+2336-237A, U+237C, U+2395, U+239B-23B7, U+23D0, U+23DC-23E1, U+2474-2475, U+25AF, U+25B3, U+25B7, U+25BD, U+25C1, U+25CA, U+25CC, U+25FB, U+266D-266F, U+27C0-27FF, U+2900-2AFF, U+2B0E-2B11, U+2B30-2B4C, U+2BFE, U+3030, U+FF5B, U+FF5D, U+1D400-1D7FF, U+1EE00-1EEFF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:400;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMaxKUBGEe.woff2) format('woff2');unicode-range:U+0001-000C, U+000E-001F, U+007F-009F, U+20DD-20E0, U+20E2-20E4, U+2150-218F, U+2190, U+2192, U+2194-2199, U+21AF, U+21E6-21F0, U+21F3, U+2218-2219, U+2299, U+22C4-22C6, U+2300-243F, U+2440-244A, U+2460-24FF, U+25A0-27BF, U+2800-28FF, U+2921-2922, U+2981, U+29BF, U+29EB, U+2B00-2BFF, U+4DC0-4DFF, U+FFF9-FFFB, U+10140-1018E, U+10190-1019C, U+101A0, U+101D0-101FD, U+102E0-102FB, U+10E60-10E7E, U+1D2C0-1D2D3, U+1D2E0-1D37F, U+1F000-1F0FF, U+1F100-1F1AD, U+1F1E6-1F1FF, U+1F30D-1F30F, U+1F315, U+1F31C, U+1F31E, U+1F320-1F32C, U+1F336, U+1F378, U+1F37D, U+1F382, U+1F393-1F39F, U+1F3A7-1F3A8, U+1F3AC-1F3AF, U+1F3C2, U+1F3C4-1F3C6, U+1F3CA-1F3CE, U+1F3D4-1F3E0, U+1F3ED, U+1F3F1-1F3F3, U+1F3F5-1F3F7, U+1F408, U+1F415, U+1F41F, U+1F426, U+1F43F, U+1F441-1F442, U+1F444, U+1F446-1F449, U+1F44C-1F44E, U+1F453, U+1F46A, U+1F47D, U+1F4A3, U+1F4B0, U+1F4B3, U+1F4B9, U+1F4BB, U+1F4BF, U+1F4C8-1F4CB, U+1F4D6, U+1F4DA, U+1F4DF, U+1F4E3-1F4E6, U+1F4EA-1F4ED, U+1F4F7, U+1F4F9-1F4FB, U+1F4FD-1F4FE, U+1F503, U+1F507-1F50B, U+1F50D, U+1F512-1F513, U+1F53E-1F54A, U+1F54F-1F5FA, U+1F610, U+1F650-1F67F, U+1F687, U+1F68D, U+1F691, U+1F694, U+1F698, U+1F6AD, U+1F6B2, U+1F6B9-1F6BA, U+1F6BC, U+1F6C6-1F6CF, U+1F6D3-1F6D7, U+1F6E0-1F6EA, U+1F6F0-1F6F3, U+1F6F7-1F6FC, U+1F700-1F7FF, U+1F800-1F80B, U+1F810-1F847, U+1F850-1F859, U+1F860-1F887, U+1F890-1F8AD, U+1F8B0-1F8BB, U+1F8C0-1F8C1, U+1F900-1F90B, U+1F93B, U+1F946, U+1F984, U+1F996, U+1F9E9, U+1FA00-1FA6F, U+1FA70-1FA7C, U+1FA80-1FA89, U+1FA8F-1FAC6, U+1FACE-1FADC, U+1FADF-1FAE9, U+1FAF0-1FAF8, U+1FB00-1FBFF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:400;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3OUBGEe.woff2) format('woff2');unicode-range:U+0102-0103, U+0110-0111, U+0128-0129, U+0168-0169, U+01A0-01A1, U+01AF-01B0, U+0300-0301, U+0303-0304, U+0308-0309, U+0323, U+0329, U+1EA0-1EF9, U+20AB;}@font-face{font-family:'Roboto';font-style:normal;font-weight:400;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3KUBGEe.woff2) format('woff2');unicode-range:U+0100-02BA, U+02BD-02C5, U+02C7-02CC, U+02CE-02D7, U+02DD-02FF, U+0304, U+0308, U+0329, U+1D00-1DBF, U+1E00-1E9F, U+1EF2-1EFF, U+2020, U+20A0-20AB, U+20AD-20C0, U+2113, U+2C60-2C7F, U+A720-A7FF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:400;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3yUBA.woff2) format('woff2');unicode-range:U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;}@font-face{font-family:'Roboto';font-style:normal;font-weight:500;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3GUBGEe.woff2) format('woff2');unicode-range:U+0460-052F, U+1C80-1C8A, U+20B4, U+2DE0-2DFF, U+A640-A69F, U+FE2E-FE2F;}@font-face{font-family:'Roboto';font-style:normal;font-weight:500;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3iUBGEe.woff2) format('woff2');unicode-range:U+0301, U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;}@font-face{font-family:'Roboto';font-style:normal;font-weight:500;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3CUBGEe.woff2) format('woff2');unicode-range:U+1F00-1FFF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:500;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3-UBGEe.woff2) format('woff2');unicode-range:U+0370-0377, U+037A-037F, U+0384-038A, U+038C, U+038E-03A1, U+03A3-03FF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:500;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMawCUBGEe.woff2) format('woff2');unicode-range:U+0302-0303, U+0305, U+0307-0308, U+0310, U+0312, U+0315, U+031A, U+0326-0327, U+032C, U+032F-0330, U+0332-0333, U+0338, U+033A, U+0346, U+034D, U+0391-03A1, U+03A3-03A9, U+03B1-03C9, U+03D1, U+03D5-03D6, U+03F0-03F1, U+03F4-03F5, U+2016-2017, U+2034-2038, U+203C, U+2040, U+2043, U+2047, U+2050, U+2057, U+205F, U+2070-2071, U+2074-208E, U+2090-209C, U+20D0-20DC, U+20E1, U+20E5-20EF, U+2100-2112, U+2114-2115, U+2117-2121, U+2123-214F, U+2190, U+2192, U+2194-21AE, U+21B0-21E5, U+21F1-21F2, U+21F4-2211, U+2213-2214, U+2216-22FF, U+2308-230B, U+2310, U+2319, U+231C-2321, U+2336-237A, U+237C, U+2395, U+239B-23B7, U+23D0, U+23DC-23E1, U+2474-2475, U+25AF, U+25B3, U+25B7, U+25BD, U+25C1, U+25CA, U+25CC, U+25FB, U+266D-266F, U+27C0-27FF, U+2900-2AFF, U+2B0E-2B11, U+2B30-2B4C, U+2BFE, U+3030, U+FF5B, U+FF5D, U+1D400-1D7FF, U+1EE00-1EEFF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:500;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMaxKUBGEe.woff2) format('woff2');unicode-range:U+0001-000C, U+000E-001F, U+007F-009F, U+20DD-20E0, U+20E2-20E4, U+2150-218F, U+2190, U+2192, U+2194-2199, U+21AF, U+21E6-21F0, U+21F3, U+2218-2219, U+2299, U+22C4-22C6, U+2300-243F, U+2440-244A, U+2460-24FF, U+25A0-27BF, U+2800-28FF, U+2921-2922, U+2981, U+29BF, U+29EB, U+2B00-2BFF, U+4DC0-4DFF, U+FFF9-FFFB, U+10140-1018E, U+10190-1019C, U+101A0, U+101D0-101FD, U+102E0-102FB, U+10E60-10E7E, U+1D2C0-1D2D3, U+1D2E0-1D37F, U+1F000-1F0FF, U+1F100-1F1AD, U+1F1E6-1F1FF, U+1F30D-1F30F, U+1F315, U+1F31C, U+1F31E, U+1F320-1F32C, U+1F336, U+1F378, U+1F37D, U+1F382, U+1F393-1F39F, U+1F3A7-1F3A8, U+1F3AC-1F3AF, U+1F3C2, U+1F3C4-1F3C6, U+1F3CA-1F3CE, U+1F3D4-1F3E0, U+1F3ED, U+1F3F1-1F3F3, U+1F3F5-1F3F7, U+1F408, U+1F415, U+1F41F, U+1F426, U+1F43F, U+1F441-1F442, U+1F444, U+1F446-1F449, U+1F44C-1F44E, U+1F453, U+1F46A, U+1F47D, U+1F4A3, U+1F4B0, U+1F4B3, U+1F4B9, U+1F4BB, U+1F4BF, U+1F4C8-1F4CB, U+1F4D6, U+1F4DA, U+1F4DF, U+1F4E3-1F4E6, U+1F4EA-1F4ED, U+1F4F7, U+1F4F9-1F4FB, U+1F4FD-1F4FE, U+1F503, U+1F507-1F50B, U+1F50D, U+1F512-1F513, U+1F53E-1F54A, U+1F54F-1F5FA, U+1F610, U+1F650-1F67F, U+1F687, U+1F68D, U+1F691, U+1F694, U+1F698, U+1F6AD, U+1F6B2, U+1F6B9-1F6BA, U+1F6BC, U+1F6C6-1F6CF, U+1F6D3-1F6D7, U+1F6E0-1F6EA, U+1F6F0-1F6F3, U+1F6F7-1F6FC, U+1F700-1F7FF, U+1F800-1F80B, U+1F810-1F847, U+1F850-1F859, U+1F860-1F887, U+1F890-1F8AD, U+1F8B0-1F8BB, U+1F8C0-1F8C1, U+1F900-1F90B, U+1F93B, U+1F946, U+1F984, U+1F996, U+1F9E9, U+1FA00-1FA6F, U+1FA70-1FA7C, U+1FA80-1FA89, U+1FA8F-1FAC6, U+1FACE-1FADC, U+1FADF-1FAE9, U+1FAF0-1FAF8, U+1FB00-1FBFF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:500;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3OUBGEe.woff2) format('woff2');unicode-range:U+0102-0103, U+0110-0111, U+0128-0129, U+0168-0169, U+01A0-01A1, U+01AF-01B0, U+0300-0301, U+0303-0304, U+0308-0309, U+0323, U+0329, U+1EA0-1EF9, U+20AB;}@font-face{font-family:'Roboto';font-style:normal;font-weight:500;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3KUBGEe.woff2) format('woff2');unicode-range:U+0100-02BA, U+02BD-02C5, U+02C7-02CC, U+02CE-02D7, U+02DD-02FF, U+0304, U+0308, U+0329, U+1D00-1DBF, U+1E00-1E9F, U+1EF2-1EFF, U+2020, U+20A0-20AB, U+20AD-20C0, U+2113, U+2C60-2C7F, U+A720-A7FF;}@font-face{font-family:'Roboto';font-style:normal;font-weight:500;font-stretch:100%;font-display:swap;src:url(https://fonts.gstatic.com/s/roboto/v50/KFO7CnqEu92Fr1ME7kSn66aGLdTylUAMa3yUBA.woff2) format('woff2');unicode-range:U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;}</style>
<style>@charset "UTF-8";html{--mat-option-selected-state-label-text-color:#3f51b5;--mat-option-label-text-color:rgba(0, 0, 0, .87);--mat-option-hover-state-layer-color:rgba(0, 0, 0, .04);--mat-option-focus-state-layer-color:rgba(0, 0, 0, .04);--mat-option-selected-state-layer-color:rgba(0, 0, 0, .04)}html{--mat-full-pseudo-checkbox-selected-icon-color:#ff4081;--mat-full-pseudo-checkbox-selected-checkmark-color:#fafafa;--mat-full-pseudo-checkbox-unselected-icon-color:rgba(0, 0, 0, .54);--mat-full-pseudo-checkbox-disabled-selected-checkmark-color:#fafafa;--mat-full-pseudo-checkbox-disabled-unselected-icon-color:#b0b0b0;--mat-full-pseudo-checkbox-disabled-selected-icon-color:#b0b0b0;--mat-minimal-pseudo-checkbox-selected-checkmark-color:#ff4081;--mat-minimal-pseudo-checkbox-disabled-selected-checkmark-color:#b0b0b0}html{--mdc-filled-text-field-caret-color:#3f51b5;--mdc-filled-text-field-focus-active-indicator-color:#3f51b5;--mdc-filled-text-field-focus-label-text-color:rgba(63, 81, 181, .87);--mdc-filled-text-field-container-color:whitesmoke;--mdc-filled-text-field-disabled-container-color:#fafafa;--mdc-filled-text-field-label-text-color:rgba(0, 0, 0, .6);--mdc-filled-text-field-hover-label-text-color:rgba(0, 0, 0, .6);--mdc-filled-text-field-disabled-label-text-color:rgba(0, 0, 0, .38);--mdc-filled-text-field-input-text-color:rgba(0, 0, 0, .87);--mdc-filled-text-field-disabled-input-text-color:rgba(0, 0, 0, .38);--mdc-filled-text-field-input-text-placeholder-color:rgba(0, 0, 0, .6);--mdc-filled-text-field-error-hover-label-text-color:#f44336;--mdc-filled-text-field-error-focus-label-text-color:#f44336;--mdc-filled-text-field-error-label-text-color:#f44336;--mdc-filled-text-field-error-caret-color:#f44336;--mdc-filled-text-field-active-indicator-color:rgba(0, 0, 0, .42);--mdc-filled-text-field-disabled-active-indicator-color:rgba(0, 0, 0, .06);--mdc-filled-text-field-hover-active-indicator-color:rgba(0, 0, 0, .87);--mdc-filled-text-field-error-active-indicator-color:#f44336;--mdc-filled-text-field-error-focus-active-indicator-color:#f44336;--mdc-filled-text-field-error-hover-active-indicator-color:#f44336;--mdc-outlined-text-field-caret-color:#3f51b5;--mdc-outlined-text-field-focus-outline-color:#3f51b5;--mdc-outlined-text-field-focus-label-text-color:rgba(63, 81, 181, .87);--mdc-outlined-text-field-label-text-color:rgba(0, 0, 0, .6);--mdc-outlined-text-field-hover-label-text-color:rgba(0, 0, 0, .6);--mdc-outlined-text-field-disabled-label-text-color:rgba(0, 0, 0, .38);--mdc-outlined-text-field-input-text-color:rgba(0, 0, 0, .87);--mdc-outlined-text-field-disabled-input-text-color:rgba(0, 0, 0, .38);--mdc-outlined-text-field-input-text-placeholder-color:rgba(0, 0, 0, .6);--mdc-outlined-text-field-error-caret-color:#f44336;--mdc-outlined-text-field-error-focus-label-text-color:#f44336;--mdc-outlined-text-field-error-label-text-color:#f44336;--mdc-outlined-text-field-error-hover-label-text-color:#f44336;--mdc-outlined-text-field-outline-color:rgba(0, 0, 0, .38);--mdc-outlined-text-field-disabled-outline-color:rgba(0, 0, 0, .06);--mdc-outlined-text-field-hover-outline-color:rgba(0, 0, 0, .87);--mdc-outlined-text-field-error-focus-outline-color:#f44336;--mdc-outlined-text-field-error-hover-outline-color:#f44336;--mdc-outlined-text-field-error-outline-color:#f44336;--mat-form-field-focus-select-arrow-color:rgba(63, 81, 181, .87);--mat-form-field-disabled-input-text-placeholder-color:rgba(0, 0, 0, .38);--mat-form-field-state-layer-color:rgba(0, 0, 0, .87);--mat-form-field-error-text-color:#f44336;--mat-form-field-select-option-text-color:inherit;--mat-form-field-select-disabled-option-text-color:GrayText;--mat-form-field-leading-icon-color:unset;--mat-form-field-disabled-leading-icon-color:unset;--mat-form-field-trailing-icon-color:unset;--mat-form-field-disabled-trailing-icon-color:unset;--mat-form-field-error-focus-trailing-icon-color:unset;--mat-form-field-error-hover-trailing-icon-color:unset;--mat-form-field-error-trailing-icon-color:unset;--mat-form-field-enabled-select-arrow-color:rgba(0, 0, 0, .54);--mat-form-field-disabled-select-arrow-color:rgba(0, 0, 0, .38);--mat-form-field-hover-state-layer-opacity:.04;--mat-form-field-focus-state-layer-opacity:.08}html{--mat-select-panel-background-color:white;--mat-select-enabled-trigger-text-color:rgba(0, 0, 0, .87);--mat-select-disabled-trigger-text-color:rgba(0, 0, 0, .38);--mat-select-placeholder-text-color:rgba(0, 0, 0, .6);--mat-select-enabled-arrow-color:rgba(0, 0, 0, .54);--mat-select-disabled-arrow-color:rgba(0, 0, 0, .38);--mat-select-focused-arrow-color:rgba(63, 81, 181, .87);--mat-select-invalid-arrow-color:rgba(244, 67, 54, .87)}html{--mdc-switch-selected-focus-state-layer-color:#3949ab;--mdc-switch-selected-handle-color:#3949ab;--mdc-switch-selected-hover-state-layer-color:#3949ab;--mdc-switch-selected-pressed-state-layer-color:#3949ab;--mdc-switch-selected-focus-handle-color:#1a237e;--mdc-switch-selected-hover-handle-color:#1a237e;--mdc-switch-selected-pressed-handle-color:#1a237e;--mdc-switch-selected-focus-track-color:#7986cb;--mdc-switch-selected-hover-track-color:#7986cb;--mdc-switch-selected-pressed-track-color:#7986cb;--mdc-switch-selected-track-color:#7986cb;--mdc-switch-disabled-selected-handle-color:#424242;--mdc-switch-disabled-selected-icon-color:#fff;--mdc-switch-disabled-selected-track-color:#424242;--mdc-switch-disabled-unselected-handle-color:#424242;--mdc-switch-disabled-unselected-icon-color:#fff;--mdc-switch-disabled-unselected-track-color:#424242;--mdc-switch-handle-surface-color:#fff;--mdc-switch-selected-icon-color:#fff;--mdc-switch-unselected-focus-handle-color:#212121;--mdc-switch-unselected-focus-state-layer-color:#424242;--mdc-switch-unselected-focus-track-color:#e0e0e0;--mdc-switch-unselected-handle-color:#616161;--mdc-switch-unselected-hover-handle-color:#212121;--mdc-switch-unselected-hover-state-layer-color:#424242;--mdc-switch-unselected-hover-track-color:#e0e0e0;--mdc-switch-unselected-icon-color:#fff;--mdc-switch-unselected-pressed-handle-color:#212121;--mdc-switch-unselected-pressed-state-layer-color:#424242;--mdc-switch-unselected-pressed-track-color:#e0e0e0;--mdc-switch-unselected-track-color:#e0e0e0;--mdc-switch-handle-elevation-shadow:0px 2px 1px -1px rgba(0, 0, 0, .2), 0px 1px 1px 0px rgba(0, 0, 0, .14), 0px 1px 3px 0px rgba(0, 0, 0, .12);--mdc-switch-disabled-handle-elevation-shadow:0px 0px 0px 0px rgba(0, 0, 0, .2), 0px 0px 0px 0px rgba(0, 0, 0, .14), 0px 0px 0px 0px rgba(0, 0, 0, .12);--mdc-switch-disabled-label-text-color:rgba(0, 0, 0, .38)}html{--mdc-slider-handle-color:#3f51b5;--mdc-slider-focus-handle-color:#3f51b5;--mdc-slider-hover-handle-color:#3f51b5;--mdc-slider-active-track-color:#3f51b5;--mdc-slider-inactive-track-color:#3f51b5;--mdc-slider-with-tick-marks-inactive-container-color:#3f51b5;--mdc-slider-with-tick-marks-active-container-color:white;--mdc-slider-disabled-active-track-color:#000;--mdc-slider-disabled-handle-color:#000;--mdc-slider-disabled-inactive-track-color:#000;--mdc-slider-label-container-color:#000;--mdc-slider-label-label-text-color:#fff;--mdc-slider-with-overlap-handle-outline-color:#fff;--mdc-slider-with-tick-marks-disabled-container-color:#000;--mat-slider-ripple-color:#3f51b5;--mat-slider-hover-state-layer-color:rgba(63, 81, 181, .05);--mat-slider-focus-state-layer-color:rgba(63, 81, 181, .2);--mat-slider-value-indicator-opacity:.6}html{--mdc-checkbox-disabled-selected-icon-color:rgba(0, 0, 0, .38);--mdc-checkbox-disabled-unselected-icon-color:rgba(0, 0, 0, .38);--mdc-checkbox-selected-checkmark-color:white;--mdc-checkbox-selected-focus-icon-color:#ff4081;--mdc-checkbox-selected-hover-icon-color:#ff4081;--mdc-checkbox-selected-icon-color:#ff4081;--mdc-checkbox-selected-pressed-icon-color:#ff4081;--mdc-checkbox-unselected-focus-icon-color:#212121;--mdc-checkbox-unselected-hover-icon-color:#212121;--mdc-checkbox-unselected-icon-color:rgba(0, 0, 0, .54);--mdc-checkbox-selected-focus-state-layer-color:#ff4081;--mdc-checkbox-selected-hover-state-layer-color:#ff4081;--mdc-checkbox-selected-pressed-state-layer-color:#ff4081;--mdc-checkbox-unselected-focus-state-layer-color:black;--mdc-checkbox-unselected-hover-state-layer-color:black;--mdc-checkbox-unselected-pressed-state-layer-color:black;--mat-checkbox-disabled-label-color:rgba(0, 0, 0, .38);--mat-checkbox-label-text-color:rgba(0, 0, 0, .87)}html{--mdc-snackbar-container-color:#333333;--mdc-snackbar-supporting-text-color:rgba(255, 255, 255, .87);--mat-snack-bar-button-color:#ff4081}html{--mdc-circular-progress-active-indicator-color:#3f51b5}html{--mat-badge-background-color:#3f51b5;--mat-badge-text-color:white;--mat-badge-disabled-state-background-color:#b9b9b9;--mat-badge-disabled-state-text-color:rgba(0, 0, 0, .38)}html{--mat-datepicker-calendar-date-selected-state-text-color:white;--mat-datepicker-calendar-date-selected-state-background-color:#3f51b5;--mat-datepicker-calendar-date-selected-disabled-state-background-color:rgba(63, 81, 181, .4);--mat-datepicker-calendar-date-today-selected-state-outline-color:white;--mat-datepicker-calendar-date-focus-state-background-color:rgba(63, 81, 181, .3);--mat-datepicker-calendar-date-hover-state-background-color:rgba(63, 81, 181, .3);--mat-datepicker-toggle-active-state-icon-color:#3f51b5;--mat-datepicker-calendar-date-in-range-state-background-color:rgba(63, 81, 181, .2);--mat-datepicker-calendar-date-in-comparison-range-state-background-color:rgba(249, 171, 0, .2);--mat-datepicker-calendar-date-in-overlap-range-state-background-color:#a8dab5;--mat-datepicker-calendar-date-in-overlap-range-selected-state-background-color:#46a35e;--mat-datepicker-toggle-icon-color:rgba(0, 0, 0, .54);--mat-datepicker-calendar-body-label-text-color:rgba(0, 0, 0, .54);--mat-datepicker-calendar-period-button-text-color:black;--mat-datepicker-calendar-period-button-icon-color:rgba(0, 0, 0, .54);--mat-datepicker-calendar-navigation-button-icon-color:rgba(0, 0, 0, .54);--mat-datepicker-calendar-header-divider-color:rgba(0, 0, 0, .12);--mat-datepicker-calendar-header-text-color:rgba(0, 0, 0, .54);--mat-datepicker-calendar-date-today-outline-color:rgba(0, 0, 0, .38);--mat-datepicker-calendar-date-today-disabled-state-outline-color:rgba(0, 0, 0, .18);--mat-datepicker-calendar-date-text-color:rgba(0, 0, 0, .87);--mat-datepicker-calendar-date-outline-color:transparent;--mat-datepicker-calendar-date-disabled-state-text-color:rgba(0, 0, 0, .38);--mat-datepicker-calendar-date-preview-state-outline-color:rgba(0, 0, 0, .24);--mat-datepicker-range-input-separator-color:rgba(0, 0, 0, .87);--mat-datepicker-range-input-disabled-state-separator-color:rgba(0, 0, 0, .38);--mat-datepicker-range-input-disabled-state-text-color:rgba(0, 0, 0, .38);--mat-datepicker-calendar-container-background-color:white;--mat-datepicker-calendar-container-text-color:rgba(0, 0, 0, .87)}html{--mat-stepper-header-icon-foreground-color:white;--mat-stepper-header-selected-state-icon-background-color:#3f51b5;--mat-stepper-header-selected-state-icon-foreground-color:white;--mat-stepper-header-done-state-icon-background-color:#3f51b5;--mat-stepper-header-done-state-icon-foreground-color:white;--mat-stepper-header-edit-state-icon-background-color:#3f51b5;--mat-stepper-header-edit-state-icon-foreground-color:white;--mat-stepper-container-color:white;--mat-stepper-line-color:rgba(0, 0, 0, .12);--mat-stepper-header-hover-state-layer-color:rgba(0, 0, 0, .04);--mat-stepper-header-focus-state-layer-color:rgba(0, 0, 0, .04);--mat-stepper-header-label-text-color:rgba(0, 0, 0, .54);--mat-stepper-header-optional-label-text-color:rgba(0, 0, 0, .54);--mat-stepper-header-selected-state-label-text-color:rgba(0, 0, 0, .87);--mat-stepper-header-error-state-label-text-color:#f44336;--mat-stepper-header-icon-background-color:rgba(0, 0, 0, .54);--mat-stepper-header-error-state-icon-foreground-color:#f44336;--mat-stepper-header-error-state-icon-background-color:transparent}:root{--bs-blue:#0d6efd;--bs-indigo:#6610f2;--bs-purple:#6f42c1;--bs-pink:#d63384;--bs-red:#dc3545;--bs-orange:#fd7e14;--bs-yellow:#ffc107;--bs-green:#198754;--bs-teal:#20c997;--bs-cyan:#0dcaf0;--bs-black:#000;--bs-white:#fff;--bs-gray:#6c757d;--bs-gray-dark:#343a40;--bs-gray-100:#f8f9fa;--bs-gray-200:#e9ecef;--bs-gray-300:#dee2e6;--bs-gray-400:#ced4da;--bs-gray-500:#adb5bd;--bs-gray-600:#6c757d;--bs-gray-700:#495057;--bs-gray-800:#343a40;--bs-gray-900:#212529;--bs-primary:#0d6efd;--bs-secondary:#6c757d;--bs-success:#198754;--bs-info:#0dcaf0;--bs-warning:#ffc107;--bs-danger:#dc3545;--bs-light:#f8f9fa;--bs-dark:#212529;--bs-primary-rgb:13,110,253;--bs-secondary-rgb:108,117,125;--bs-success-rgb:25,135,84;--bs-info-rgb:13,202,240;--bs-warning-rgb:255,193,7;--bs-danger-rgb:220,53,69;--bs-light-rgb:248,249,250;--bs-dark-rgb:33,37,41;--bs-primary-text-emphasis:#052c65;--bs-secondary-text-emphasis:#2b2f32;--bs-success-text-emphasis:#0a3622;--bs-info-text-emphasis:#055160;--bs-warning-text-emphasis:#664d03;--bs-danger-text-emphasis:#58151c;--bs-light-text-emphasis:#495057;--bs-dark-text-emphasis:#495057;--bs-primary-bg-subtle:#cfe2ff;--bs-secondary-bg-subtle:#e2e3e5;--bs-success-bg-subtle:#d1e7dd;--bs-info-bg-subtle:#cff4fc;--bs-warning-bg-subtle:#fff3cd;--bs-danger-bg-subtle:#f8d7da;--bs-light-bg-subtle:#fcfcfd;--bs-dark-bg-subtle:#ced4da;--bs-primary-border-subtle:#9ec5fe;--bs-secondary-border-subtle:#c4c8cb;--bs-success-border-subtle:#a3cfbb;--bs-info-border-subtle:#9eeaf9;--bs-warning-border-subtle:#ffe69c;--bs-danger-border-subtle:#f1aeb5;--bs-light-border-subtle:#e9ecef;--bs-dark-border-subtle:#adb5bd;--bs-white-rgb:255,255,255;--bs-black-rgb:0,0,0;--bs-font-sans-serif:system-ui,-apple-system,"Segoe UI",Roboto,"Helvetica Neue","Noto Sans","Liberation Sans",Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";--bs-font-monospace:SFMono-Regular,Menlo,Monaco,Consolas,"Liberation Mono","Courier New",monospace;--bs-gradient:linear-gradient(180deg, rgba(255, 255, 255, .15), rgba(255, 255, 255, 0));--bs-body-font-family:var(--bs-font-sans-serif);--bs-body-font-size:1rem;--bs-body-font-weight:400;--bs-body-line-height:1.5;--bs-body-color:#212529;--bs-body-color-rgb:33,37,41;--bs-body-bg:#fff;--bs-body-bg-rgb:255,255,255;--bs-emphasis-color:#000;--bs-emphasis-color-rgb:0,0,0;--bs-secondary-color:rgba(33, 37, 41, .75);--bs-secondary-color-rgb:33,37,41;--bs-secondary-bg:#e9ecef;--bs-secondary-bg-rgb:233,236,239;--bs-tertiary-color:rgba(33, 37, 41, .5);--bs-tertiary-color-rgb:33,37,41;--bs-tertiary-bg:#f8f9fa;--bs-tertiary-bg-rgb:248,249,250;--bs-heading-color:inherit;--bs-link-color:#0d6efd;--bs-link-color-rgb:13,110,253;--bs-link-decoration:underline;--bs-link-hover-color:#0a58ca;--bs-link-hover-color-rgb:10,88,202;--bs-code-color:#d63384;--bs-highlight-color:#212529;--bs-highlight-bg:#fff3cd;--bs-border-width:1px;--bs-border-style:solid;--bs-border-color:#dee2e6;--bs-border-color-translucent:rgba(0, 0, 0, .175);--bs-border-radius:.375rem;--bs-border-radius-sm:.25rem;--bs-border-radius-lg:.5rem;--bs-border-radius-xl:1rem;--bs-border-radius-xxl:2rem;--bs-border-radius-2xl:var(--bs-border-radius-xxl);--bs-border-radius-pill:50rem;--bs-box-shadow:0 .5rem 1rem rgba(0, 0, 0, .15);--bs-box-shadow-sm:0 .125rem .25rem rgba(0, 0, 0, .075);--bs-box-shadow-lg:0 1rem 3rem rgba(0, 0, 0, .175);--bs-box-shadow-inset:inset 0 1px 2px rgba(0, 0, 0, .075);--bs-focus-ring-width:.25rem;--bs-focus-ring-opacity:.25;--bs-focus-ring-color:rgba(13, 110, 253, .25);--bs-form-valid-color:#198754;--bs-form-valid-border-color:#198754;--bs-form-invalid-color:#dc3545;--bs-form-invalid-border-color:#dc3545}*,:after,:before{box-sizing:border-box}@media (prefers-reduced-motion:no-preference){:root{scroll-behavior:smooth}}body{margin:0;font-family:var(--bs-body-font-family);font-size:var(--bs-body-font-size);font-weight:var(--bs-body-font-weight);line-height:var(--bs-body-line-height);color:var(--bs-body-color);text-align:var(--bs-body-text-align);background-color:var(--bs-body-bg);-webkit-text-size-adjust:100%;-webkit-tap-highlight-color:transparent}:root{--bs-breakpoint-xs:0;--bs-breakpoint-sm:576px;--bs-breakpoint-md:768px;--bs-breakpoint-lg:992px;--bs-breakpoint-xl:1200px;--bs-breakpoint-xxl:1400px}:root{--bs-btn-close-filter: }:root{--bs-carousel-indicator-active-bg:#fff;--bs-carousel-caption-color:#fff;--bs-carousel-control-icon-filter: }body{background-color:#f1f2f7}body{-moz-transition:all .5s;-o-transition:all .5s;-webkit-transition:all .5s;transition:all .5s;font-family:Roboto,sans-serif;font-size:14px}html{height:100%}html{--mat-ripple-color:rgba(0, 0, 0, .1)}html{--mat-option-selected-state-label-text-color:#673ab7;--mat-option-label-text-color:rgba(0, 0, 0, .87);--mat-option-hover-state-layer-color:rgba(0, 0, 0, .04);--mat-option-focus-state-layer-color:rgba(0, 0, 0, .04);--mat-option-selected-state-layer-color:rgba(0, 0, 0, .04)}html{--mat-optgroup-label-text-color:rgba(0, 0, 0, .87)}html{--mat-full-pseudo-checkbox-selected-icon-color:#ffd740;--mat-full-pseudo-checkbox-selected-checkmark-color:#fafafa;--mat-full-pseudo-checkbox-unselected-icon-color:rgba(0, 0, 0, .54);--mat-full-pseudo-checkbox-disabled-selected-checkmark-color:#fafafa;--mat-full-pseudo-checkbox-disabled-unselected-icon-color:#b0b0b0;--mat-full-pseudo-checkbox-disabled-selected-icon-color:#b0b0b0;--mat-minimal-pseudo-checkbox-selected-checkmark-color:#ffd740;--mat-minimal-pseudo-checkbox-disabled-selected-checkmark-color:#b0b0b0}html{--mat-app-background-color:#fafafa;--mat-app-text-color:rgba(0, 0, 0, .87);--mat-app-elevation-shadow-level-0:0px 0px 0px 0px rgba(0, 0, 0, .2), 0px 0px 0px 0px rgba(0, 0, 0, .14), 0px 0px 0px 0px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-1:0px 2px 1px -1px rgba(0, 0, 0, .2), 0px 1px 1px 0px rgba(0, 0, 0, .14), 0px 1px 3px 0px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-2:0px 3px 1px -2px rgba(0, 0, 0, .2), 0px 2px 2px 0px rgba(0, 0, 0, .14), 0px 1px 5px 0px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-3:0px 3px 3px -2px rgba(0, 0, 0, .2), 0px 3px 4px 0px rgba(0, 0, 0, .14), 0px 1px 8px 0px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-4:0px 2px 4px -1px rgba(0, 0, 0, .2), 0px 4px 5px 0px rgba(0, 0, 0, .14), 0px 1px 10px 0px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-5:0px 3px 5px -1px rgba(0, 0, 0, .2), 0px 5px 8px 0px rgba(0, 0, 0, .14), 0px 1px 14px 0px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-6:0px 3px 5px -1px rgba(0, 0, 0, .2), 0px 6px 10px 0px rgba(0, 0, 0, .14), 0px 1px 18px 0px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-7:0px 4px 5px -2px rgba(0, 0, 0, .2), 0px 7px 10px 1px rgba(0, 0, 0, .14), 0px 2px 16px 1px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-8:0px 5px 5px -3px rgba(0, 0, 0, .2), 0px 8px 10px 1px rgba(0, 0, 0, .14), 0px 3px 14px 2px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-9:0px 5px 6px -3px rgba(0, 0, 0, .2), 0px 9px 12px 1px rgba(0, 0, 0, .14), 0px 3px 16px 2px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-10:0px 6px 6px -3px rgba(0, 0, 0, .2), 0px 10px 14px 1px rgba(0, 0, 0, .14), 0px 4px 18px 3px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-11:0px 6px 7px -4px rgba(0, 0, 0, .2), 0px 11px 15px 1px rgba(0, 0, 0, .14), 0px 4px 20px 3px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-12:0px 7px 8px -4px rgba(0, 0, 0, .2), 0px 12px 17px 2px rgba(0, 0, 0, .14), 0px 5px 22px 4px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-13:0px 7px 8px -4px rgba(0, 0, 0, .2), 0px 13px 19px 2px rgba(0, 0, 0, .14), 0px 5px 24px 4px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-14:0px 7px 9px -4px rgba(0, 0, 0, .2), 0px 14px 21px 2px rgba(0, 0, 0, .14), 0px 5px 26px 4px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-15:0px 8px 9px -5px rgba(0, 0, 0, .2), 0px 15px 22px 2px rgba(0, 0, 0, .14), 0px 6px 28px 5px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-16:0px 8px 10px -5px rgba(0, 0, 0, .2), 0px 16px 24px 2px rgba(0, 0, 0, .14), 0px 6px 30px 5px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-17:0px 8px 11px -5px rgba(0, 0, 0, .2), 0px 17px 26px 2px rgba(0, 0, 0, .14), 0px 6px 32px 5px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-18:0px 9px 11px -5px rgba(0, 0, 0, .2), 0px 18px 28px 2px rgba(0, 0, 0, .14), 0px 7px 34px 6px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-19:0px 9px 12px -6px rgba(0, 0, 0, .2), 0px 19px 29px 2px rgba(0, 0, 0, .14), 0px 7px 36px 6px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-20:0px 10px 13px -6px rgba(0, 0, 0, .2), 0px 20px 31px 3px rgba(0, 0, 0, .14), 0px 8px 38px 7px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-21:0px 10px 13px -6px rgba(0, 0, 0, .2), 0px 21px 33px 3px rgba(0, 0, 0, .14), 0px 8px 40px 7px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-22:0px 10px 14px -6px rgba(0, 0, 0, .2), 0px 22px 35px 3px rgba(0, 0, 0, .14), 0px 8px 42px 7px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-23:0px 11px 14px -7px rgba(0, 0, 0, .2), 0px 23px 36px 3px rgba(0, 0, 0, .14), 0px 9px 44px 8px rgba(0, 0, 0, .12);--mat-app-elevation-shadow-level-24:0px 11px 15px -7px rgba(0, 0, 0, .2), 0px 24px 38px 3px rgba(0, 0, 0, .14), 0px 9px 46px 8px rgba(0, 0, 0, .12)}html{--mat-option-label-text-font:Roboto, sans-serif;--mat-option-label-text-line-height:24px;--mat-option-label-text-size:16px;--mat-option-label-text-tracking:.03125em;--mat-option-label-text-weight:400}html{--mat-optgroup-label-text-font:Roboto, sans-serif;--mat-optgroup-label-text-line-height:24px;--mat-optgroup-label-text-size:16px;--mat-optgroup-label-text-tracking:.03125em;--mat-optgroup-label-text-weight:400}html{--mdc-elevated-card-container-shape:4px;--mdc-outlined-card-container-shape:4px;--mdc-outlined-card-outline-width:1px}html{--mdc-elevated-card-container-color:white;--mdc-elevated-card-container-elevation:0px 2px 1px -1px rgba(0, 0, 0, .2), 0px 1px 1px 0px rgba(0, 0, 0, .14), 0px 1px 3px 0px rgba(0, 0, 0, .12);--mdc-outlined-card-container-color:white;--mdc-outlined-card-outline-color:rgba(0, 0, 0, .12);--mdc-outlined-card-container-elevation:0px 0px 0px 0px rgba(0, 0, 0, .2), 0px 0px 0px 0px rgba(0, 0, 0, .14), 0px 0px 0px 0px rgba(0, 0, 0, .12);--mat-card-subtitle-text-color:rgba(0, 0, 0, .54)}html{--mat-card-title-text-font:Roboto, sans-serif;--mat-card-title-text-line-height:32px;--mat-card-title-text-size:20px;--mat-card-title-text-tracking:.0125em;--mat-card-title-text-weight:500;--mat-card-subtitle-text-font:Roboto, sans-serif;--mat-card-subtitle-text-line-height:22px;--mat-card-subtitle-text-size:14px;--mat-card-subtitle-text-tracking:.0071428571em;--mat-card-subtitle-text-weight:500}html{--mdc-linear-progress-active-indicator-height:4px;--mdc-linear-progress-track-height:4px;--mdc-linear-progress-track-shape:0}html{--mdc-plain-tooltip-container-shape:4px;--mdc-plain-tooltip-supporting-text-line-height:16px}html{--mdc-plain-tooltip-container-color:#616161;--mdc-plain-tooltip-supporting-text-color:#fff}html{--mdc-plain-tooltip-supporting-text-font:Roboto, sans-serif;--mdc-plain-tooltip-supporting-text-size:12px;--mdc-plain-tooltip-supporting-text-weight:400;--mdc-plain-tooltip-supporting-text-tracking:.0333333333em}html{--mdc-filled-text-field-active-indicator-height:1px;--mdc-filled-text-field-focus-active-indicator-height:2px;--mdc-filled-text-field-container-shape:4px;--mdc-outlined-text-field-outline-width:1px;--mdc-outlined-text-field-focus-outline-width:2px;--mdc-outlined-text-field-container-shape:4px}html{--mdc-filled-text-field-caret-color:#673ab7;--mdc-filled-text-field-focus-active-indicator-color:#673ab7;--mdc-filled-text-field-focus-label-text-color:rgba(103, 58, 183, .87);--mdc-filled-text-field-container-color:whitesmoke;--mdc-filled-text-field-disabled-container-color:#fafafa;--mdc-filled-text-field-label-text-color:rgba(0, 0, 0, .6);--mdc-filled-text-field-hover-label-text-color:rgba(0, 0, 0, .6);--mdc-filled-text-field-disabled-label-text-color:rgba(0, 0, 0, .38);--mdc-filled-text-field-input-text-color:rgba(0, 0, 0, .87);--mdc-filled-text-field-disabled-input-text-color:rgba(0, 0, 0, .38);--mdc-filled-text-field-input-text-placeholder-color:rgba(0, 0, 0, .6);--mdc-filled-text-field-error-hover-label-text-color:#f44336;--mdc-filled-text-field-error-focus-label-text-color:#f44336;--mdc-filled-text-field-error-label-text-color:#f44336;--mdc-filled-text-field-error-caret-color:#f44336;--mdc-filled-text-field-active-indicator-color:rgba(0, 0, 0, .42);--mdc-filled-text-field-disabled-active-indicator-color:rgba(0, 0, 0, .06);--mdc-filled-text-field-hover-active-indicator-color:rgba(0, 0, 0, .87);--mdc-filled-text-field-error-active-indicator-color:#f44336;--mdc-filled-text-field-error-focus-active-indicator-color:#f44336;--mdc-filled-text-field-error-hover-active-indicator-color:#f44336;--mdc-outlined-text-field-caret-color:#673ab7;--mdc-outlined-text-field-focus-outline-color:#673ab7;--mdc-outlined-text-field-focus-label-text-color:rgba(103, 58, 183, .87);--mdc-outlined-text-field-label-text-color:rgba(0, 0, 0, .6);--mdc-outlined-text-field-hover-label-text-color:rgba(0, 0, 0, .6);--mdc-outlined-text-field-disabled-label-text-color:rgba(0, 0, 0, .38);--mdc-outlined-text-field-input-text-color:rgba(0, 0, 0, .87);--mdc-outlined-text-field-disabled-input-text-color:rgba(0, 0, 0, .38);--mdc-outlined-text-field-input-text-placeholder-color:rgba(0, 0, 0, .6);--mdc-outlined-text-field-error-caret-color:#f44336;--mdc-outlined-text-field-error-focus-label-text-color:#f44336;--mdc-outlined-text-field-error-label-text-color:#f44336;--mdc-outlined-text-field-error-hover-label-text-color:#f44336;--mdc-outlined-text-field-outline-color:rgba(0, 0, 0, .38);--mdc-outlined-text-field-disabled-outline-color:rgba(0, 0, 0, .06);--mdc-outlined-text-field-hover-outline-color:rgba(0, 0, 0, .87);--mdc-outlined-text-field-error-focus-outline-color:#f44336;--mdc-outlined-text-field-error-hover-outline-color:#f44336;--mdc-outlined-text-field-error-outline-color:#f44336;--mat-form-field-focus-select-arrow-color:rgba(103, 58, 183, .87);--mat-form-field-disabled-input-text-placeholder-color:rgba(0, 0, 0, .38);--mat-form-field-state-layer-color:rgba(0, 0, 0, .87);--mat-form-field-error-text-color:#f44336;--mat-form-field-select-option-text-color:inherit;--mat-form-field-select-disabled-option-text-color:GrayText;--mat-form-field-leading-icon-color:unset;--mat-form-field-disabled-leading-icon-color:unset;--mat-form-field-trailing-icon-color:unset;--mat-form-field-disabled-trailing-icon-color:unset;--mat-form-field-error-focus-trailing-icon-color:unset;--mat-form-field-error-hover-trailing-icon-color:unset;--mat-form-field-error-trailing-icon-color:unset;--mat-form-field-enabled-select-arrow-color:rgba(0, 0, 0, .54);--mat-form-field-disabled-select-arrow-color:rgba(0, 0, 0, .38);--mat-form-field-hover-state-layer-opacity:.04;--mat-form-field-focus-state-layer-opacity:.08}html{--mat-form-field-container-height:56px;--mat-form-field-filled-label-display:block;--mat-form-field-container-vertical-padding:16px;--mat-form-field-filled-with-label-container-padding-top:24px;--mat-form-field-filled-with-label-container-padding-bottom:8px}html{--mdc-filled-text-field-label-text-font:Roboto, sans-serif;--mdc-filled-text-field-label-text-size:16px;--mdc-filled-text-field-label-text-tracking:.03125em;--mdc-filled-text-field-label-text-weight:400;--mdc-outlined-text-field-label-text-font:Roboto, sans-serif;--mdc-outlined-text-field-label-text-size:16px;--mdc-outlined-text-field-label-text-tracking:.03125em;--mdc-outlined-text-field-label-text-weight:400;--mat-form-field-container-text-font:Roboto, sans-serif;--mat-form-field-container-text-line-height:24px;--mat-form-field-container-text-size:16px;--mat-form-field-container-text-tracking:.03125em;--mat-form-field-container-text-weight:400;--mat-form-field-outlined-label-text-populated-size:16px;--mat-form-field-subscript-text-font:Roboto, sans-serif;--mat-form-field-subscript-text-line-height:20px;--mat-form-field-subscript-text-size:12px;--mat-form-field-subscript-text-tracking:.0333333333em;--mat-form-field-subscript-text-weight:400}html{--mat-select-container-elevation-shadow:0px 5px 5px -3px rgba(0, 0, 0, .2), 0px 8px 10px 1px rgba(0, 0, 0, .14), 0px 3px 14px 2px rgba(0, 0, 0, .12)}html{--mat-select-panel-background-color:white;--mat-select-enabled-trigger-text-color:rgba(0, 0, 0, .87);--mat-select-disabled-trigger-text-color:rgba(0, 0, 0, .38);--mat-select-placeholder-text-color:rgba(0, 0, 0, .6);--mat-select-enabled-arrow-color:rgba(0, 0, 0, .54);--mat-select-disabled-arrow-color:rgba(0, 0, 0, .38);--mat-select-focused-arrow-color:rgba(103, 58, 183, .87);--mat-select-invalid-arrow-color:rgba(244, 67, 54, .87)}html{--mat-select-arrow-transform:translateY(-8px)}html{--mat-select-trigger-text-font:Roboto, sans-serif;--mat-select-trigger-text-line-height:24px;--mat-select-trigger-text-size:16px;--mat-select-trigger-text-tracking:.03125em;--mat-select-trigger-text-weight:400}html{--mat-autocomplete-container-shape:4px;--mat-autocomplete-container-elevation-shadow:0px 5px 5px -3px rgba(0, 0, 0, .2), 0px 8px 10px 1px rgba(0, 0, 0, .14), 0px 3px 14px 2px rgba(0, 0, 0, .12)}html{--mat-autocomplete-background-color:white}html{--mdc-dialog-container-shape:4px;--mat-dialog-container-elevation-shadow:0px 11px 15px -7px rgba(0, 0, 0, .2), 0px 24px 38px 3px rgba(0, 0, 0, .14), 0px 9px 46px 8px rgba(0, 0, 0, .12);--mat-dialog-container-max-width:80vw;--mat-dialog-container-small-max-width:80vw;--mat-dialog-container-min-width:0;--mat-dialog-actions-alignment:start;--mat-dialog-actions-padding:8px;--mat-dialog-content-padding:20px 24px;--mat-dialog-with-actions-content-padding:20px 24px;--mat-dialog-headline-padding:0 24px 9px}html{--mdc-dialog-container-color:white;--mdc-dialog-subhead-color:rgba(0, 0, 0, .87);--mdc-dialog-supporting-text-color:rgba(0, 0, 0, .6)}html{--mdc-dialog-subhead-font:Roboto, sans-serif;--mdc-dialog-subhead-line-height:32px;--mdc-dialog-subhead-size:20px;--mdc-dialog-subhead-weight:500;--mdc-dialog-subhead-tracking:.0125em;--mdc-dialog-supporting-text-font:Roboto, sans-serif;--mdc-dialog-supporting-text-line-height:24px;--mdc-dialog-supporting-text-size:16px;--mdc-dialog-supporting-text-weight:400;--mdc-dialog-supporting-text-tracking:.03125em}html{--mdc-switch-disabled-selected-icon-opacity:.38;--mdc-switch-disabled-track-opacity:.12;--mdc-switch-disabled-unselected-icon-opacity:.38;--mdc-switch-handle-height:20px;--mdc-switch-handle-shape:10px;--mdc-switch-handle-width:20px;--mdc-switch-selected-icon-size:18px;--mdc-switch-track-height:14px;--mdc-switch-track-shape:7px;--mdc-switch-track-width:36px;--mdc-switch-unselected-icon-size:18px;--mdc-switch-selected-focus-state-layer-opacity:.12;--mdc-switch-selected-hover-state-layer-opacity:.04;--mdc-switch-selected-pressed-state-layer-opacity:.1;--mdc-switch-unselected-focus-state-layer-opacity:.12;--mdc-switch-unselected-hover-state-layer-opacity:.04;--mdc-switch-unselected-pressed-state-layer-opacity:.1}html{--mdc-switch-selected-focus-state-layer-color:#5e35b1;--mdc-switch-selected-handle-color:#5e35b1;--mdc-switch-selected-hover-state-layer-color:#5e35b1;--mdc-switch-selected-pressed-state-layer-color:#5e35b1;--mdc-switch-selected-focus-handle-color:#311b92;--mdc-switch-selected-hover-handle-color:#311b92;--mdc-switch-selected-pressed-handle-color:#311b92;--mdc-switch-selected-focus-track-color:#9575cd;--mdc-switch-selected-hover-track-color:#9575cd;--mdc-switch-selected-pressed-track-color:#9575cd;--mdc-switch-selected-track-color:#9575cd;--mdc-switch-disabled-selected-handle-color:#424242;--mdc-switch-disabled-selected-icon-color:#fff;--mdc-switch-disabled-selected-track-color:#424242;--mdc-switch-disabled-unselected-handle-color:#424242;--mdc-switch-disabled-unselected-icon-color:#fff;--mdc-switch-disabled-unselected-track-color:#424242;--mdc-switch-handle-surface-color:#fff;--mdc-switch-selected-icon-color:#fff;--mdc-switch-unselected-focus-handle-color:#212121;--mdc-switch-unselected-focus-state-layer-color:#424242;--mdc-switch-unselected-focus-track-color:#e0e0e0;--mdc-switch-unselected-handle-color:#616161;--mdc-switch-unselected-hover-handle-color:#212121;--mdc-switch-unselected-hover-state-layer-color:#424242;--mdc-switch-unselected-hover-track-color:#e0e0e0;--mdc-switch-unselected-icon-color:#fff;--mdc-switch-unselected-pressed-handle-color:#212121;--mdc-switch-unselected-pressed-state-layer-color:#424242;--mdc-switch-unselected-pressed-track-color:#e0e0e0;--mdc-switch-unselected-track-color:#e0e0e0;--mdc-switch-handle-elevation-shadow:0px 2px 1px -1px rgba(0, 0, 0, .2), 0px 1px 1px 0px rgba(0, 0, 0, .14), 0px 1px 3px 0px rgba(0, 0, 0, .12);--mdc-switch-disabled-handle-elevation-shadow:0px 0px 0px 0px rgba(0, 0, 0, .2), 0px 0px 0px 0px rgba(0, 0, 0, .14), 0px 0px 0px 0px rgba(0, 0, 0, .12);--mdc-switch-disabled-label-text-color:rgba(0, 0, 0, .38)}html{--mdc-switch-state-layer-size:40px}html{--mdc-radio-disabled-selected-icon-opacity:.38;--mdc-radio-disabled-unselected-icon-opacity:.38;--mdc-radio-state-layer-size:40px}html{--mdc-radio-state-layer-size:40px;--mat-radio-touch-target-display:block}html{--mat-radio-label-text-font:Roboto, sans-serif;--mat-radio-label-text-line-height:20px;--mat-radio-label-text-size:14px;--mat-radio-label-text-tracking:.0178571429em;--mat-radio-label-text-weight:400}html{--mdc-slider-active-track-height:6px;--mdc-slider-active-track-shape:9999px;--mdc-slider-handle-height:20px;--mdc-slider-handle-shape:50%;--mdc-slider-handle-width:20px;--mdc-slider-inactive-track-height:4px;--mdc-slider-inactive-track-shape:9999px;--mdc-slider-with-overlap-handle-outline-width:1px;--mdc-slider-with-tick-marks-active-container-opacity:.6;--mdc-slider-with-tick-marks-container-shape:50%;--mdc-slider-with-tick-marks-container-size:2px;--mdc-slider-with-tick-marks-inactive-container-opacity:.6;--mdc-slider-handle-elevation:0px 2px 1px -1px rgba(0, 0, 0, .2), 0px 1px 1px 0px rgba(0, 0, 0, .14), 0px 1px 3px 0px rgba(0, 0, 0, .12);--mat-slider-value-indicator-width:auto;--mat-slider-value-indicator-height:32px;--mat-slider-value-indicator-caret-display:block;--mat-slider-value-indicator-border-radius:4px;--mat-slider-value-indicator-padding:0 12px;--mat-slider-value-indicator-text-transform:none;--mat-slider-value-indicator-container-transform:translateX(-50%)}html{--mdc-slider-handle-color:#673ab7;--mdc-slider-focus-handle-color:#673ab7;--mdc-slider-hover-handle-color:#673ab7;--mdc-slider-active-track-color:#673ab7;--mdc-slider-inactive-track-color:#673ab7;--mdc-slider-with-tick-marks-inactive-container-color:#673ab7;--mdc-slider-with-tick-marks-active-container-color:white;--mdc-slider-disabled-active-track-color:#000;--mdc-slider-disabled-handle-color:#000;--mdc-slider-disabled-inactive-track-color:#000;--mdc-slider-label-container-color:#000;--mdc-slider-label-label-text-color:#fff;--mdc-slider-with-overlap-handle-outline-color:#fff;--mdc-slider-with-tick-marks-disabled-container-color:#000;--mat-slider-ripple-color:#673ab7;--mat-slider-hover-state-layer-color:rgba(103, 58, 183, .05);--mat-slider-focus-state-layer-color:rgba(103, 58, 183, .2);--mat-slider-value-indicator-opacity:.6}html{--mdc-slider-label-label-text-font:Roboto, sans-serif;--mdc-slider-label-label-text-size:14px;--mdc-slider-label-label-text-line-height:22px;--mdc-slider-label-label-text-tracking:.0071428571em;--mdc-slider-label-label-text-weight:500}html{--mat-menu-container-shape:4px;--mat-menu-divider-bottom-spacing:0;--mat-menu-divider-top-spacing:0;--mat-menu-item-spacing:16px;--mat-menu-item-icon-size:24px;--mat-menu-item-leading-spacing:16px;--mat-menu-item-trailing-spacing:16px;--mat-menu-item-with-icon-leading-spacing:16px;--mat-menu-item-with-icon-trailing-spacing:16px;--mat-menu-base-elevation-level:8}html{--mat-menu-item-label-text-color:rgba(0, 0, 0, .87);--mat-menu-item-icon-color:rgba(0, 0, 0, .87);--mat-menu-item-hover-state-layer-color:rgba(0, 0, 0, .04);--mat-menu-item-focus-state-layer-color:rgba(0, 0, 0, .04);--mat-menu-container-color:white;--mat-menu-divider-color:rgba(0, 0, 0, .12)}html{--mat-menu-item-label-text-font:Roboto, sans-serif;--mat-menu-item-label-text-size:16px;--mat-menu-item-label-text-tracking:.03125em;--mat-menu-item-label-text-line-height:24px;--mat-menu-item-label-text-weight:400}html{--mdc-list-list-item-container-shape:0;--mdc-list-list-item-leading-avatar-shape:50%;--mdc-list-list-item-container-color:transparent;--mdc-list-list-item-selected-container-color:transparent;--mdc-list-list-item-leading-avatar-color:transparent;--mdc-list-list-item-leading-icon-size:24px;--mdc-list-list-item-leading-avatar-size:40px;--mdc-list-list-item-trailing-icon-size:24px;--mdc-list-list-item-disabled-state-layer-color:transparent;--mdc-list-list-item-disabled-state-layer-opacity:0;--mdc-list-list-item-disabled-label-text-opacity:.38;--mdc-list-list-item-disabled-leading-icon-opacity:.38;--mdc-list-list-item-disabled-trailing-icon-opacity:.38;--mat-list-active-indicator-color:transparent;--mat-list-active-indicator-shape:4px}html{--mdc-list-list-item-label-text-color:rgba(0, 0, 0, .87);--mdc-list-list-item-supporting-text-color:rgba(0, 0, 0, .54);--mdc-list-list-item-leading-icon-color:rgba(0, 0, 0, .38);--mdc-list-list-item-trailing-supporting-text-color:rgba(0, 0, 0, .38);--mdc-list-list-item-trailing-icon-color:rgba(0, 0, 0, .38);--mdc-list-list-item-selected-trailing-icon-color:rgba(0, 0, 0, .38);--mdc-list-list-item-disabled-label-text-color:black;--mdc-list-list-item-disabled-leading-icon-color:black;--mdc-list-list-item-disabled-trailing-icon-color:black;--mdc-list-list-item-hover-label-text-color:rgba(0, 0, 0, .87);--mdc-list-list-item-hover-leading-icon-color:rgba(0, 0, 0, .38);--mdc-list-list-item-hover-trailing-icon-color:rgba(0, 0, 0, .38);--mdc-list-list-item-focus-label-text-color:rgba(0, 0, 0, .87);--mdc-list-list-item-hover-state-layer-color:black;--mdc-list-list-item-hover-state-layer-opacity:.04;--mdc-list-list-item-focus-state-layer-color:black;--mdc-list-list-item-focus-state-layer-opacity:.12}html{--mdc-list-list-item-one-line-container-height:48px;--mdc-list-list-item-two-line-container-height:64px;--mdc-list-list-item-three-line-container-height:88px;--mat-list-list-item-leading-icon-start-space:16px;--mat-list-list-item-leading-icon-end-space:32px}html{--mdc-list-list-item-label-text-font:Roboto, sans-serif;--mdc-list-list-item-label-text-line-height:24px;--mdc-list-list-item-label-text-size:16px;--mdc-list-list-item-label-text-tracking:.03125em;--mdc-list-list-item-label-text-weight:400;--mdc-list-list-item-supporting-text-font:Roboto, sans-serif;--mdc-list-list-item-supporting-text-line-height:20px;--mdc-list-list-item-supporting-text-size:14px;--mdc-list-list-item-supporting-text-tracking:.0178571429em;--mdc-list-list-item-supporting-text-weight:400;--mdc-list-list-item-trailing-supporting-text-font:Roboto, sans-serif;--mdc-list-list-item-trailing-supporting-text-line-height:20px;--mdc-list-list-item-trailing-supporting-text-size:12px;--mdc-list-list-item-trailing-supporting-text-tracking:.0333333333em;--mdc-list-list-item-trailing-supporting-text-weight:400}html{--mat-paginator-container-text-color:rgba(0, 0, 0, .87);--mat-paginator-container-background-color:white;--mat-paginator-enabled-icon-color:rgba(0, 0, 0, .54);--mat-paginator-disabled-icon-color:rgba(0, 0, 0, .12)}html{--mat-paginator-container-size:56px;--mat-paginator-form-field-container-height:40px;--mat-paginator-form-field-container-vertical-padding:8px;--mat-paginator-touch-target-display:block}html{--mat-paginator-container-text-font:Roboto, sans-serif;--mat-paginator-container-text-line-height:20px;--mat-paginator-container-text-size:12px;--mat-paginator-container-text-tracking:.0333333333em;--mat-paginator-container-text-weight:400;--mat-paginator-select-trigger-text-size:12px}html{--mdc-secondary-navigation-tab-container-height:48px;--mdc-tab-indicator-active-indicator-height:2px;--mdc-tab-indicator-active-indicator-shape:0;--mat-tab-header-divider-color:transparent;--mat-tab-header-divider-height:0}html{--mdc-checkbox-disabled-selected-checkmark-color:#fff;--mdc-checkbox-selected-focus-state-layer-opacity:.16;--mdc-checkbox-selected-hover-state-layer-opacity:.04;--mdc-checkbox-selected-pressed-state-layer-opacity:.16;--mdc-checkbox-unselected-focus-state-layer-opacity:.16;--mdc-checkbox-unselected-hover-state-layer-opacity:.04;--mdc-checkbox-unselected-pressed-state-layer-opacity:.16}html{--mdc-checkbox-disabled-selected-icon-color:rgba(0, 0, 0, .38);--mdc-checkbox-disabled-unselected-icon-color:rgba(0, 0, 0, .38);--mdc-checkbox-selected-checkmark-color:black;--mdc-checkbox-selected-focus-icon-color:#ffd740;--mdc-checkbox-selected-hover-icon-color:#ffd740;--mdc-checkbox-selected-icon-color:#ffd740;--mdc-checkbox-selected-pressed-icon-color:#ffd740;--mdc-checkbox-unselected-focus-icon-color:#212121;--mdc-checkbox-unselected-hover-icon-color:#212121;--mdc-checkbox-unselected-icon-color:rgba(0, 0, 0, .54);--mdc-checkbox-selected-focus-state-layer-color:#ffd740;--mdc-checkbox-selected-hover-state-layer-color:#ffd740;--mdc-checkbox-selected-pressed-state-layer-color:#ffd740;--mdc-checkbox-unselected-focus-state-layer-color:black;--mdc-checkbox-unselected-hover-state-layer-color:black;--mdc-checkbox-unselected-pressed-state-layer-color:black;--mat-checkbox-disabled-label-color:rgba(0, 0, 0, .38);--mat-checkbox-label-text-color:rgba(0, 0, 0, .87)}html{--mdc-checkbox-state-layer-size:40px;--mat-checkbox-touch-target-display:block}html{--mat-checkbox-label-text-font:Roboto, sans-serif;--mat-checkbox-label-text-line-height:20px;--mat-checkbox-label-text-size:14px;--mat-checkbox-label-text-tracking:.0178571429em;--mat-checkbox-label-text-weight:400}html{--mdc-text-button-container-shape:4px;--mdc-text-button-keep-touch-target:false;--mdc-filled-button-container-shape:4px;--mdc-filled-button-keep-touch-target:false;--mdc-protected-button-container-shape:4px;--mdc-protected-button-container-elevation-shadow:0px 3px 1px -2px rgba(0, 0, 0, .2), 0px 2px 2px 0px rgba(0, 0, 0, .14), 0px 1px 5px 0px rgba(0, 0, 0, .12);--mdc-protected-button-disabled-container-elevation-shadow:0px 0px 0px 0px rgba(0, 0, 0, .2), 0px 0px 0px 0px rgba(0, 0, 0, .14), 0px 0px 0px 0px rgba(0, 0, 0, .12);--mdc-protected-button-focus-container-elevation-shadow:0px 2px 4px -1px rgba(0, 0, 0, .2), 0px 4px 5px 0px rgba(0, 0, 0, .14), 0px 1px 10px 0px rgba(0, 0, 0, .12);--mdc-protected-button-hover-container-elevation-shadow:0px 2px 4px -1px rgba(0, 0, 0, .2), 0px 4px 5px 0px rgba(0, 0, 0, .14), 0px 1px 10px 0px rgba(0, 0, 0, .12);--mdc-protected-button-pressed-container-elevation-shadow:0px 5px 5px -3px rgba(0, 0, 0, .2), 0px 8px 10px 1px rgba(0, 0, 0, .14), 0px 3px 14px 2px rgba(0, 0, 0, .12);--mdc-outlined-button-keep-touch-target:false;--mdc-outlined-button-outline-width:1px;--mdc-outlined-button-container-shape:4px;--mat-text-button-horizontal-padding:8px;--mat-text-button-with-icon-horizontal-padding:8px;--mat-text-button-icon-spacing:8px;--mat-text-button-icon-offset:0;--mat-filled-button-horizontal-padding:16px;--mat-filled-button-icon-spacing:8px;--mat-filled-button-icon-offset:-4px;--mat-protected-button-horizontal-padding:16px;--mat-protected-button-icon-spacing:8px;--mat-protected-button-icon-offset:-4px;--mat-outlined-button-horizontal-padding:15px;--mat-outlined-button-icon-spacing:8px;--mat-outlined-button-icon-offset:-4px}html{--mdc-text-button-label-text-color:black;--mdc-text-button-disabled-label-text-color:rgba(0, 0, 0, .38);--mat-text-button-state-layer-color:black;--mat-text-button-disabled-state-layer-color:black;--mat-text-button-ripple-color:rgba(0, 0, 0, .1);--mat-text-button-hover-state-layer-opacity:.04;--mat-text-button-focus-state-layer-opacity:.12;--mat-text-button-pressed-state-layer-opacity:.12;--mdc-filled-button-container-color:white;--mdc-filled-button-label-text-color:black;--mdc-filled-button-disabled-container-color:rgba(0, 0, 0, .12);--mdc-filled-button-disabled-label-text-color:rgba(0, 0, 0, .38);--mat-filled-button-state-layer-color:black;--mat-filled-button-disabled-state-layer-color:black;--mat-filled-button-ripple-color:rgba(0, 0, 0, .1);--mat-filled-button-hover-state-layer-opacity:.04;--mat-filled-button-focus-state-layer-opacity:.12;--mat-filled-button-pressed-state-layer-opacity:.12;--mdc-protected-button-container-color:white;--mdc-protected-button-label-text-color:black;--mdc-protected-button-disabled-container-color:rgba(0, 0, 0, .12);--mdc-protected-button-disabled-label-text-color:rgba(0, 0, 0, .38);--mat-protected-button-state-layer-color:black;--mat-protected-button-disabled-state-layer-color:black;--mat-protected-button-ripple-color:rgba(0, 0, 0, .1);--mat-protected-button-hover-state-layer-opacity:.04;--mat-protected-button-focus-state-layer-opacity:.12;--mat-protected-button-pressed-state-layer-opacity:.12;--mdc-outlined-button-disabled-outline-color:rgba(0, 0, 0, .12);--mdc-outlined-button-disabled-label-text-color:rgba(0, 0, 0, .38);--mdc-outlined-button-label-text-color:black;--mdc-outlined-button-outline-color:rgba(0, 0, 0, .12);--mat-outlined-button-state-layer-color:black;--mat-outlined-button-disabled-state-layer-color:black;--mat-outlined-button-ripple-color:rgba(0, 0, 0, .1);--mat-outlined-button-hover-state-layer-opacity:.04;--mat-outlined-button-focus-state-layer-opacity:.12;--mat-outlined-button-pressed-state-layer-opacity:.12}html{--mdc-text-button-container-height:36px;--mdc-filled-button-container-height:36px;--mdc-protected-button-container-height:36px;--mdc-outlined-button-container-height:36px;--mat-text-button-touch-target-display:block;--mat-filled-button-touch-target-display:block;--mat-protected-button-touch-target-display:block;--mat-outlined-button-touch-target-display:block}html{--mdc-text-button-label-text-font:Roboto, sans-serif;--mdc-text-button-label-text-size:14px;--mdc-text-button-label-text-tracking:.0892857143em;--mdc-text-button-label-text-weight:500;--mdc-text-button-label-text-transform:none;--mdc-filled-button-label-text-font:Roboto, sans-serif;--mdc-filled-button-label-text-size:14px;--mdc-filled-button-label-text-tracking:.0892857143em;--mdc-filled-button-label-text-weight:500;--mdc-filled-button-label-text-transform:none;--mdc-protected-button-label-text-font:Roboto, sans-serif;--mdc-protected-button-label-text-size:14px;--mdc-protected-button-label-text-tracking:.0892857143em;--mdc-protected-button-label-text-weight:500;--mdc-protected-button-label-text-transform:none;--mdc-outlined-button-label-text-font:Roboto, sans-serif;--mdc-outlined-button-label-text-size:14px;--mdc-outlined-button-label-text-tracking:.0892857143em;--mdc-outlined-button-label-text-weight:500;--mdc-outlined-button-label-text-transform:none}html{--mdc-icon-button-icon-size:24px}html{--mdc-icon-button-icon-color:inherit;--mdc-icon-button-disabled-icon-color:rgba(0, 0, 0, .38);--mat-icon-button-state-layer-color:black;--mat-icon-button-disabled-state-layer-color:black;--mat-icon-button-ripple-color:rgba(0, 0, 0, .1);--mat-icon-button-hover-state-layer-opacity:.04;--mat-icon-button-focus-state-layer-opacity:.12;--mat-icon-button-pressed-state-layer-opacity:.12}html{--mat-icon-button-touch-target-display:block}html{--mdc-fab-container-shape:50%;--mdc-fab-container-elevation-shadow:0px 3px 5px -1px rgba(0, 0, 0, .2), 0px 6px 10px 0px rgba(0, 0, 0, .14), 0px 1px 18px 0px rgba(0, 0, 0, .12);--mdc-fab-focus-container-elevation-shadow:0px 5px 5px -3px rgba(0, 0, 0, .2), 0px 8px 10px 1px rgba(0, 0, 0, .14), 0px 3px 14px 2px rgba(0, 0, 0, .12);--mdc-fab-hover-container-elevation-shadow:0px 5px 5px -3px rgba(0, 0, 0, .2), 0px 8px 10px 1px rgba(0, 0, 0, .14), 0px 3px 14px 2px rgba(0, 0, 0, .12);--mdc-fab-pressed-container-elevation-shadow:0px 7px 8px -4px rgba(0, 0, 0, .2), 0px 12px 17px 2px rgba(0, 0, 0, .14), 0px 5px 22px 4px rgba(0, 0, 0, .12);--mdc-fab-small-container-shape:50%;--mdc-fab-small-container-elevation-shadow:0px 3px 5px -1px rgba(0, 0, 0, .2), 0px 6px 10px 0px rgba(0, 0, 0, .14), 0px 1px 18px 0px rgba(0, 0, 0, .12);--mdc-fab-small-focus-container-elevation-shadow:0px 5px 5px -3px rgba(0, 0, 0, .2), 0px 8px 10px 1px rgba(0, 0, 0, .14), 0px 3px 14px 2px rgba(0, 0, 0, .12);--mdc-fab-small-hover-container-elevation-shadow:0px 5px 5px -3px rgba(0, 0, 0, .2), 0px 8px 10px 1px rgba(0, 0, 0, .14), 0px 3px 14px 2px rgba(0, 0, 0, .12);--mdc-fab-small-pressed-container-elevation-shadow:0px 7px 8px -4px rgba(0, 0, 0, .2), 0px 12px 17px 2px rgba(0, 0, 0, .14), 0px 5px 22px 4px rgba(0, 0, 0, .12);--mdc-extended-fab-container-height:48px;--mdc-extended-fab-container-shape:24px;--mdc-extended-fab-container-elevation-shadow:0px 3px 5px -1px rgba(0, 0, 0, .2), 0px 6px 10px 0px rgba(0, 0, 0, .14), 0px 1px 18px 0px rgba(0, 0, 0, .12);--mdc-extended-fab-focus-container-elevation-shadow:0px 5px 5px -3px rgba(0, 0, 0, .2), 0px 8px 10px 1px rgba(0, 0, 0, .14), 0px 3px 14px 2px rgba(0, 0, 0, .12);--mdc-extended-fab-hover-container-elevation-shadow:0px 5px 5px -3px rgba(0, 0, 0, .2), 0px 8px 10px 1px rgba(0, 0, 0, .14), 0px 3px 14px 2px rgba(0, 0, 0, .12);--mdc-extended-fab-pressed-container-elevation-shadow:0px 7px 8px -4px rgba(0, 0, 0, .2), 0px 12px 17px 2px rgba(0, 0, 0, .14), 0px 5px 22px 4px rgba(0, 0, 0, .12)}html{--mdc-fab-container-color:white;--mat-fab-foreground-color:black;--mat-fab-state-layer-color:black;--mat-fab-disabled-state-layer-color:black;--mat-fab-ripple-color:rgba(0, 0, 0, .1);--mat-fab-hover-state-layer-opacity:.04;--mat-fab-focus-state-layer-opacity:.12;--mat-fab-pressed-state-layer-opacity:.12;--mat-fab-disabled-state-container-color:rgba(0, 0, 0, .12);--mat-fab-disabled-state-foreground-color:rgba(0, 0, 0, .38);--mdc-fab-small-container-color:white;--mat-fab-small-foreground-color:black;--mat-fab-small-state-layer-color:black;--mat-fab-small-disabled-state-layer-color:black;--mat-fab-small-ripple-color:rgba(0, 0, 0, .1);--mat-fab-small-hover-state-layer-opacity:.04;--mat-fab-small-focus-state-layer-opacity:.12;--mat-fab-small-pressed-state-layer-opacity:.12;--mat-fab-small-disabled-state-container-color:rgba(0, 0, 0, .12);--mat-fab-small-disabled-state-foreground-color:rgba(0, 0, 0, .38)}html{--mat-fab-touch-target-display:block;--mat-fab-small-touch-target-display:block}html{--mdc-extended-fab-label-text-font:Roboto, sans-serif;--mdc-extended-fab-label-text-size:14px;--mdc-extended-fab-label-text-tracking:.0892857143em;--mdc-extended-fab-label-text-weight:500}html{--mdc-snackbar-container-shape:4px}html{--mdc-snackbar-container-color:#333333;--mdc-snackbar-supporting-text-color:rgba(255, 255, 255, .87);--mat-snack-bar-button-color:#ffd740}html{--mdc-snackbar-supporting-text-font:Roboto, sans-serif;--mdc-snackbar-supporting-text-line-height:20px;--mdc-snackbar-supporting-text-size:14px;--mdc-snackbar-supporting-text-weight:400}html{--mat-table-row-item-outline-width:1px}html{--mat-table-background-color:white;--mat-table-header-headline-color:rgba(0, 0, 0, .87);--mat-table-row-item-label-text-color:rgba(0, 0, 0, .87);--mat-table-row-item-outline-color:rgba(0, 0, 0, .12)}html{--mat-table-header-container-height:56px;--mat-table-footer-container-height:52px;--mat-table-row-item-container-height:52px}html{--mat-table-header-headline-font:Roboto, sans-serif;--mat-table-header-headline-line-height:22px;--mat-table-header-headline-size:14px;--mat-table-header-headline-weight:500;--mat-table-header-headline-tracking:.0071428571em;--mat-table-row-item-label-text-font:Roboto, sans-serif;--mat-table-row-item-label-text-line-height:20px;--mat-table-row-item-label-text-size:14px;--mat-table-row-item-label-text-weight:400;--mat-table-row-item-label-text-tracking:.0178571429em;--mat-table-footer-supporting-text-font:Roboto, sans-serif;--mat-table-footer-supporting-text-line-height:20px;--mat-table-footer-supporting-text-size:14px;--mat-table-footer-supporting-text-weight:400;--mat-table-footer-supporting-text-tracking:.0178571429em}html{--mdc-circular-progress-active-indicator-width:4px;--mdc-circular-progress-size:48px}html{--mdc-circular-progress-active-indicator-color:#673ab7}html{--mat-badge-container-shape:50%;--mat-badge-container-size:unset;--mat-badge-small-size-container-size:unset;--mat-badge-large-size-container-size:unset;--mat-badge-legacy-container-size:22px;--mat-badge-legacy-small-size-container-size:16px;--mat-badge-legacy-large-size-container-size:28px;--mat-badge-container-offset:-11px 0;--mat-badge-small-size-container-offset:-8px 0;--mat-badge-large-size-container-offset:-14px 0;--mat-badge-container-overlap-offset:-11px;--mat-badge-small-size-container-overlap-offset:-8px;--mat-badge-large-size-container-overlap-offset:-14px;--mat-badge-container-padding:0;--mat-badge-small-size-container-padding:0;--mat-badge-large-size-container-padding:0}html{--mat-badge-background-color:#673ab7;--mat-badge-text-color:white;--mat-badge-disabled-state-background-color:#b9b9b9;--mat-badge-disabled-state-text-color:rgba(0, 0, 0, .38)}html{--mat-badge-text-font:Roboto, sans-serif;--mat-badge-line-height:22px;--mat-badge-text-size:12px;--mat-badge-text-weight:600;--mat-badge-small-size-text-size:9px;--mat-badge-small-size-line-height:16px;--mat-badge-large-size-text-size:24px;--mat-badge-large-size-line-height:28px}html{--mat-bottom-sheet-container-shape:4px}html{--mat-bottom-sheet-container-text-color:rgba(0, 0, 0, .87);--mat-bottom-sheet-container-background-color:white}html{--mat-bottom-sheet-container-text-font:Roboto, sans-serif;--mat-bottom-sheet-container-text-line-height:20px;--mat-bottom-sheet-container-text-size:14px;--mat-bottom-sheet-container-text-tracking:.0178571429em;--mat-bottom-sheet-container-text-weight:400}html{--mat-legacy-button-toggle-height:36px;--mat-legacy-button-toggle-shape:2px;--mat-legacy-button-toggle-focus-state-layer-opacity:1;--mat-standard-button-toggle-shape:4px;--mat-standard-button-toggle-hover-state-layer-opacity:.04;--mat-standard-button-toggle-focus-state-layer-opacity:.12}html{--mat-legacy-button-toggle-text-color:rgba(0, 0, 0, .38);--mat-legacy-button-toggle-state-layer-color:rgba(0, 0, 0, .12);--mat-legacy-button-toggle-selected-state-text-color:rgba(0, 0, 0, .54);--mat-legacy-button-toggle-selected-state-background-color:#e0e0e0;--mat-legacy-button-toggle-disabled-state-text-color:rgba(0, 0, 0, .26);--mat-legacy-button-toggle-disabled-state-background-color:#eeeeee;--mat-legacy-button-toggle-disabled-selected-state-background-color:#bdbdbd;--mat-standard-button-toggle-text-color:rgba(0, 0, 0, .87);--mat-standard-button-toggle-background-color:white;--mat-standard-button-toggle-state-layer-color:black;--mat-standard-button-toggle-selected-state-background-color:#e0e0e0;--mat-standard-button-toggle-selected-state-text-color:rgba(0, 0, 0, .87);--mat-standard-button-toggle-disabled-state-text-color:rgba(0, 0, 0, .26);--mat-standard-button-toggle-disabled-state-background-color:white;--mat-standard-button-toggle-disabled-selected-state-text-color:rgba(0, 0, 0, .87);--mat-standard-button-toggle-disabled-selected-state-background-color:#bdbdbd;--mat-standard-button-toggle-divider-color:#e0e0e0}html{--mat-standard-button-toggle-height:48px}html{--mat-legacy-button-toggle-label-text-font:Roboto, sans-serif;--mat-legacy-button-toggle-label-text-line-height:24px;--mat-legacy-button-toggle-label-text-size:16px;--mat-legacy-button-toggle-label-text-tracking:.03125em;--mat-legacy-button-toggle-label-text-weight:400;--mat-standard-button-toggle-label-text-font:Roboto, sans-serif;--mat-standard-button-toggle-label-text-line-height:24px;--mat-standard-button-toggle-label-text-size:16px;--mat-standard-button-toggle-label-text-tracking:.03125em;--mat-standard-button-toggle-label-text-weight:400}html{--mat-datepicker-calendar-container-shape:4px;--mat-datepicker-calendar-container-touch-shape:4px;--mat-datepicker-calendar-container-elevation-shadow:0px 2px 4px -1px rgba(0, 0, 0, .2), 0px 4px 5px 0px rgba(0, 0, 0, .14), 0px 1px 10px 0px rgba(0, 0, 0, .12);--mat-datepicker-calendar-container-touch-elevation-shadow:0px 11px 15px -7px rgba(0, 0, 0, .2), 0px 24px 38px 3px rgba(0, 0, 0, .14), 0px 9px 46px 8px rgba(0, 0, 0, .12)}html{--mat-datepicker-calendar-date-selected-state-text-color:white;--mat-datepicker-calendar-date-selected-state-background-color:#673ab7;--mat-datepicker-calendar-date-selected-disabled-state-background-color:rgba(103, 58, 183, .4);--mat-datepicker-calendar-date-today-selected-state-outline-color:white;--mat-datepicker-calendar-date-focus-state-background-color:rgba(103, 58, 183, .3);--mat-datepicker-calendar-date-hover-state-background-color:rgba(103, 58, 183, .3);--mat-datepicker-toggle-active-state-icon-color:#673ab7;--mat-datepicker-calendar-date-in-range-state-background-color:rgba(103, 58, 183, .2);--mat-datepicker-calendar-date-in-comparison-range-state-background-color:rgba(249, 171, 0, .2);--mat-datepicker-calendar-date-in-overlap-range-state-background-color:#a8dab5;--mat-datepicker-calendar-date-in-overlap-range-selected-state-background-color:#46a35e;--mat-datepicker-toggle-icon-color:rgba(0, 0, 0, .54);--mat-datepicker-calendar-body-label-text-color:rgba(0, 0, 0, .54);--mat-datepicker-calendar-period-button-text-color:black;--mat-datepicker-calendar-period-button-icon-color:rgba(0, 0, 0, .54);--mat-datepicker-calendar-navigation-button-icon-color:rgba(0, 0, 0, .54);--mat-datepicker-calendar-header-divider-color:rgba(0, 0, 0, .12);--mat-datepicker-calendar-header-text-color:rgba(0, 0, 0, .54);--mat-datepicker-calendar-date-today-outline-color:rgba(0, 0, 0, .38);--mat-datepicker-calendar-date-today-disabled-state-outline-color:rgba(0, 0, 0, .18);--mat-datepicker-calendar-date-text-color:rgba(0, 0, 0, .87);--mat-datepicker-calendar-date-outline-color:transparent;--mat-datepicker-calendar-date-disabled-state-text-color:rgba(0, 0, 0, .38);--mat-datepicker-calendar-date-preview-state-outline-color:rgba(0, 0, 0, .24);--mat-datepicker-range-input-separator-color:rgba(0, 0, 0, .87);--mat-datepicker-range-input-disabled-state-separator-color:rgba(0, 0, 0, .38);--mat-datepicker-range-input-disabled-state-text-color:rgba(0, 0, 0, .38);--mat-datepicker-calendar-container-background-color:white;--mat-datepicker-calendar-container-text-color:rgba(0, 0, 0, .87)}html{--mat-datepicker-calendar-text-font:Roboto, sans-serif;--mat-datepicker-calendar-text-size:13px;--mat-datepicker-calendar-body-label-text-size:14px;--mat-datepicker-calendar-body-label-text-weight:500;--mat-datepicker-calendar-period-button-text-size:14px;--mat-datepicker-calendar-period-button-text-weight:500;--mat-datepicker-calendar-header-text-size:11px;--mat-datepicker-calendar-header-text-weight:400}html{--mat-divider-width:1px}html{--mat-divider-color:rgba(0, 0, 0, .12)}html{--mat-expansion-container-shape:4px;--mat-expansion-legacy-header-indicator-display:inline-block;--mat-expansion-header-indicator-display:none}html{--mat-expansion-container-background-color:white;--mat-expansion-container-text-color:rgba(0, 0, 0, .87);--mat-expansion-actions-divider-color:rgba(0, 0, 0, .12);--mat-expansion-header-hover-state-layer-color:rgba(0, 0, 0, .04);--mat-expansion-header-focus-state-layer-color:rgba(0, 0, 0, .04);--mat-expansion-header-disabled-state-text-color:rgba(0, 0, 0, .26);--mat-expansion-header-text-color:rgba(0, 0, 0, .87);--mat-expansion-header-description-color:rgba(0, 0, 0, .54);--mat-expansion-header-indicator-color:rgba(0, 0, 0, .54)}html{--mat-expansion-header-collapsed-state-height:48px;--mat-expansion-header-expanded-state-height:64px}html{--mat-expansion-header-text-font:Roboto, sans-serif;--mat-expansion-header-text-size:14px;--mat-expansion-header-text-weight:500;--mat-expansion-header-text-line-height:inherit;--mat-expansion-header-text-tracking:inherit;--mat-expansion-container-text-font:Roboto, sans-serif;--mat-expansion-container-text-line-height:20px;--mat-expansion-container-text-size:14px;--mat-expansion-container-text-tracking:.0178571429em;--mat-expansion-container-text-weight:400}html{--mat-grid-list-tile-header-primary-text-size:14px;--mat-grid-list-tile-header-secondary-text-size:12px;--mat-grid-list-tile-footer-primary-text-size:14px;--mat-grid-list-tile-footer-secondary-text-size:12px}html{--mat-icon-color:inherit}html{--mat-sidenav-container-shape:0;--mat-sidenav-container-elevation-shadow:0px 8px 10px -5px rgba(0, 0, 0, .2), 0px 16px 24px 2px rgba(0, 0, 0, .14), 0px 6px 30px 5px rgba(0, 0, 0, .12);--mat-sidenav-container-width:auto}html{--mat-sidenav-container-divider-color:rgba(0, 0, 0, .12);--mat-sidenav-container-background-color:white;--mat-sidenav-container-text-color:rgba(0, 0, 0, .87);--mat-sidenav-content-background-color:#fafafa;--mat-sidenav-content-text-color:rgba(0, 0, 0, .87);--mat-sidenav-scrim-color:rgba(0, 0, 0, .6)}html{--mat-stepper-header-icon-foreground-color:white;--mat-stepper-header-selected-state-icon-background-color:#673ab7;--mat-stepper-header-selected-state-icon-foreground-color:white;--mat-stepper-header-done-state-icon-background-color:#673ab7;--mat-stepper-header-done-state-icon-foreground-color:white;--mat-stepper-header-edit-state-icon-background-color:#673ab7;--mat-stepper-header-edit-state-icon-foreground-color:white;--mat-stepper-container-color:white;--mat-stepper-line-color:rgba(0, 0, 0, .12);--mat-stepper-header-hover-state-layer-color:rgba(0, 0, 0, .04);--mat-stepper-header-focus-state-layer-color:rgba(0, 0, 0, .04);--mat-stepper-header-label-text-color:rgba(0, 0, 0, .54);--mat-stepper-header-optional-label-text-color:rgba(0, 0, 0, .54);--mat-stepper-header-selected-state-label-text-color:rgba(0, 0, 0, .87);--mat-stepper-header-error-state-label-text-color:#f44336;--mat-stepper-header-icon-background-color:rgba(0, 0, 0, .54);--mat-stepper-header-error-state-icon-foreground-color:#f44336;--mat-stepper-header-error-state-icon-background-color:transparent}html{--mat-stepper-header-height:72px}html{--mat-stepper-container-text-font:Roboto, sans-serif;--mat-stepper-header-label-text-font:Roboto, sans-serif;--mat-stepper-header-label-text-size:14px;--mat-stepper-header-label-text-weight:400;--mat-stepper-header-error-state-label-text-size:16px;--mat-stepper-header-selected-state-label-text-size:16px;--mat-stepper-header-selected-state-label-text-weight:400}html{--mat-sort-arrow-color:#757575}html{--mat-toolbar-container-background-color:whitesmoke;--mat-toolbar-container-text-color:rgba(0, 0, 0, .87)}html{--mat-toolbar-standard-height:64px;--mat-toolbar-mobile-height:56px}html{--mat-toolbar-title-text-font:Roboto, sans-serif;--mat-toolbar-title-text-line-height:32px;--mat-toolbar-title-text-size:20px;--mat-toolbar-title-text-tracking:.0125em;--mat-toolbar-title-text-weight:500}html{--mat-tree-container-background-color:white;--mat-tree-node-text-color:rgba(0, 0, 0, .87)}html{--mat-tree-node-min-height:48px}html{--mat-tree-node-text-font:Roboto, sans-serif;--mat-tree-node-text-size:14px;--mat-tree-node-text-weight:400}</style><link rel="stylesheet" href="styles-IGF3ZLFK.css" media="print" onload="this.media='all'"><noscript><link rel="stylesheet" href="styles-IGF3ZLFK.css"></noscript></head>

<body>
  <app-root></app-root>
<link rel="modulepreload" href="chunk-M3FQE2TU.js"><link rel="modulepreload" href="chunk-4QK4XA5W.js"><link rel="modulepreload" href="chunk-EJJES6DV.js"><link rel="modulepreload" href="chunk-OQMHZKXL.js"><link rel="modulepreload" href="chunk-76ZU3FYW.js"><link rel="modulepreload" href="chunk-GRNAKYI3.js"><link rel="modulepreload" href="chunk-HUQBVWNM.js"><link rel="modulepreload" href="chunk-TWQQXMRX.js"><link rel="modulepreload" href="chunk-55PSAQTG.js"><link rel="modulepreload" href="chunk-6YQTVQAD.js"><script src="polyfills-MH2GNY63.js" type="module"></script><script src="main-DT6ANBPI.js" type="module"></script></body>
</html>
----------------------
----------------------
File: layout.blade.php
Content:
<!DOCTYPE html>
<html>
<head>
    <title>Laravel 8 CRUD Application </title>
</head>
<body>

<div class="container">
    @yield('content')
</div>

</body>
</html>

----------------------
----------------------
File: test.blade.php
Content:
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Page - Datai</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Roboto, Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: white;
        }
        .container {
            text-align: center;
            padding: 40px;
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            border: 1px solid rgba(255,255,255,0.2);
        }
        h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .status {
            font-size: 1.25rem;
            opacity: 0.9;
            margin-bottom: 2rem;
        }
        .checks {
            text-align: left;
            margin-top: 2rem;
        }
        .check-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 8px 0;
            padding: 10px 15px;
            background: rgba(255,255,255,0.1);
            border-radius: 8px;
        }
        .check-icon {
            width: 24px;
            height: 24px;
            background: #22c55e;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        .back-link {
            margin-top: 2rem;
            display: inline-block;
            padding: 12px 24px;
            background: rgba(255,255,255,0.2);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: background 0.2s;
        }
        .back-link:hover {
            background: rgba(255,255,255,0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>testing</h1>
        <div class="status">Laravel routing is working correctly!</div>
        
        <div class="checks">
            <div class="check-item">
                <span class="check-icon">✓</span>
                <span>Route /test bypasses Angular SPA</span>
            </div>
            <div class="check-item">
                <span class="check-icon">✓</span>
                <span>Blade view renders successfully</span>
            </div>
            <div class="check-item">
                <span class="check-icon">✓</span>
                <span>No auth middleware applied</span>
            </div>
        </div>
        
        <a href="/" class="back-link">← Back to Dashboard</a>
    </div>
</body>
</html>

----------------------
----------------------
File: boards\index.blade.php
Content:
@extends('layouts.boards')

@section('title', 'All Boards')

@section('content')
<div class="boards-container">
    {{-- Header --}}
    <div class="boards-header">
        <div class="boards-header-left">
            <h1 class="boards-title">
                <i class="fa fa-columns"></i>
                My Boards
            </h1>
            <p class="boards-subtitle">Manage your Kanban boards and projects</p>
        </div>
        
        @if(in_array('BOARDS_CREATE_BOARDS', $claims ?? []))
        <div class="boards-header-right">
            <button class="boards-btn boards-btn-primary" id="btn-create-board">
                <i class="fa fa-plus"></i>
                <span>Create Board</span>
            </button>
        </div>
        @endif
    </div>
    
    {{-- Boards Grid --}}
    <div class="boards-grid">
        @forelse($boards as $board)
            <div class="board-card" data-board-id="{{ $board->id }}">
                <div class="board-card-header" style="background: linear-gradient(135deg, {{ $board->color ?? '#6366f1' }}, {{ $board->color ?? '#8b5cf6' }}99);">
                    <div class="board-card-visibility">
                        <i class="fa fa-{{ $board->visibility === 'private' ? 'lock' : 'globe' }}"></i>
                        {{ ucfirst($board->visibility ?? 'public') }}
                    </div>
                </div>
                
                <div class="board-card-body">
                    <h3 class="board-card-title">{{ $board->name }}</h3>
                    @if($board->description)
                        <p class="board-card-description">{{ Str::limit($board->description, 100) }}</p>
                    @endif
                    
                    <div class="board-card-stats">
                        <span class="board-stat">
                            <i class="fa fa-columns"></i>
                            {{ $board->columns_count ?? 0 }} columns
                        </span>
                        <span class="board-stat">
                            <i class="fa fa-sticky-note"></i>
                            {{ $board->cards_count ?? 0 }} cards
                        </span>
                    </div>
                </div>
                
                <div class="board-card-footer">
                    <a href="{{ route('boards.view', $board->id) }}" class="boards-btn boards-btn-primary boards-btn-block">
                        <i class="fa fa-external-link-alt"></i>
                        Open Board
                    </a>
                </div>
            </div>
        @empty
            <div class="boards-empty-state">
                <div class="boards-empty-icon">
                    <i class="fa fa-th-large"></i>
                </div>
                <h3>No Boards Yet</h3>
                <p>Create your first board to start organizing your work</p>
                @if(in_array('BOARDS_CREATE_BOARDS', $claims ?? []))
                    <button class="boards-btn boards-btn-primary" id="btn-create-board-empty">
                        <i class="fa fa-plus"></i>
                        Create Your First Board
                    </button>
                @endif
            </div>
        @endforelse
    </div>
</div>

{{-- Create Board Modal --}}
<div class="boards-modal" id="create-board-modal">
    <div class="boards-modal-backdrop"></div>
    <div class="boards-modal-dialog">
        <div class="boards-modal-content">
            <div class="boards-modal-header">
                <h4 class="boards-modal-title">
                    <i class="fa fa-plus-circle"></i>
                    Create New Board
                </h4>
                <button class="boards-modal-close" data-dismiss="modal">&times;</button>
            </div>
            <div class="boards-modal-body">
                <form id="create-board-form">
                    <div class="boards-form-group">
                        <label for="board-name">Board Name *</label>
                        <input type="text" id="board-name" class="boards-input" placeholder="Enter board name..." required>
                    </div>
                    
                    <div class="boards-form-group">
                        <label for="board-description">Description</label>
                        <textarea id="board-description" class="boards-input" rows="3" placeholder="Optional description..."></textarea>
                    </div>
                    
                    <div class="boards-form-row">
                        <div class="boards-form-group">
                            <label for="board-color">Color</label>
                            <input type="color" id="board-color" class="boards-input boards-color-input" value="#6366f1">
                        </div>
                        
                        <div class="boards-form-group">
                            <label for="board-visibility">Visibility</label>
                            <select id="board-visibility" class="boards-input">
                                <option value="public">Public (Everyone)</option>
                                <option value="private">Private (Invite Only)</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="boards-modal-footer">
                <button class="boards-btn boards-btn-outline" data-dismiss="modal">Cancel</button>
                <button class="boards-btn boards-btn-primary" id="btn-submit-board">
                    <i class="fa fa-check"></i>
                    Create Board
                </button>
            </div>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script>
$(document).ready(function() {
    // Open create modal
    $('#btn-create-board, #btn-create-board-empty').on('click', function() {
        $('#create-board-modal').addClass('show');
    });
    
    // Close modal
    $('[data-dismiss="modal"], .boards-modal-backdrop').on('click', function() {
        $(this).closest('.boards-modal').removeClass('show');
    });
    
    // Submit new board
    $('#btn-submit-board').on('click', function() {
        const name = $('#board-name').val().trim();
        if (!name) {
            alert('Please enter a board name');
            return;
        }
        
        const data = {
            name: name,
            description: $('#board-description').val().trim(),
            color: $('#board-color').val(),
            visibility: $('#board-visibility').val()
        };
        
        $.ajax({
            url: BoardsConfig.apiUrl + '/boards',
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + BoardsConfig.authToken,
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': BoardsConfig.csrfToken
            },
            data: JSON.stringify(data),
            success: function(response) {
                window.location.href = '{{ route("boards.view", "") }}/' + response.id;
            },
            error: function(xhr) {
                alert('Error creating board: ' + (xhr.responseJSON?.message || 'Unknown error'));
            }
        });
    });
    
    // Open board on card click
    $('.board-card').on('click', function(e) {
        if ($(e.target).closest('.boards-btn').length) return;
        const boardId = $(this).data('board-id');
        window.location.href = '{{ route("boards.view", "") }}/' + boardId;
    });
});
</script>
@endpush

----------------------
----------------------
File: boards\view.blade.php
Content:
@extends('layouts.boards')

@section('title', $board->name)

@section('content')
<div class="kanban-container">
    {{-- Board Header --}}
    <div class="kanban-header">
        <div class="kanban-header-left">
            <a href="{{ route('boards.index') }}" class="boards-btn boards-btn-ghost">
                <i class="fa fa-arrow-left"></i>
            </a>
            <h1 class="kanban-title">{{ $board->name }}</h1>
            <span class="kanban-visibility-badge kanban-visibility-{{ $board->visibility ?? 'public' }}">
                <i class="fa fa-{{ ($board->visibility ?? 'public') === 'private' ? 'lock' : 'globe' }}"></i>
                {{ ucfirst($board->visibility ?? 'public') }}
            </span>
        </div>
        
        <div class="kanban-header-right">
            {{-- Labels --}}
            <div class="kanban-labels-preview">
                @foreach(($board->labels ?? collect())->take(5) as $label)
                    <span class="kanban-label-dot" style="background: {{ $label->color }}" title="{{ $label->name }}"></span>
                @endforeach
                @if(($board->labels ?? collect())->count() > 5)
                    <span class="kanban-label-more">+{{ ($board->labels ?? collect())->count() - 5 }}</span>
                @endif
            </div>
            
            @if($canEdit ?? false)
            <button class="boards-btn boards-btn-ghost" id="btn-board-settings">
                <i class="fa fa-cog"></i>
            </button>
            @endif
        </div>
    </div>
    
    {{-- Kanban Board --}}
    <div class="kanban-board" id="kanban-board" data-board-id="{{ $board->id }}">
        @foreach($board->columns as $column)
        <div class="kanban-column" data-column-id="{{ $column->id }}" style="{{ $column->color ? 'border-top: 3px solid ' . $column->color . ';' : '' }}">
            <div class="kanban-column-header">
                <h3 class="kanban-column-title">
                    {{ $column->name }}
                    <span class="kanban-column-count">{{ $column->cards->count() }}</span>
                </h3>
                <div class="kanban-column-actions">
                    <button class="kanban-column-menu-btn" data-column-id="{{ $column->id }}">
                        <i class="fa fa-ellipsis-v"></i>
                    </button>
                </div>
            </div>
            
            <div class="kanban-cards-container" data-column-id="{{ $column->id }}">
                @foreach($column->cards as $card)
                <div class="kanban-card" data-card-id="{{ $card->id }}">
                    {{-- Labels --}}
                    @if($card->labels && $card->labels->count() > 0)
                    <div class="kanban-card-labels">
                        @foreach($card->labels as $label)
                            <span class="kanban-card-label" style="background: {{ $label->color }}" title="{{ $label->name }}"></span>
                        @endforeach
                    </div>
                    @endif
                    
                    {{-- Title --}}
                    <div class="kanban-card-title">{{ $card->title }}</div>
                    
                    {{-- Footer --}}
                    <div class="kanban-card-footer">
                        {{-- Assignees --}}
                        <div class="kanban-card-assignees">
                            @foreach(($card->assignees ?? collect())->take(3) as $assignee)
                                @php $assigneeUser = $users->firstWhere('id', $assignee->user_id); @endphp
                                @if($assigneeUser)
                                    @if($assigneeUser->profilePhoto)
                                        <img src="{{ asset('uploads/photos/' . $assigneeUser->profilePhoto) }}" 
                                             alt="{{ $assigneeUser->firstName }}" 
                                             class="kanban-assignee-avatar" 
                                             title="{{ $assigneeUser->firstName }} {{ $assigneeUser->lastName }}">
                                    @else
                                        <div class="kanban-assignee-placeholder" title="{{ $assigneeUser->firstName }} {{ $assigneeUser->lastName }}">
                                            {{ strtoupper(substr($assigneeUser->firstName, 0, 1)) }}
                                        </div>
                                    @endif
                                @endif
                            @endforeach
                            @if(($card->assignees ?? collect())->count() > 3)
                                <span class="kanban-assignee-more">+{{ ($card->assignees ?? collect())->count() - 3 }}</span>
                            @endif
                        </div>
                        
                        {{-- Meta --}}
                        <div class="kanban-card-meta">
                            @if($card->due_date)
                                <span class="kanban-card-due {{ strtotime($card->due_date) < time() ? 'overdue' : '' }}">
                                    <i class="fa fa-calendar"></i>
                                    {{ \Carbon\Carbon::parse($card->due_date)->format('M d') }}
                                </span>
                            @endif
                            
                            {{-- Priority --}}
                            <span class="kanban-card-priority priority-{{ $card->priority ?? 'medium' }}"></span>
                        </div>
                    </div>
                </div>
                @endforeach
            </div>
            
            @if($canManageCards ?? true)
            <div class="kanban-add-card">
                <button class="kanban-add-card-btn" data-column-id="{{ $column->id }}">
                    <i class="fa fa-plus"></i>
                    Add Card
                </button>
            </div>
            @endif
        </div>
        @endforeach
        
        {{-- Add Column --}}
        @if($canEdit ?? false)
        <div class="kanban-add-column">
            <button class="kanban-add-column-btn" id="btn-add-column">
                <i class="fa fa-plus"></i>
                Add Column
            </button>
        </div>
        @endif
    </div>
</div>

{{-- Card Detail Modal --}}
<div class="boards-modal" id="card-detail-modal">
    <div class="boards-modal-backdrop"></div>
    <div class="boards-modal-dialog boards-modal-lg">
        <div class="boards-modal-content">
            <div class="boards-modal-header">
                <h4 class="boards-modal-title" id="card-detail-title">Card Details</h4>
                <button class="boards-modal-close" data-dismiss="modal">&times;</button>
            </div>
            <div class="boards-modal-body" id="card-detail-body">
                {{-- AJAX loaded content --}}
            </div>
        </div>
    </div>
</div>

{{-- Add Card Modal --}}
<div class="boards-modal" id="add-card-modal">
    <div class="boards-modal-backdrop"></div>
    <div class="boards-modal-dialog">
        <div class="boards-modal-content">
            <div class="boards-modal-header">
                <h4 class="boards-modal-title">
                    <i class="fa fa-plus-circle"></i>
                    Add New Card
                </h4>
                <button class="boards-modal-close" data-dismiss="modal">&times;</button>
            </div>
            <div class="boards-modal-body">
                <form id="add-card-form">
                    <input type="hidden" id="add-card-column-id">
                    <div class="boards-form-group">
                        <label for="card-title">Card Title *</label>
                        <input type="text" id="card-title" class="boards-input" placeholder="Enter card title..." required>
                    </div>
                    <div class="boards-form-group">
                        <label for="card-description">Description</label>
                        <textarea id="card-description" class="boards-input" rows="3" placeholder="Optional description..."></textarea>
                    </div>
                    <div class="boards-form-row">
                        <div class="boards-form-group">
                            <label for="card-priority">Priority</label>
                            <select id="card-priority" class="boards-input">
                                <option value="low">Low</option>
                                <option value="medium" selected>Medium</option>
                                <option value="high">High</option>
                                <option value="urgent">Urgent</option>
                            </select>
                        </div>
                        <div class="boards-form-group">
                            <label for="card-due-date">Due Date</label>
                            <input type="date" id="card-due-date" class="boards-input">
                        </div>
                    </div>
                </form>
            </div>
            <div class="boards-modal-footer">
                <button class="boards-btn boards-btn-outline" data-dismiss="modal">Cancel</button>
                <button class="boards-btn boards-btn-primary" id="btn-submit-card">
                    <i class="fa fa-check"></i>
                    Add Card
                </button>
            </div>
        </div>
    </div>
</div>

{{-- Add Column Modal --}}
<div class="boards-modal" id="add-column-modal">
    <div class="boards-modal-backdrop"></div>
    <div class="boards-modal-dialog boards-modal-sm">
        <div class="boards-modal-content">
            <div class="boards-modal-header">
                <h4 class="boards-modal-title">
                    <i class="fa fa-plus"></i>
                    Add Column
                </h4>
                <button class="boards-modal-close" data-dismiss="modal">&times;</button>
            </div>
            <div class="boards-modal-body">
                <div class="boards-form-group">
                    <label for="column-name">Column Name *</label>
                    <input type="text" id="column-name" class="boards-input" placeholder="e.g., To Do, In Progress..." required>
                </div>
                <div class="boards-form-group">
                    <label for="column-color">Color</label>
                    <input type="color" id="column-color" class="boards-input boards-color-input" value="#4a90e2">
                </div>
            </div>
            <div class="boards-modal-footer">
                <button class="boards-btn boards-btn-outline" data-dismiss="modal">Cancel</button>
                <button class="boards-btn boards-btn-primary" id="btn-submit-column">
                    <i class="fa fa-check"></i>
                    Add Column
                </button>
            </div>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script>
$(document).ready(function() {
    const boardId = '{{ $board->id }}';
    
    // Initialize SortableJS for cards
    document.querySelectorAll('.kanban-cards-container').forEach(container => {
        new Sortable(container, {
            group: 'kanban-cards',
            animation: 200,
            ghostClass: 'kanban-card-ghost',
            dragClass: 'kanban-card-drag',
            onEnd: function(evt) {
                const cardId = evt.item.dataset.cardId;
                const columnId = evt.to.dataset.columnId;
                const position = evt.newIndex;
                
                moveCard(cardId, columnId, position);
            }
        });
    });
    
    // Move card API
    function moveCard(cardId, columnId, position) {
        $.ajax({
            url: BoardsConfig.apiUrl + '/boards/' + boardId + '/cards/' + cardId + '/move',
            method: 'PUT',
            headers: {
                'Authorization': 'Bearer ' + BoardsConfig.authToken,
                'Content-Type': 'application/json'
            },
            data: JSON.stringify({
                column_id: columnId,
                card_order: position
            }),
            error: function(xhr) {
                console.error('Move failed:', xhr);
                location.reload();
            }
        });
    }
    
    // Open card detail
    $('.kanban-card').on('click', function() {
        const cardId = $(this).data('card-id');
        // Load card details via AJAX
        $('#card-detail-title').text($(this).find('.kanban-card-title').text());
        $('#card-detail-modal').addClass('show');
    });
    
    // Add card button
    $('.kanban-add-card-btn').on('click', function() {
        const columnId = $(this).data('column-id');
        $('#add-card-column-id').val(columnId);
        $('#add-card-modal').addClass('show');
        $('#card-title').focus();
    });
    
    // Submit new card
    $('#btn-submit-card').on('click', function() {
        const title = $('#card-title').val().trim();
        if (!title) {
            alert('Please enter a card title');
            return;
        }
        
        const columnId = $('#add-card-column-id').val();
        
        $.ajax({
            url: BoardsConfig.apiUrl + '/boards/' + boardId + '/cards',
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + BoardsConfig.authToken,
                'Content-Type': 'application/json'
            },
            data: JSON.stringify({
                column_id: columnId,
                title: title,
                description: $('#card-description').val().trim(),
                priority: $('#card-priority').val(),
                due_date: $('#card-due-date').val() || null
            }),
            success: function() {
                location.reload();
            },
            error: function(xhr) {
                alert('Error: ' + (xhr.responseJSON?.message || 'Failed to create card'));
            }
        });
    });
    
    // Add column button
    $('#btn-add-column').on('click', function() {
        $('#add-column-modal').addClass('show');
        $('#column-name').focus();
    });
    
    // Submit new column
    $('#btn-submit-column').on('click', function() {
        const name = $('#column-name').val().trim();
        if (!name) {
            alert('Please enter a column name');
            return;
        }
        
        $.ajax({
            url: BoardsConfig.apiUrl + '/boards/' + boardId + '/columns',
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + BoardsConfig.authToken,
                'Content-Type': 'application/json'
            },
            data: JSON.stringify({
                name: name,
                color: $('#column-color').val()
            }),
            success: function() {
                location.reload();
            },
            error: function(xhr) {
                alert('Error: ' + (xhr.responseJSON?.message || 'Failed to create column'));
            }
        });
    });
    
    // Close modals
    $('[data-dismiss="modal"], .boards-modal-backdrop').on('click', function() {
        $(this).closest('.boards-modal').removeClass('show');
    });
});
</script>
@endpush

----------------------
----------------------
File: boards\errors\unauthorized.blade.php
Content:
@extends('layouts.boards')

@section('title', 'Access Denied')

@section('content')
<div class="boards-error-container">
    <div class="boards-error-card">
        <div class="boards-error-icon">
            <i class="fa fa-exclamation-triangle"></i>
        </div>
        <h1 class="boards-error-title">Access Denied</h1>
        <p class="boards-error-message">{{ $message ?? 'You do not have permission to access this resource.' }}</p>
        <div class="boards-error-actions">
            <a href="{{ route('boards.index') }}" class="boards-btn boards-btn-outline">
                <i class="fa fa-arrow-left"></i>
                Back to Boards
            </a>
            <a href="/" class="boards-btn boards-btn-primary">
                <i class="fa fa-home"></i>
                Go to Dashboard
            </a>
        </div>
    </div>
</div>
@endsection

----------------------
----------------------
File: installer\finish.blade.php
Content:
@extends('layouts.installer')

@section('content')
<div class="p-3">
    <h4 class="mt-5 mb-8 text-center text-2xl font-semibold text-success-500">Installation Successfull</h4>

    <p class="text-neutral-700">
        <span class="font-semibold">{{ config('app.name') }} has been successfully installed</span>, now you need to
        set up a cron job:
    </p>

    <div class="mt-4 mb-3 block w-full rounded-md border border-neutral-300 bg-neutral-50 py-4 px-5 text-base shadow-sm">
        * * * * * <span class="select-all"> php {{ base_path() }}/artisan schedule:run
            >> /dev/null 2>&1</span>
    </div>

    <p class="mt-4 text-neutral-700">
        If you are not certain on how to configure the cron job with the minimum required PHP version
        ({{ config('installer.core.minPhpVersion') }}), the best is to consult with your hosting provider.
    </p>

    <p class="mt-4 text-neutral-700">
        On some <span class="font-medium">shared hostings you may need to specify full path</span> to the PHP executable
        (for example, <code class="select-all bg-danger-100 px-2">/usr/local/bin/php{{ str_replace('.', '', config('installer.core.minPhpVersion')) }}</code>
        or <code class="select-all bg-danger-100 px-2">/opt/alt/php{{ str_replace('.', '', config('installer.core.minPhpVersion')) }}/usr/bin/php</code>instead
        of <code class="bg-danger-100 px-2">php</code>), additionally, you can refer to our docs in order to read more about cron job configuration.
    </p>

    <h4 class="mt-5 mb-2 text-lg font-semibold text-neutral-800">Admin Credentials</h4>

    <p>
        <span class="font-semibold text-neutral-700">Email:</span> <span class="select-all">{{ $user->email }}</span><br />
        <span class="font-semibold text-neutral-700">Password:</span> <span>your chosen password</span>
    </p>
</div>

<div class="-m-7 mt-6 rounded-b border-t border-neutral-200 bg-neutral-50 p-4 text-right">
    <a href="{{ url('login') }}" target="_blank" rel="noopener noreferrer" class="inline-flex items-center rounded-md border border-transparent bg-primary-600 px-4 py-2 text-sm text-white shadow-sm focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2 hover:bg-primary-700">
        Login
    </a>
</div>

@endsection
----------------------
----------------------
File: installer\menu.blade.php
Content:
<nav>
    <ol class="border border-neutral-300 rounded-md divide-y divide-neutral-300 md:flex md:divide-y-0">

        <li class="relative md:flex-1 md:flex">
            <a href="#" class="pointer-events-none px-6 py-4 flex items-center text-sm font-medium">
                <span
                    class="shrink-0 w-10 h-10 flex items-center justify-center rounded-full {{ $step == 1 ? 'border-2 border-primary-600' : 'bg-primary-600' }}">
                    @if ($step > 1)
                        <svg class="w-6 h-6 text-white" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"
                            fill="currentColor" aria-hidden="true">
                            <path fill-rule="evenodd"
                                d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                clip-rule="evenodd" />
                        </svg>
                    @else
                        <span class="text-primary-600">01</span>
                    @endif
                </span>
                <span class="ml-4 text-sm font-medium text-primary-600">Requirements</span>
            </a>

            <!-- Arrow separator for lg screens and up -->
            <div class="hidden md:block absolute top-0 right-0 h-full w-5" aria-hidden="true">
                <svg class="h-full w-full text-neutral-300" viewBox="0 0 22 80" fill="none" preserveAspectRatio="none">
                    <path d="M0 -2L20 40L0 82" vector-effect="non-scaling-stroke" stroke="currentcolor"
                        stroke-linejoin="round" />
                </svg>
            </div>
        </li>

        <li class="relative md:flex-1 md:flex">
            <a href="#" class="pointer-events-none group flex items-center">
                <span class="px-6 py-4 flex items-center text-sm font-medium">
                    <span
                        class="shrink-0 w-10 h-10 flex items-center justify-center rounded-full {{ $step == 2 ? 'border-2 border-primary-600' : ($step > 2 ? 'bg-primary-600' : 'border-2 border-neutral-300') }}">
                        @if ($step > 2)
                            <svg class="w-6 h-6 text-white" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"
                                fill="currentColor" aria-hidden="true">
                                <path fill-rule="evenodd"
                                    d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                    clip-rule="evenodd" />
                            </svg>
                        @else
                            <span class="{{ $step < 2 ? 'text-neutral-500' : 'text-primary-600' }}">02</span>
                        @endif
                    </span>
                    <span class="ml-4 text-sm font-medium text-neutral-500">Permissions</span>
                </span>
            </a>

            <!-- Arrow separator for lg screens and up -->
            <div class="hidden md:block absolute top-0 right-0 h-full w-5" aria-hidden="true">
                <svg class="h-full w-full text-neutral-300" viewBox="0 0 22 80" fill="none" preserveAspectRatio="none">
                    <path d="M0 -2L20 40L0 82" vector-effect="non-scaling-stroke" stroke="currentcolor"
                        stroke-linejoin="round" />
                </svg>
            </div>
        </li>


        <li class="relative md:flex-1 md:flex">
            <a href="#" class="pointer-events-none group flex items-center">
                <span class="px-6 py-4 flex items-center text-sm font-medium">
                    <span
                        class="shrink-0 w-10 h-10 flex items-center justify-center rounded-full {{ $step == 3 ? 'border-2 border-primary-600' : ($step > 3 ? 'bg-primary-600' : 'border-2 border-neutral-300') }}">
                        @if ($step > 3)
                            <svg class="w-6 h-6 text-white" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"
                                fill="currentColor" aria-hidden="true">
                                <path fill-rule="evenodd"
                                    d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                    clip-rule="evenodd" />
                            </svg>
                        @else
                            <span class="{{ $step < 3 ? 'text-neutral-500' : 'text-primary-600' }}">03</span>
                        @endif
                    </span>
                    <span class="ml-4 text-sm font-medium text-neutral-500">Setup</span>
                </span>
            </a>

            <!-- Arrow separator for lg screens and up -->
            <div class="hidden md:block absolute top-0 right-0 h-full w-5" aria-hidden="true">
                <svg class="h-full w-full text-neutral-300" viewBox="0 0 22 80" fill="none" preserveAspectRatio="none">
                    <path d="M0 -2L20 40L0 82" vector-effect="non-scaling-stroke" stroke="currentcolor"
                        stroke-linejoin="round" />
                </svg>
            </div>
        </li>


        <li class="relative md:flex-1 md:flex">
            <a href="#" class="pointer-events-none group flex items-center">
                <span class="px-6 py-4 flex items-center text-sm font-medium">
                    <span
                        class="shrink-0 w-10 h-10 flex items-center justify-center rounded-full {{ $step == 4 ? 'border-2 border-primary-600' : ($step > 4 ? 'bg-primary-600' : 'border-2 border-neutral-300') }}">
                        @if ($step > 4)
                            <svg class="w-6 h-6 text-white" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"
                                fill="currentColor" aria-hidden="true">
                                <path fill-rule="evenodd"
                                    d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                    clip-rule="evenodd" />
                            </svg>
                        @else
                            <span class="{{ $step < 4 ? 'text-neutral-500' : 'text-primary-600' }}">04</span>
                        @endif
                    </span>
                    <span class="ml-4 text-sm font-medium text-neutral-500">User</span>
                </span>
            </a>

            <!-- Arrow separator for lg screens and up -->
            <div class="hidden md:block absolute top-0 right-0 h-full w-5" aria-hidden="true">
                <svg class="h-full w-full text-neutral-300" viewBox="0 0 22 80" fill="none" preserveAspectRatio="none">
                    <path d="M0 -2L20 40L0 82" vector-effect="non-scaling-stroke" stroke="currentcolor"
                        stroke-linejoin="round" />
                </svg>
            </div>
        </li>

        <li class="relative md:flex-1 md:flex">
            <a href="#" class="pointer-events-none group flex items-center">
                <span class="px-6 py-4 flex items-center text-sm font-medium">
                    <span
                        class="shrink-0 w-10 h-10 flex items-center justify-center rounded-full {{ $step == 5 ? 'bg-primary-600' : 'border-2 border-neutral-300' }}">
                        @if ($step == 5)
                            <svg class="w-6 h-6 text-white" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"
                                fill="currentColor" aria-hidden="true">
                                <path fill-rule="evenodd"
                                    d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                                    clip-rule="evenodd" />
                            </svg>
                        @else
                            <span class="text-neutral-500">05</span>
                        @endif
                    </span>
                    <span class="ml-4 text-sm font-medium text-neutral-500">Finish</span>
                </span>
            </a>
        </li>
    </ol>
</nav>

----------------------
----------------------
File: installer\passes-icon.blade.php
Content:
<svg width="1.5em" height="1.5em" viewBox="0 0 20 20" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
    <path fill-rule="evenodd"
        d="M17.354 4.646a.5.5 0 010 .708l-7 7a.5.5 0 01-.708 0l-3-3a.5.5 0 11.708-.708L10 11.293l6.646-6.647a.5.5 0 01.708 0z"
        clip-rule="evenodd"></path>
    <path fill-rule="evenodd"
        d="M10 4.5a5.5 5.5 0 105.5 5.5.5.5 0 011 0 6.5 6.5 0 11-3.25-5.63.5.5 0 11-.5.865A5.472 5.472 0 0010 4.5z"
        clip-rule="evenodd"></path>
</svg>

----------------------
----------------------
File: installer\permissions.blade.php
Content:
@extends('layouts.installer')

@section('content')
    @include('installer/includes/permissions')


    @if (isset($permissions['errors']) && $permissions['errors'] === true)
        <div class="-m-7 py-7 px-10 mt-6 border-t border-warning-100 text-right rounded-b bg-warning-50">
            <div class="flex">
                <div class="shrink-0">
                    <!-- Heroicon name: solid/exclamation -->
                    <svg class="h-5 w-5 text-warning-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"
                        fill="currentColor" aria-hidden="true">
                        <path fill-rule="evenodd"
                            d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z"
                            clip-rule="evenodd" />
                    </svg>
                </div>
                <div class="ml-3">
                    <h3 class="text-sm font-medium text-warning-800">
                        You need to fix the requirements in order to continue with the installation.
                    </h3>
                </div>
            </div>
        </div>
    @else
        <div class="-m-7 p-4 mt-6 bg-neutral-50 border-t border-neutral-200 text-right rounded-b">
            <a href="{{ url('install/setup') }}"
                class="inline-flex items-center px-4 py-2 border border-transparent text-sm rounded-md shadow-sm text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500">Next</a>
        </div>
    @endif
@endsection

----------------------
----------------------
File: installer\requirements.blade.php
Content:
@extends('layouts.installer')

@section('content')
    @include('installer/includes/requirements')

    @if ((isset($requirements['errors']) && $requirements['errors'] === true) || $php['supported'] === false)
        <div class="-m-7 py-7 px-10 mt-6 border-t border-warning-100 text-right rounded-b bg-warning-50">
            <div class="flex">
                <div class="shrink-0">
                    <!-- Heroicon name: solid/exclamation -->
                    <svg class="h-5 w-5 text-warning-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"
                        fill="currentColor" aria-hidden="true">
                        <path fill-rule="evenodd"
                            d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z"
                            clip-rule="evenodd" />
                    </svg>
                </div>
                <div class="ml-3">
                    <h3 class="text-sm font-medium text-warning-800">
                        You need to fix the requirements in order to continue with the installation.
                    </h3>
                </div>
            </div>
        </div>
    @else
        <div class="-m-7 p-4 mt-6 bg-neutral-50 border-t border-neutral-200 text-right rounded-b">
            <a href="{{ url('install/permissions') }}"
                class="inline-flex items-center px-4 py-2 border border-transparent text-sm rounded-md shadow-sm text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500">Next</a>
        </div>
    @endif
@endsection

----------------------
----------------------
File: installer\setup.blade.php
Content:
@extends('layouts.installer')

@section('content')
<form action="{{ url('install/setup') }}" id="setup-form" method="POST">
    @csrf
    <div class="p-3">
        <h5 class="text-lg my-5 text-neutral-800 font-semibold">General Config</h5>

        <div class="space-y-6 sm:space-y-5">

            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-neutral-200 sm:pt-5">
                <label for="appUrlName" class="block text-sm font-medium text-neutral-700 sm:mt-px sm:pt-2">
                    <span class="text-danger-600 text-sm mr-1">*</span>App URL
                </label>
                <div class="mt-1 sm:mt-0 sm:col-span-2">
                    <input type="text" value="{{ old('app_url', $guessedUrl) }}" name="app_url" class="block w-full shadow-sm focus:ring-primary-500 border focus:border-primary-500 border-neutral-300 sm:text-sm rounded-md" id="appUrlName">
                    <p class="mt-2 text-sm text-neutral-500">* This is the URL where you are installing the application,
                        for example, for subdomain in this field you need to enter "https://subdomain.example.com/",
                        make sure to check the documentation on how to create your subdomain.</p>
                    @error('app_url')
                    <p class="mt-2 text-sm text-danger-600">
                        {{ $message }}
                    </p>
                    @enderror
                </div>
            </div>

            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-neutral-200 sm:pt-5">
                <label for="inputAppName" class="block text-sm font-medium text-neutral-700 sm:mt-px sm:pt-2">
                    <span class="text-danger-600 text-sm mr-1">*</span>Application Name
                </label>
                <div class="mt-1 sm:mt-0 sm:col-span-2">
                    <input type="text" value="{{ old('app_name', config('app.name')) }}" name="app_name" class="block w-full shadow-sm focus:ring-primary-500 border focus:border-primary-500 border-neutral-300 sm:text-sm rounded-md" id="inputAppName">
                    @error('app_name')
                    <p class="mt-2 text-sm text-danger-600">
                        {{ $message }}
                    </p>
                    @enderror
                </div>
            </div>
        </div>

        <h5 class="text-lg mb-5 mt-10 text-neutral-800 font-semibold">Database Configuration</h5>

        @error('privilege')
        <div class="text-danger-500 p-4 bg-danger-50 border border-danger-200 mb-5 rounded-md text-sm">
            <p class="mb-2">
                {{ $message }}
            </p>
            <p class="font-bold">Make sure to give <span class="font-bold">all privileges to the database
                    user</span>, check the installation video in the documentation.</p>
        </div>
        @enderror

        <div class="space-y-6 sm:space-y-5">
            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-neutral-200 sm:pt-5">
                <label for="inputDatabaseHostname" class="block text-sm font-medium text-neutral-700 sm:mt-px sm:pt-2">
                    <span class="text-danger-600 text-sm mr-1">*</span>Hostname
                </label>
                <div class="mt-1 sm:mt-0 sm:col-span-2">
                    <input type="text" value="{{ old('database_hostname', 'localhost') }}" name="database_hostname" class="block w-full shadow-sm focus:ring-primary-500 border focus:border-primary-500 border-neutral-300 sm:text-sm rounded-md" id="inputDatabaseHostname">
                    @error('database_hostname')
                    <p class="mt-2 text-sm text-danger-600">
                        {{ $message }}
                    </p>
                    @enderror
                </div>
            </div>

            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-neutral-200 sm:pt-5">
                <label for="inputDatabasePort" class="block text-sm font-medium text-neutral-700 sm:mt-px sm:pt-2">
                    <span class="text-danger-600 text-sm mr-1">*</span>Port
                </label>
                <div class="mt-1 sm:mt-0 sm:col-span-2">
                    <input type="text" value="{{ old('database_port', '3306') }}" name="database_port" class="block w-full shadow-sm focus:ring-primary-500 border focus:border-primary-500 border-neutral-300 sm:text-sm rounded-md" id="inputDatabasePort">
                    <p class="mt-2 text-sm text-neutral-500">* The default MySQL ports is 3306, change the value only if
                        you are certain that you are using different port.</p>
                    @error('database_port')
                    <p class="mt-2 text-sm text-danger-600">
                        {{ $message }}
                    </p>
                    @enderror
                </div>
            </div>

            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-neutral-200 sm:pt-5">
                <label for="inputDatabaseName" class="block text-sm font-medium text-neutral-700 sm:mt-px sm:pt-2">
                    <span class="text-danger-600 text-sm mr-1">*</span>Database Name
                </label>
                <div class="mt-1 sm:mt-0 sm:col-span-2">
                    <input type="text" value="{{ old('database_name') }}" name="database_name" class="block w-full shadow-sm focus:ring-primary-500 border focus:border-primary-500 border-neutral-300 sm:text-sm rounded-md" id="inputDatabaseName">
                    <p class="mt-2 text-sm text-neutral-500">* Make sure that you have created the database before
                        configuring.</p>
                    @error('database_name')
                    <p class="mt-2 text-sm text-danger-600">
                        {{ $message }}
                    </p>
                    @enderror
                </div>
            </div>

            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-neutral-200 sm:pt-5">
                <label for="inputDatabaseUsername" class="block text-sm font-medium text-neutral-700 sm:mt-px sm:pt-2">
                    <span class="text-danger-600 text-sm mr-1">*</span>Database Username
                </label>
                <div class="mt-1 sm:mt-0 sm:col-span-2">
                    <input type="text" value="{{ old('database_username') }}" name="database_username" class="block w-full shadow-sm focus:ring-primary-500 border focus:border-primary-500 border-neutral-300 sm:text-sm rounded-md" id="inputDatabaseUsername">
                    <p class="mt-2 text-sm text-neutral-500">* Make sure you have set ALL privileges for the user.</p>
                    @error('database_username')
                    <p class="mt-2 text-sm text-danger-600">
                        {{ $message }}
                    </p>
                    @enderror
                </div>
            </div>

            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-neutral-200 sm:pt-5">
                <label for="inputDatabasePassword" class="block text-sm font-medium text-neutral-700 sm:mt-px sm:pt-2">
                    Database Password
                </label>
                <div class="mt-1 sm:mt-0 sm:col-span-2">
                    <input type="password" name="database_password" class="block w-full shadow-sm focus:ring-primary-500 border focus:border-primary-500 border-neutral-300 sm:text-sm rounded-md" id="inputDatabasePassword">
                    <p class="mt-2 text-sm text-neutral-500">* Enter the database user password.</p>
                    @error('database_password')
                    <p class="mt-2 text-sm text-danger-600">
                        {{ $message }}
                    </p>
                    @enderror
                </div>
            </div>
        </div>
    </div>
    <div class="-m-7 -mb-11 p-4 mt-6 bg-neutral-50 border-t border-neutral-200 text-right rounded-b">
        <button type="submit" class="inline-flex items-center px-4 py-2 border border-transparent text-sm rounded-md shadow-sm text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 disabled:opacity-60 disabled:pointer-events-none" id="btn-setup">Test Connection &amp; Configure</button>
    </div>
</form>
@endsection
<script>
    document.addEventListener("DOMContentLoaded", function(event) {
        document.getElementById('setup-form').onsubmit = function(e) {
            document.getElementById('btn-setup').disabled = true;
            document.getElementById('btn-setup').innerText = 'Please wait...';
        }
    });
</script>
----------------------
----------------------
File: installer\user.blade.php
Content:
@extends('layouts.installer')

@section('content')
<form action="{{ url('install/user') }}" id="user-form" method="POST">
    @csrf
    <div class="p-3">
        <h5 class="text-lg my-5 text-neutral-800 font-semibold">Configure Admin User</h5>
        <div class="space-y-6 sm:space-y-5">
            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-neutral-200 sm:pt-5">
                <label for="inputUserFName" class="block text-sm font-medium text-neutral-700 sm:mt-px sm:pt-2">
                    <span class="text-danger-600 text-sm mr-1">*</span>First Name
                </label>
                <div class="mt-1 sm:mt-0 sm:col-span-2">
                    <input type="text" name="firstName" placeholder="Enter your first name" value="{{ old('firstName') }}" class="block w-full shadow-sm focus:ring-primary-500 border focus:border-primary-500 border-neutral-300 sm:text-sm rounded-md" id="inputUserFName">
                    @error('firstName')
                    <p class="mt-2 text-sm text-danger-600">
                        {{ $message }}
                    </p>
                    @enderror
                </div>
            </div>
            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-neutral-200 sm:pt-5">
                <label for="inputUserLName" class="block text-sm font-medium text-neutral-700 sm:mt-px sm:pt-2">
                    <span class="text-danger-600 text-sm mr-1">*</span>Last Name
                </label>
                <div class="mt-1 sm:mt-0 sm:col-span-2">
                    <input type="text" name="lastName" placeholder="Enter your last name" value="{{ old('lastName') }}" class="block w-full shadow-sm focus:ring-primary-500 border focus:border-primary-500 border-neutral-300 sm:text-sm rounded-md" id="inputUserLName">
                    @error('lastName')
                    <p class="mt-2 text-sm text-danger-600">
                        {{ $message }}
                    </p>
                    @enderror
                </div>
            </div>
            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-neutral-200 sm:pt-5">
                <label for="inputEmail" class="block text-sm font-medium text-neutral-700 sm:mt-px sm:pt-2">
                    <span class="text-danger-600 text-sm mr-1">*</span>E-Mail Address
                </label>
                <div class="mt-1 sm:mt-0 sm:col-span-2">
                    <input type="email" value="{{ old('email') }}" name="email" placeholder="Enter your email address that will be used for login" class="block w-full shadow-sm focus:ring-primary-500 border focus:border-primary-500 border-neutral-300 sm:text-sm rounded-md" id="inputEmail">
                    @error('email')
                    <p class="mt-2 text-sm text-danger-600">
                        {{ $message }}
                    </p>
                    @enderror
                </div>
            </div>
            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-neutral-200 sm:pt-5">
                <label for="inputPassword" class="block text-sm font-medium text-neutral-700 sm:mt-px sm:pt-2">
                    <span class="text-danger-600 text-sm mr-1">*</span>Password
                </label>
                <div class="mt-1 sm:mt-0 sm:col-span-2">
                    <input type="password" name="password" placeholder="Login password" autocomplete="new-password" class="block w-full shadow-sm focus:ring-primary-500 border focus:border-primary-500 border-neutral-300 sm:text-sm rounded-md" id="inputPassword">
                    @error('password')
                    <p class="mt-2 text-sm text-danger-600">
                        {{ $message }}
                    </p>
                    @enderror
                </div>
            </div>

            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-neutral-200 sm:pt-5">
                <label for="inputPasswordConfirm" class="block text-sm font-medium text-neutral-700 sm:mt-px sm:pt-2">
                    <span class="text-danger-600 text-sm mr-1">*</span>Confirm Password
                </label>
                <div class="mt-1 sm:mt-0 sm:col-span-2">
                    <input type="password" name="password_confirmation" autocomplete="new-password" placeholder="Confirm login password" class="block w-full shadow-sm focus:ring-primary-500 border focus:border-primary-500 border-neutral-300 sm:text-sm rounded-md" id="inputPasswordConfirm">
                    @error('password_confirmation')
                    <p class="mt-2 text-sm text-danger-600">
                        {{ $message }}
                    </p>
                    @enderror
                </div>
            </div>
        </div>
    </div>
    <div class="-m-7 -mb-11 p-4 mt-6 bg-neutral-50 border-t border-neutral-200 text-right rounded-b">
        <button type="submit" class="inline-flex items-center px-4 py-2 border border-transparent text-sm rounded-md shadow-sm text-white bg-primary-600 hover:bg-primary-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary-500 disabled:opacity-60 disabled:pointer-events-none" id="btn-install">Install</button>
    </div>
</form>
@endsection
<script>
    document.addEventListener("DOMContentLoaded", function(event) {
        document.getElementById('user-form').onsubmit = function(e) {
            document.getElementById('btn-install').disabled = true;
            document.getElementById('btn-install').innerText = 'Please wait...';
        }
    });
</script>
----------------------
----------------------
File: installer\includes\permissions.blade.php
Content:
<div class="p-3">
    <h4 class="text-lg my-5 text-neutral-800 font-semibold">Files and folders permissions</h4>
    <p class="text-neutral-700">
        These folders must be writable by web server user: <strong
            class="select-all">{{ get_current_user() }}</strong>
        <br />Recommended permissions: <strong class="select-all">0775</strong><br /><br />
    </p>

    <div class="flex flex-col">
        <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
            <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
                <div class="shadow overflow-hidden border-b border-neutral-200 sm:rounded-lg">
                    <table class="min-w-full divide-y divide-neutral-200">
                        <thead class="bg-neutral-50">
                            <tr>
                                <th scope="col"
                                    class="px-4 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                    Path
                                </th>
                                <th scope="col"
                                    class="px-4 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                    Permission
                                </th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-neutral-200">
                            @foreach ($permissions['results'] as $permission)
                                <tr>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-medium text-neutral-900">
                                        {{ rtrim($permission['folder'], '/') }}
                                    </td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-medium text-neutral-900">
                                        <span
                                            class="inline-flex {{ $permission['isSet'] ? 'text-success-500' : 'text-warning-500' }}">
                                            @if ($permission['isSet'])
                                                @include('installer.passes-icon')
                                            @endif
                                            {{ $permission['permission'] }}
                                        </span>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

----------------------
----------------------
File: installer\includes\requirements.blade.php
Content:
<div class="p-3">
    @if ($memoryLimitMB !== -1 && $memoryLimitMB !== 0 && $memoryLimitMB <= 64)
        <div class="px-4 py-3 border border-warning-100 rounded bg-warning-50">
            <h3 class="text-warning-800 mb-3">Low PHP Memory Limit</h3>

            <p class="text-sm text-warning-800">
                The installer detected that the server <span class="font-medium">PHP memory limit</span> is set to
                <span class="font-medium">{{ $memoryLimitRaw }}</span>. It's
                <span class="font-medium">strongly recommended</span> to increase the memory limit to at least
                <span class="font-medium">128M</span> to avoid any failures during installation or while using the Document Management System.
            </p>

            <p class="mt-2 text-sm text-warning-800">
                When logged-in to the server control panel, perform a search for e.q. <span class="font-medium">"PHP
                    settings</span>", <span class="font-medium">"Select PHP
                    Version</span>", <span class="font-medium">"PHP INI Editor</span>", or <span
                    class="font-medium">"PHP Options</span>" or any other related options for your control panel in
                order to increase the memory limit, or consult with your hosting provider to do this for you.
            </p>
        </div>
    @endif


    <h4 class="text-lg my-5 text-neutral-800 font-semibold">PHP Version</h4>
    <div class="flex flex-col">
        <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
            <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
                <div class="shadow overflow-hidden border-b border-neutral-200 sm:rounded-lg">
                    <table class="min-w-full divide-y divide-neutral-200">
                        <thead class="bg-neutral-50">
                            <th scope="col"
                                class="px-4 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                Required PHP Version
                            </th>
                            <th scope="col"
                                class="px-4 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                Current
                            </th>
                        </thead>
                        <tbody class="bg-white divide-y divide-neutral-200">
                            <td class="px-4 py-2 whitespace-nowrap text-sm font-medium text-neutral-900">
                                >= {{ $php['minimum'] }}
                            </td>
                            <td class="px-4 py-2 whitespace-nowrap text-sm text-neutral-900">
                                <span
                                    class="inline-flex {{ $php['supported'] ? 'text-success-500' : 'text-warning-500' }}">
                                    @if ($php['supported'])
                                        @include('installer.passes-icon')
                                    @endif
                                    {{ $php['current'] }}
                                </span>
                            </td>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <h4 class="text-lg mb-5 mt-10 text-neutral-800 font-semibold">Required PHP Extensions</h4>

    <div class="flex flex-col">
        <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
            <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
                <div class="shadow overflow-hidden border-b border-neutral-200 sm:rounded-lg">
                    <table class="min-w-full divide-y divide-neutral-200">
                        <thead class="bg-neutral-50">
                            <th scope="col"
                                class="px-4 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                Extension
                            </th>
                            <th scope="col"
                                class="px-4 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                Enabled
                            </th>

                        </thead>
                        <tbody>
                            @foreach ($requirements['results']['php'] as $requirement => $enabled)
                                <tr>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-medium text-neutral-900">
                                        {{ $requirement }}
                                    </td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-neutral-900">
                                        <span
                                            class="inline-flex {{ $enabled ? 'text-success-500' : 'text-warning-500' }}">
                                            @if ($enabled)
                                                @include('installer.passes-icon')
                                            @endif
                                            {{ $enabled ? 'Yes' : 'No' }}
                                        </span>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <h4 class="text-lg mb-5 mt-10 text-neutral-800 font-semibold">Recommended PHP Extensions</h4>

    <div class="flex flex-col">
        <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
            <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
                <div class="shadow overflow-hidden border-b border-neutral-200 sm:rounded-lg">
                    <table class="min-w-full divide-y divide-neutral-200">
                        <thead class="bg-neutral-50">
                            <th scope="col"
                                class="px-4 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                Extension
                            </th>
                            <th scope="col"
                                class="px-4 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                                Enabled
                            </th>

                        </thead>
                        <tbody>
                            @foreach ($requirements['recommended']['php'] as $requirement => $enabled)
                                <tr>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm font-medium text-neutral-900">
                                        {{ $requirement }}
                                    </td>
                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-neutral-900">
                                        <span
                                            class="inline-flex {{ $enabled ? 'text-success-500' : 'text-warning-500' }}">
                                            @if ($enabled)
                                                @include('installer.passes-icon')
                                            @endif
                                            {{ $enabled ? 'Yes' : 'No' }}
                                        </span>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

----------------------
----------------------
File: layouts\boards.blade.php
Content:
<!DOCTYPE html>
<html lang="{{ $currentLang ?? 'en' }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta name="robots" content="noindex">
    
    <title>@yield('title', 'Boards') - {{ $companyProfile->title ?? 'Datai' }}</title>
    
    {{-- Favicon --}}
    @if(file_exists(public_path('logo.png')))
        <link rel="icon" href="{{ asset('logo.png') }}" type="image/png">
    @endif
    
    {{-- Core Styles --}}
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    
    {{-- Boards Custom Styles --}}
    <link href="{{ asset('css/boards.css') }}" rel="stylesheet">
    
    @stack('styles')
</head>
<body class="boards-app">
    {{-- Top Navigation --}}
    <nav class="boards-navbar">
        <div class="boards-navbar-brand">
            @if(file_exists(public_path('logo.png')))
                <img src="{{ asset('logo.png') }}" alt="{{ $companyProfile->title ?? 'Datai' }}" class="boards-logo">
            @endif
            <a href="{{ route('boards.index') }}" class="boards-brand-text">
                <span class="brand-primary">{{ $companyProfile->title ?? 'Datai' }}</span>
                <span class="brand-secondary">Boards</span>
            </a>
        </div>
        
        <div class="boards-navbar-actions">
            {{-- Language Selector --}}
            @if(isset($languages) && count($languages) > 1)
            <div class="boards-dropdown">
                <button class="boards-btn boards-btn-ghost boards-dropdown-toggle">
                    <i class="fa fa-globe"></i>
                    <span>{{ strtoupper($currentLang ?? 'EN') }}</span>
                </button>
                <div class="boards-dropdown-menu">
                    @foreach($languages as $lang)
                        <a href="?lang={{ $lang->code }}" class="boards-dropdown-item {{ ($currentLang ?? 'en') == $lang->code ? 'active' : '' }}">
                            {{ $lang->name }}
                        </a>
                    @endforeach
                </div>
            </div>
            @endif
            
            {{-- Back to Dashboard --}}
            <a href="/" class="boards-btn boards-btn-outline">
                <i class="fa fa-arrow-left"></i>
                <span>Back to Dashboard</span>
            </a>
            
            {{-- User Menu --}}
            <div class="boards-dropdown">
                <button class="boards-user-btn boards-dropdown-toggle">
                    @if(isset($user->profilePhoto) && $user->profilePhoto)
                        <img src="{{ asset('uploads/photos/' . $user->profilePhoto) }}" alt="Profile" class="boards-user-avatar">
                    @else
                        <div class="boards-user-avatar-placeholder">
                            {{ strtoupper(substr($user->firstName ?? 'U', 0, 1)) }}
                        </div>
                    @endif
                    <span class="boards-user-name">{{ ($user->firstName ?? '') . ' ' . ($user->lastName ?? '') }}</span>
                </button>
                <div class="boards-dropdown-menu boards-dropdown-menu-right">
                    <div class="boards-dropdown-header">
                        <div class="boards-user-email">{{ $user->email ?? '' }}</div>
                    </div>
                    <div class="boards-dropdown-divider"></div>
                    <a href="/" class="boards-dropdown-item">
                        <i class="fa fa-home"></i> Dashboard
                    </a>
                    <a href="/login" class="boards-dropdown-item text-danger">
                        <i class="fa fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>
        </div>
    </nav>
    
    {{-- Alert Messages --}}
    @if(session('success'))
        <div class="boards-alert boards-alert-success">
            <i class="fa fa-check-circle"></i>
            {{ session('success') }}
            <button class="boards-alert-close">&times;</button>
        </div>
    @endif
    
    @if(session('error'))
        <div class="boards-alert boards-alert-danger">
            <i class="fa fa-exclamation-circle"></i>
            {{ session('error') }}
            <button class="boards-alert-close">&times;</button>
        </div>
    @endif
    
    {{-- Main Content --}}
    <main class="boards-main">
        @yield('content')
    </main>
    
    {{-- Footer --}}
    <footer class="boards-footer">
        <p>&copy; {{ date('Y') }} {{ $companyProfile->title ?? 'Datai' }}. All rights reserved.</p>
    </footer>
    
    {{-- Core Scripts --}}
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
    
    {{-- Boards Core JS --}}
    <script src="{{ asset('js/boards.js') }}"></script>
    
    {{-- Initialize with auth token --}}
    <script>
        window.BoardsConfig = {
            csrfToken: '{{ csrf_token() }}',
            authToken: '{{ $authToken ?? "" }}',
            baseUrl: '{{ url("/") }}',
            apiUrl: '{{ url("/api") }}',
            userId: '{{ $user->id ?? "" }}'
        };
    </script>
    
    @stack('scripts')
</body>
</html>

----------------------
----------------------
File: layouts\installer.blade.php
Content:
<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="robots" content="noindex">

    {{-- Page Title --}}
    <title>@yield('title', 'Document Management - Installation')</title>
    {{-- Font family --}}
    <link href="{{ mix('css/app.css') }}" rel="stylesheet">
</head>

<body>
    <div id="app">
        <div class="flex min-h-screen flex-col justify-center bg-neutral-50 py-12 sm:px-6 lg:px-8">
            <div class="sm:mx-auto sm:w-full sm:max-w-md">
                @if (file_exists(public_path('logo.png')))
                    <div class="text-center">
                        <img src="{{ asset('logo.png') }}" alt="{{ config('app.name') }}" style="width: 50%;height: auto;border-radius: 10px;" class="mx-auto h-12 w-auto">
                    </div>
                @endif
            </div>
            <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-5xl">
                <div class="bg-white p-7 shadow sm:rounded-lg">
                    @if (!isset($withSteps) || (isset($withSteps) && $withSteps !== false))
                        @include('installer.menu')
                    @endif

                    @error('general')
                        <div class="mt-5 rounded-md bg-warning-50 p-4">
                            <div class="flex">
                                <div class="shrink-0">
                                    <!-- Heroicon name: solid/exclamation -->
                                    <svg class="h-5 w-5 text-warning-400" xmlns="http://www.w3.org/2000/svg"
                                        viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                        <path fill-rule="evenodd"
                                            d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z"
                                            clip-rule="evenodd" />
                                    </svg>
                                </div>
                                <div class="ml-3">
                                    <h3 class="text-sm font-medium text-warning-800">
                                        {{ $message }}
                                    </h3>
                                </div>
                            </div>
                        </div>
                    @enderror
                    @yield('content')
                </div>
            </div>
        </div>
    </div>
</body>

</html>

----------------------
----------------------
File: update\finish.blade.php
Content:
@extends('update.update-layout')

@section('content')
<div class="sm:mx-auto sm:w-full sm:max-w-md">
    @if (file_exists(public_path('logo.png')))
    <div class="text-center">
        <img src="{{ asset('logo.png') }}" alt="{{ config('app.name') }}" style="width: 50%;height: auto;border-radius: 10px;" class="mx-auto h-12 w-auto">
    </div>
    @endif
</div>

<div class="panel text-center">
    <h3 class="install-completed-header">Update has been successfully completed!</h3>

    <p class="mt-2">Your application will reload shortly to apply the latest updates.</p>

    <p id="countdown" class="text-gray-500 text-sm mt-1">Reloading in 3 seconds...</p>

    <a href="/" rel="noopener noreferrer"
        class="inline-flex items-center rounded-md border border-transparent bg-primary-600 px-4 py-2 text-sm text-white shadow-sm focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2 hover:bg-primary-700 mt-4">
        Close Update Page
    </a>
</div>

<script>
    // Clear JWT + session storage
    localStorage.clear();
    sessionStorage.clear();

    // Countdown + reload
    let seconds = 3;
    const countdown = document.getElementById('countdown');
    const interval = setInterval(() => {
        seconds--;
        countdown.textContent = `Reloading in ${seconds} seconds...`;
        if (seconds <= 0) {
            clearInterval(interval);
            window.location.replace("/"); // force reload to home
        }
    }, 1000);
</script>
@endsection
----------------------
----------------------
File: update\update-layout.blade.php
Content:
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="robots" content="noindex">
    <title>Document Management - Update</title>
    <link href="{{ mix('css/app.css') }}" rel="stylesheet">
    <style>
        html,
        body {
            height: 100%;
            margin: 0;
        }

        body {
            background: #f6f5f2;
            overflow: auto;
            font-family: Roboto, 'Helvetica Neue', sans-serif;
            font-size: 16px;
            text-align: center;
        }

        .button {
            color: #fff;
            border: 1px solid transparent;
            border-radius: 3px;
            font-size: 14px;
            cursor: pointer;
            padding: 0 8px;
            min-width: 88px;
            line-height: 36px;
        }

        .button[disabled] {
            color: rgba(0, 0, 0, 0.26);
            cursor: default;
            box-shadow: none;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding-top: 80px;
        }

        .panel {
            background: #fff;
            box-shadow: 1px 1px 2px 0 #d0d0d0;
            padding: 20px 30px 40px;
            margin-top: 50px;
            border-radius: 4px;
        }

        p {
            margin: 15px 0 25px 0;
        }

        h3 {
            font-weight: 400;
            font-size: 18px;
        }

        ul {
            list-style: none;
        }

        li {
            padding: 15px 10px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.12);
            color: #f2564d;
        }

        li:last-of-type {
            border: none;
        }
    </style>
</head>

<body>
    <div class="container">
        @yield('content')
    </div>
</body>

</html>
----------------------
----------------------
File: update\update.blade.php
Content:
@extends('update.update-layout')

@section('content')

<div class="sm:mx-auto sm:w-full sm:max-w-md">
    @if (file_exists(public_path('logo.png')))
    <div class="text-center">
        <img src="{{ asset('logo.png') }}" alt="{{ config('app.name') }}" style="width: 50%;height: auto;border-radius: 10px;" class="mx-auto h-12 w-auto">
    </div>
    @endif
</div>

@if(!$isUpdateAvailable)
<div class="panel">
    <h3 class="text-success-500">Great news! No update available at this time. Your system is up-to-date and running smoothly.</h3>

    <div class="-m-7 mt-6 rounded-b border-t border-neutral-200 bg-neutral-50 p-4 text-center">
        <a href="{{ url('login') }}" rel="noopener noreferrer" class="inline-flex items-center rounded-md border border-transparent bg-primary-600 px-4 py-2 text-sm text-white shadow-sm focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2 hover:bg-primary-700">
            Login to Continue
        </a>
    </div>
</div>
@endif

@if($isRequirementsErrors)
<div class="panel">
    <h3>Detected the following problems. Please correct them before proceeding with the update.</h3>
    <ul class="errors">
        @foreach($requirements as $req)
        @if(!$req['result'])
        <li>{{$req['errorMessage']}}</li>
        @endif
        @endforeach
    </ul>
</div>
@endif

@if($isUpdateAvailable)
<form class="panel" action="update/run" method="post">
    {{ csrf_field() }}
    <p class="text-success-500">Exciting news! A new update is available for your system. Stay ahead with the latest features, improvements, and enhancements by updating now.</p>
    <p>This might take several minutes, please don't close this browser tab while update is in progress.</p>
    @if($isRequirementsErrors)
    <button class="button bg-primary-600" type="submit" disabled>Update Now</button>
    @else
    <button class="button bg-primary-600" type="submit">Update Now</button>
    @endif
</form>
@endif
@endsection
----------------------
----------------------
File: users\create.blade.php
Content:
@section('content')
<div class="row">
    <div class="col-lg-12 margin-tb">
        <div class="pull-left">
            <h2>Add New User</h2>
        </div>
        <div class="pull-right">
            <a class="btn btn-primary" href="{{ route('categories.index') }}"> Back</a>
        </div>
    </div>
</div>

@if ($errors->any())
    <div class="alert alert-danger">
        There were some problems with your input.<br><br>
        <ul>
            @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    </div>
@endif

<form action="{{ route('categories.store') }}" method="POST">
    @csrf

     <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12">
            <div class="form-group">
                <strong>Name:</strong>
                <input type="text" name="name" class="form-control" placeholder="Name">
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12">
            <div class="form-group">
                <strong>email:</strong>
                <textarea class="form-control" style="height:150px" name="email" placeholder="Email"></textarea>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12 text-center">
                <button type="submit" class="btn btn-primary">Submit</button>
        </div>
    </div>

</form>
@endsection

----------------------
