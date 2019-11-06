//
//  TestSuperModel.m
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 5/11/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import "TestSuperModel.h"
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
