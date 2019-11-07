//
//  RSSwizzleTests.m
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 6/11/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RSSwizzle.h"
#import "TestModel.h"
#import "NotSecureSwizzlingTests-Swift.h"

@interface RSSwizzleTests : XCTestCase

@end

@implementation RSSwizzleTests

/*
 id block = ^id(RSSwizzleInfo *swizzleInfo) {
     void (*originalImplementation_)(__attribute__((objc_ownership(none))) id, SEL,TestResult *result);
     SEL selector_ = @selector(superMethod:);
     return ^void (__attribute__((objc_ownership(none))) id self,TestResult *result) {
         result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
         
         ((__typeof(originalImplementation_))[swizzleInfo getOriginalImplementation])(self, selector_,result);
     };
 };
 
 [RSSwizzle swizzleInstanceMethod:@selector(superMethod:)
                          inClass:[TestModel.class class]
                    newImpFactory:block
                             mode:RSSwizzleModeAlways
                              key:((void*)0)];;
 */
- (void)testSuperMethod
{
    RSSwizzleInstanceMethod(TestModel.class,
                            @selector(superMethod:),
                            RSSWReturnType(void),
                            RSSWArguments(TestResult *result), RSSWReplacement({
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
        RSSWCallOriginal(result);
    }), RSSwizzleModeAlways, NULL);
    
    TestModel *obj = [[TestModel alloc] init];
    TestResult *result = [[TestResult alloc] init];
    [obj superMethod:result];
        
    XCTAssert(result.isSubCMDWrong == false);
    XCTAssert(result.isSuperCMDWrong == false);
    XCTAssert(result.isSwizzledCMDWrong == false);
    NSArray<NSNumber *> *expected = @[@(ExecutedSwizzledMethodInSub), @(ExecutedSuperMethod)];
    XCTAssert([result.objc_executedMethods isEqualToArray:expected]);
}

- (void)testSubMethod
{
    RSSwizzleInstanceMethod(TestModel.class,
                            @selector(subMethod:),
                            RSSWReturnType(void),
                            RSSWArguments(TestResult *result), RSSWReplacement({
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
        RSSWCallOriginal(result);
    }), RSSwizzleModeAlways, NULL);
    
    TestModel *obj = [[TestModel alloc] init];
    TestResult *result = [[TestResult alloc] init];
    [obj subMethod:result];
        
    XCTAssert(result.isSubCMDWrong == false);
    XCTAssert(result.isSuperCMDWrong == false);
    XCTAssert(result.isSwizzledCMDWrong == false);
    NSArray<NSNumber *> *expected = @[@(ExecutedSwizzledMethodInSub), @(ExecutedSubMethod)];
    XCTAssert([result.objc_executedMethods isEqualToArray:expected]);
}

- (void)testOverridedMethod
{
    RSSwizzleInstanceMethod(TestModel.class,
                            @selector(overridedMethod:),
                            RSSWReturnType(void),
                            RSSWArguments(TestResult *result), RSSWReplacement({
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
        RSSWCallOriginal(result);
    }), RSSwizzleModeAlways, NULL);
    
    TestModel *obj = [[TestModel alloc] init];
    TestResult *result = [[TestResult alloc] init];
    [obj overridedMethod:result];
    
    XCTAssert(result.isSubCMDWrong == false);
    XCTAssert(result.isSuperCMDWrong == false);
    XCTAssert(result.isSwizzledCMDWrong == false);
    NSArray<NSNumber *> *expected = @[@(ExecutedSwizzledMethodInSub),
                                      @(ExecutedSubMethod),
                                      @(ExecutedSuperMethod)];
    XCTAssert([result.objc_executedMethods isEqualToArray:expected]);
}

- (void)testSuperObject
{
    RSSwizzleInstanceMethod(TestModel.class,
                            @selector(superMethod:),
                            RSSWReturnType(void),
                            RSSWArguments(TestResult *result), RSSWReplacement({
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
        RSSWCallOriginal(result);
    }), RSSwizzleModeAlways, NULL);
    
    TestSuperModel *obj = [[TestSuperModel alloc] init];
    TestResult *result = [[TestResult alloc] init];
    [obj superMethod:result];
    
    XCTAssert(result.isSubCMDWrong == false);
    XCTAssert(result.isSuperCMDWrong == false);
    XCTAssert(result.isSwizzledCMDWrong == false);
    NSArray<NSNumber *> *expected = @[@(ExecutedSuperMethod)];
    XCTAssert([result.objc_executedMethods isEqualToArray:expected]);
}

