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

- (void)_sub_subMethod:(TestResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_sub_subMethod:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
    [self _sub_subMethod:result];
}

- (void)_sub_superMethod:(TestResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_sub_superMethod:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
    [self _sub_superMethod:result];
}

- (void)_sub_overridedMethod:(TestResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_sub_overridedMethod:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
    [self _sub_overridedMethod:result];
}

@end
