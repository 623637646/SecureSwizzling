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

- (void)superMethod:(TestResult *)result
{
    result.isSuperCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"superMethod:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSuperMethod)];
}

- (void)overridedMethod:(TestResult *)result
{
    result.isSuperCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"overridedMethod:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSuperMethod)];
}

@end

@implementation TestModel

- (void)subMethod:(TestResult *)result
{
    result.isSelfCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"subMethod:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSubMethod)];
}

- (void)overridedMethod:(TestResult *)result
{
    result.isSelfCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"overridedMethod:"];
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSubMethod)];
    [super overridedMethod:result];
}

@end

