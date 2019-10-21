//
//  TestCMDModel.h
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestCMDBaseModel : NSObject

- (NSString *)getMethodNameInBase:(BOOL *)isCMDWrong;

@end

@interface TestCMDModel : TestCMDBaseModel

- (NSString *)getMethodName:(BOOL *)isCMDWrong;

@end

@interface TestCMDModel (Swizzling)

- (NSString *)_getMethodName:(BOOL *)isCMDWrong;

- (NSString *)_getMethodNameInBase:(BOOL *)isCMDWrong;

@end

NS_ASSUME_NONNULL_END
