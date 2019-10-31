//
//  TestModel+Swizzling.m
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 23/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import "TestModel+Swizzling.h"
#import "NotSecureSwizzlingTests-Swift.h"

@implementation TestModel (Swizzling)

- (void)_selfMethod:(TestResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_selfMethod:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethod)];
    [self _selfMethod:result];
}

- (void)_superMethod:(TestResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_superMethod:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethod)];
    [self _superMethod:result];
}

- (void)_overridedMethod:(TestResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_overridedMethod:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethod)];
    [self _overridedMethod:result];
}

@end
