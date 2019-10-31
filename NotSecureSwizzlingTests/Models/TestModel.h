//
//  TestModel.h
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TestResult;

NS_ASSUME_NONNULL_BEGIN

@interface TestSuperModel : NSObject

- (void)onlySuper:(TestResult *)result;

- (void)inBoth:(TestResult *)result;

@end

@interface TestModel : TestSuperModel

- (void)onlySelf:(TestResult *)result;

@end

NS_ASSUME_NONNULL_END