- (void)testSwizzleSuperThenSub
{
    RSSwizzleInstanceMethod(TestSuperModel.class,
                            @selector(superMethod:),
                            RSSWReturnType(void),
                            RSSWArguments(TestResult *result), RSSWReplacement({
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSuper)];
        RSSWCallOriginal(result);
    }), RSSwizzleModeAlways, NULL);
    
    RSSwizzleInstanceMethod(TestModel.class,
                            @selector(superMethod:),
                            RSSWReturnType(void),
                            RSSWArguments(TestResult *result), RSSWReplacement({
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
        RSSWCallOriginal(result);
    }), RSSwizzleModeAlways, NULL);
    
    TestModel *obj = [[TestModel alloc] init];
    TestResult *result = [[TestResult alloc] init];
    [obj superMethod:result];
    
    XCTAssert(result.isSubCMDWrong == false);
    XCTAssert(result.isSuperCMDWrong == false);
    XCTAssert(result.isSwizzledCMDWrong == false);
    NSArray<NSNumber *> *expected = @[@(ExecutedSwizzledMethodInSub),
                                      @(ExecutedSwizzledMethodInSuper),
                                      @(ExecutedSuperMethod)];
    XCTAssert([result.objc_executedMethods isEqualToArray:expected]);
}

- (void)testSwizzleSubThenSuper
{
    
    RSSwizzleInstanceMethod(TestModel.class,
                            @selector(superMethod:),
                            RSSWReturnType(void),
                            RSSWArguments(TestResult *result), RSSWReplacement({
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
        RSSWCallOriginal(result);
    }), RSSwizzleModeAlways, NULL);
    
    RSSwizzleInstanceMethod(TestSuperModel.class,
                            @selector(superMethod:),
                            RSSWReturnType(void),
                            RSSWArguments(TestResult *result), RSSWReplacement({
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSuper)];
        RSSWCallOriginal(result);
    }), RSSwizzleModeAlways, NULL);
    
    TestModel *obj = [[TestModel alloc] init];
    TestResult *result = [[TestResult alloc] init];
    [obj superMethod:result];
    
    XCTAssert(result.isSubCMDWrong == false);
    XCTAssert(result.isSuperCMDWrong == false);
    XCTAssert(result.isSwizzledCMDWrong == false);
    NSArray<NSNumber *> *expected = @[@(ExecutedSwizzledMethodInSub),
                                      @(ExecutedSwizzledMethodInSuper),
                                      @(ExecutedSuperMethod)];
    XCTAssert([result.objc_executedMethods isEqualToArray:expected]);
}

- (void)testSwizzleTheSameMethodMultipleTimes
{
    RSSwizzleInstanceMethod(TestModel.class,
                            @selector(superMethod:),
                            RSSWReturnType(void),
                            RSSWArguments(TestResult *result), RSSWReplacement({
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
        NSLog(@"This is the first swizzled method");
        RSSWCallOriginal(result);
    }), RSSwizzleModeAlways, NULL);
    
    RSSwizzleInstanceMethod(TestModel.class,
                            @selector(superMethod:),
                            RSSWReturnType(void),
                            RSSWArguments(TestResult *result), RSSWReplacement({
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
        NSLog(@"This is the second swizzled method");
        RSSWCallOriginal(result);
    }), RSSwizzleModeAlways, NULL);
    
    TestModel *obj = [[TestModel alloc] init];
    TestResult *result = [[TestResult alloc] init];
    [obj superMethod:result];
        
    XCTAssert(result.isSubCMDWrong == false);
    XCTAssert(result.isSuperCMDWrong == false);
    XCTAssert(result.isSwizzledCMDWrong == false);
    NSArray<NSNumber *> *expected = @[@(ExecutedSwizzledMethodInSub),
                                      @(ExecutedSwizzledMethodInSub),
                                      @(ExecutedSuperMethod)];
    XCTAssert([result.objc_executedMethods isEqualToArray:expected]);
}

@end
