//
//  TestModel.m
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import "TestModel.h"
#import "NotSecureSwizzlingTests-Swift.h"

@implementation TestSuperModel

- (void)onlySuper:(TestResult *)result
{
    result.isSuperCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"onlySuper:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSuperMethod)];
}

- (void)inBoth:(TestResult *)result
{
    result.isSuperCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"inBoth:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSuperMethod)];
}

@end

@implementation TestModel

- (void)onlySelf:(TestResult *)result
{
    result.isSelfCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"onlySelf:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSelfMethod)];
}

- (void)inBoth:(TestResult *)result
{
    result.isSelfCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"inBoth:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSelfMethod)];
    [super inBoth:result];
}

@end

