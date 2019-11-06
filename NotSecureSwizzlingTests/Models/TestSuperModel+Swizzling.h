//
//  TestSuperModel+Swizzling.h
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 5/11/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import "TestSuperModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestSuperModel (Swizzling)

- (void)_super_superMethod:(TestResult *)result;

- (void)_super_overridedMethod:(TestResult *)result;

@end

NS_ASSUME_NONNULL_END
