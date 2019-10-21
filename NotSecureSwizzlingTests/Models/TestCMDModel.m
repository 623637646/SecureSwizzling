//
//  TestCMDModel.m
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import "TestCMDModel.h"

@implementation TestCMDBaseModel

- (NSString *)getMethodNameInBase:(BOOL *)isCMDWrong
{
    if (isCMDWrong) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"getMethodNameInBase:"];
    }
    return @"getMethodNameInBase:";
}

@end

@implementation TestCMDModel

- (NSString *)getMethodName:(BOOL *)isCMDWrong
{
    if (isCMDWrong) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"getMethodName:"];
    }
    return @"getMethodName:";
}

@end


@implementation TestCMDModel (Swizzling)

- (NSString *)_getMethodName:(BOOL *)isCMDWrong
{
    if (isCMDWrong) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_getMethodName:"];
    }
    return @"_getMethodName:";
}

- (NSString *)_getMethodNameInBase:(BOOL *)isCMDWrong
{
    if (isCMDWrong) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_getMethodNameInBase:"];
    }
    return @"_getMethodNameInBase:";
}

@end
