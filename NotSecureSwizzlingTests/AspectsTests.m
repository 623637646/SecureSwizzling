//
//  AspectsTests.m
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 6/11/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Aspects.h"
#import "TestModel.h"
#import "NotSecureSwizzlingTests-Swift.h"
@interface AspectsTests : XCTestCase

@end

@implementation AspectsTests

- (void)testSuperMethod
{
    NSError *error = nil;
    [TestModel aspect_hookSelector:@selector(superMethod:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info, TestResult *result){
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
    } error:&error];
    XCTAssert(error == nil);
    
    TestModel *obj = [[TestModel alloc] init];
    TestResult *result = [[TestResult alloc] init];
    [obj superMethod:result];
        
    XCTAssert(result.isSubCMDWrong == false);
    XCTAssert(result.isSuperCMDWrong == true); // MARK: It's wrong here
    XCTAssert(result.isSwizzledCMDWrong == false);
    NSArray<NSNumber *> *expected = @[@(ExecutedSwizzledMethodInSub), @(ExecutedSuperMethod)];
    XCTAssert([result.objc_executedMethods isEqualToArray:expected]);
}

- (void)testSubMethod
{
    NSError *error = nil;
    [TestModel aspect_hookSelector:@selector(subMethod:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info, TestResult *result){
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
    } error:&error];
    XCTAssert(error == nil);

    TestModel *obj = [[TestModel alloc] init];
    TestResult *result = [[TestResult alloc] init];
    [obj subMethod:result];

    XCTAssert(result.isSubCMDWrong == true);// MARK: It's wrong here
    XCTAssert(result.isSuperCMDWrong == false);
    XCTAssert(result.isSwizzledCMDWrong == false);
    NSArray<NSNumber *> *expected = @[@(ExecutedSwizzledMethodInSub), @(ExecutedSubMethod)];
    XCTAssert([result.objc_executedMethods isEqualToArray:expected]);
}

- (void)testOverridedMethod
{
    NSError *error = nil;
    [TestModel aspect_hookSelector:@selector(overridedMethod:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info, TestResult *result){
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
    } error:&error];
    XCTAssert(error == nil);

    TestModel *obj = [[TestModel alloc] init];
    TestResult *result = [[TestResult alloc] init];
    [obj overridedMethod:result];

    XCTAssert(result.isSubCMDWrong == true);// MARK: It's wrong here
    XCTAssert(result.isSuperCMDWrong == false);
    XCTAssert(result.isSwizzledCMDWrong == false);
    NSArray<NSNumber *> *expected = @[@(ExecutedSwizzledMethodInSub),
                                      @(ExecutedSubMethod),
                                      @(ExecutedSuperMethod)];
    XCTAssert([result.objc_executedMethods isEqualToArray:expected]);
}

- (void)testSuperObject
{
    NSError *error = nil;
    [TestModel aspect_hookSelector:@selector(superMethod:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info, TestResult *result){
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
    } error:&error];
    XCTAssert(error == nil);

    TestSuperModel *obj = [[TestSuperModel alloc] init];
    TestResult *result = [[TestResult alloc] init];
    [obj superMethod:result];

    XCTAssert(result.isSubCMDWrong == false);
    XCTAssert(result.isSuperCMDWrong == false);
    XCTAssert(result.isSwizzledCMDWrong == false);
    NSArray<NSNumber *> *expected = @[@(ExecutedSuperMethod)];
    XCTAssert([result.objc_executedMethods isEqualToArray:expected]);
}

// don't support
- (void)testSwizzleSuperThenSub
{
    NSError *error = nil;
    [TestSuperModel aspect_hookSelector:@selector(superMethod:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info, TestResult *result){
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSuper)];
    } error:&error];
    XCTAssert(error == nil);
    
    [TestModel aspect_hookSelector:@selector(superMethod:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info, TestResult *result){
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
    } error:&error];
    XCTAssert(error != nil);
}

// don't support
- (void)testSwizzleSubThenSuper
{
    NSError *error = nil;
    [TestModel aspect_hookSelector:@selector(superMethod:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info, TestResult *result){
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSub)];
    } error:&error];
    XCTAssert(error == nil);
    
    [TestSuperModel aspect_hookSelector:@selector(superMethod:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info, TestResult *result){
        result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethodInSuper)];
    } error:&error];
    XCTAssert(error != nil);
}

@end
