//
//  TestCMDModel.h
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestCMDModel : NSObject

- (NSString *)getMethodName:(BOOL *)isCMDAndMethodEqual;

@end

@interface TestCMDModel (Swizzling)

- (NSString *)_getMethodName:(BOOL *)isCMDAndMethodEqual;

@end

NS_ASSUME_NONNULL_END
