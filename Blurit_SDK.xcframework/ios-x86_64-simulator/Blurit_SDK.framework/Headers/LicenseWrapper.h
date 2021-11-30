//
//  LicenseWrapper.h
//  Blurit_SDK
//
//  Created by Bertrand VILLAIN on 03/04/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "LicenseKeyStatus.h"

@interface LicenseWrapper : NSObject

- (instancetype _Nullable )initWithLicense:(NSString* _Nonnull) licenseKey libraryType:(NSString* _Nonnull)libraryType;
- (LicenseKeyStatus)getLicenseStatus;
- (void)updateLicense:(NSString* _Nonnull) licenseKey;

@end
