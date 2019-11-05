//
//  TestSuperModel.h
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 5/11/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TestResult;

NS_ASSUME_NONNULL_BEGIN

@interface TestSuperModel : NSObject

// This method is only in super class (TestSuperModel)
- (void)superMethod:(TestResult *)result;

// This method is override by subclass (TestModel)
- (void)overridedMethod:(TestResult *)result;

@end

NS_ASSUME_NONNULL_END
