//
//  TestSuperModel+Swizzling.m
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 5/11/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import "TestSuperModel+Swizzling.h"
#import "NotSecureSwizzlingTests-Swift.h"

@implementation TestSuperModel (Swizzling)

- (void)_super_superMethod:(TestResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_super_superMethod:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSuper)];
    [self _super_superMethod:result];
}

- (void)_super_overridedMethod:(TestResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_super_overridedMethod:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSuper)];
    [self _super_superMethod:result];
}

@end
