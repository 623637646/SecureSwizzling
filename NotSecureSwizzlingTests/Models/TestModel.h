//
//  TestModel.h
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TestResultModel;

NS_ASSUME_NONNULL_BEGIN

@interface TestCMDSuperModel : NSObject

- (void)onlySuper:(TestResultModel *)result;

- (void)inBoth:(TestResultModel *)result;

@end

@interface TestModel : TestCMDSuperModel

- (void)onlySelf:(TestResultModel *)result;

@end

NS_ASSUME_NONNULL_END
