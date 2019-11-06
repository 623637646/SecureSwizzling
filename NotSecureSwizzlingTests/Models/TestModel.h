//
//  TestModel.h
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestSuperModel.h"
@class TestResult;

NS_ASSUME_NONNULL_BEGIN

@interface TestModel : TestSuperModel

// This method is only in subclass (TestModel)
- (void)subMethod:(TestResult *)result;

@end

NS_ASSUME_NONNULL_END
