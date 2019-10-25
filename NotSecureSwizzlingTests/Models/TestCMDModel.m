//
//  TestCMDModel.m
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import "TestCMDModel.h"
#import "NotSecureSwizzlingTests-Swift.h"

@implementation TestCMDSuperModel

- (void)onlySuper:(TestCMDResult *)result
{
    result.isSuperCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"onlySuper:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSuperMethod)];
}

- (void)inBoth:(TestCMDResult *)result
{
    result.isSuperCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"inBoth:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSuperMethod)];
}

@end

@implementation TestCMDModel

- (void)onlySelf:(TestCMDResult *)result
{
    result.isSelfCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"onlySelf:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSelfMethod)];
}

- (void)inBoth:(TestCMDResult *)result
{
    result.isSelfCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"inBoth:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSelfMethod)];
    [super inBoth:result];
}

@end

