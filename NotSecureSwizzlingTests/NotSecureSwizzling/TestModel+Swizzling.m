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

- (void)_onlySelf:(TestResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_onlySelf:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethod)];
    [self _onlySelf:result];
}

- (void)_onlySuper:(TestResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_onlySuper:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethod)];
    [self _onlySuper:result];
}

- (void)_inBoth:(TestResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_inBoth:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethod)];
    [self _inBoth:result];
}

@end
