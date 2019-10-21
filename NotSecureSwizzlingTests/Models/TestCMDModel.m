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
    assert(isCMDWrong != NULL);
    if (isCMDWrong) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"getMethodNameInBase:"];
    }
    return @"getMethodNameInBase:";
}

- (NSString *)getMethodNameInBoth:(BOOL *)isCMDWrong
{
    assert(isCMDWrong != NULL);
    if (isCMDWrong) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"getMethodNameInBoth:"];
    }
    return @"getMethodNameInBoth:";
}

@end

@implementation TestCMDModel

- (NSString *)getMethodNameInSubclass:(BOOL *)isCMDWrong
{
    assert(isCMDWrong != NULL);
    if (isCMDWrong) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"getMethodNameInSubclass:"];
    }
    return @"getMethodNameInSubclass:";
}

- (NSString *)getMethodNameInBoth:(BOOL *)isCMDWrong
{
    assert(isCMDWrong != NULL);
    NSString *superResult = [super getMethodNameInBoth:isCMDWrong];
    if (isCMDWrong && *isCMDWrong == NO) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"getMethodNameInBoth:"];
    }
    return [superResult stringByAppendingString:@"getMethodNameInBoth:"];
}

@end


@implementation TestCMDModel (Swizzling)

- (NSString *)_getMethodName:(BOOL *)isCMDWrong
{
    assert(isCMDWrong != NULL);
    if (isCMDWrong) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_getMethodName:"];
    }
    return @"_getMethodName:";
}

- (NSString *)_getMethodNameInBase:(BOOL *)isCMDWrong
{
    assert(isCMDWrong != NULL);
    if (isCMDWrong) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_getMethodNameInBase:"];
    }
    return @"_getMethodNameInBase:";
}

- (NSString *)_getMethodNameInBoth:(BOOL *)isCMDWrong
{
    assert(isCMDWrong != NULL);
    NSString *superResult = [super getMethodNameInBoth:isCMDWrong];
    if (isCMDWrong && *isCMDWrong == NO) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_getMethodNameInBoth:"];
    }
    return [superResult stringByAppendingString:@"_getMethodNameInBoth:"];
}

@end
