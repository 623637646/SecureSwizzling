//
//  TestCMDModel.m
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import "TestCMDModel.h"
#import "NotSecureSwizzlingTests-Swift.h"

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

- (NSString *)_getMethodNameInSubclass:(BOOL *)isCMDWrong
{
    assert(isCMDWrong != NULL);
    NSString *originalResult = [self _getMethodNameInSubclass:isCMDWrong];
    if (isCMDWrong && *isCMDWrong == NO) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_getMethodNameInSubclass:"];
    }
    return [originalResult stringByAppendingString:@"_getMethodNameInSubclass:"];
}

- (NSString *)_getMethodNameInBase:(BOOL *)isCMDWrong
{
    assert(isCMDWrong != NULL);
    NSString *originalResult = [self _getMethodNameInBase:isCMDWrong];
    if (isCMDWrong && *isCMDWrong == NO) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_getMethodNameInBase:"];
    }
    return [originalResult stringByAppendingString:@"_getMethodNameInBase:"];
}

- (NSString *)_getMethodNameInBoth:(BOOL *)isCMDWrong
{
    assert(isCMDWrong != NULL);
    NSString *originalResult = [self _getMethodNameInBoth:isCMDWrong];
    if (isCMDWrong && *isCMDWrong == NO) {
        *isCMDWrong = ![NSStringFromSelector(_cmd) isEqualToString:@"_getMethodNameInBoth:"];
    }
    return [originalResult stringByAppendingString:@"_getMethodNameInBoth:"];
}

@end
