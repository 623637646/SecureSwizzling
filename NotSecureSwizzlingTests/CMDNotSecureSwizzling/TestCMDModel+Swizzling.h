//
//  TestCMDModel+Swizzling.h
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 23/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import "TestCMDModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestCMDModel (Swizzling)

- (void)_onlySelf:(TestCMDResult *)result;

- (void)_onlySuper:(TestCMDResult *)result;

- (void)_inBoth:(TestCMDResult *)result;

@end

NS_ASSUME_NONNULL_END
