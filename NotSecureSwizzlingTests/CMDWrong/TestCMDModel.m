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

- (TestCMDResult *)onlySuper:(TestCMDResult *)result
{
    result.isSuperCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"onlySuper:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSuperMethod)];
    return result;
}

- (TestCMDResult *)inBoth:(TestCMDResult *)result
{
    result.isSuperCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"inBoth:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSuperMethod)];
    return result;
}

@end

@implementation TestCMDModel

- (TestCMDResult *)onlySelf:(TestCMDResult *)result
{
    result.isSelfCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"onlySelf:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSelfMethod)];
    return result;
}

- (TestCMDResult *)inBoth:(TestCMDResult *)result
{
    result.isSelfCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"inBoth:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSelfMethod)];
    [super inBoth:result];
    return result;
}

@end


@implementation TestCMDModel (Swizzling)

- (TestCMDResult *)_onlySelf:(TestCMDResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_onlySelf:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethod)];
    [self _onlySelf:result];
    return result;
}

- (TestCMDResult *)_onlySuper:(TestCMDResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_onlySuper:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethod)];
    [self _onlySuper:result];
    return result;
}

- (TestCMDResult *)_inBoth:(TestCMDResult *)result
{
    result.isSwizzledCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_inBoth:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethod)];
    [self _inBoth:result];
    return result;
}

@end
