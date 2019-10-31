//
//  TestModel+Swizzling.h
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 23/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import "TestModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestModel (Swizzling)

- (void)_onlySelf:(TestResult *)result;

- (void)_onlySuper:(TestResult *)result;

- (void)_inBoth:(TestResult *)result;

@end

NS_ASSUME_NONNULL_END
