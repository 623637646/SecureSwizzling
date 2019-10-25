//
//  TestCMDModel.h
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TestCMDResult;

NS_ASSUME_NONNULL_BEGIN

@interface TestCMDSuperModel : NSObject

- (void)onlySuper:(TestCMDResult *)result;

- (void)inBoth:(TestCMDResult *)result;

@end

@interface TestCMDModel : TestCMDSuperModel

- (void)onlySelf:(TestCMDResult *)result;

@end

NS_ASSUME_NONNULL_END
