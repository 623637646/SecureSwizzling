//
//  SwizzleWithStaticFuncTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 25/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

private typealias MethodType = @convention(c) (AnyObject, Selector, TestResult) -> Void


class SwizzleWithStaticFuncTests: XCTestCase {
    
    // only super method + secure swizzling
    func testSuperMethod() {
        autoreleasepool {
            let block = {(self: AnyObject, _cmd: Selector, result: TestResult) in
                result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
                result.executedMethods.append(.swizzledSubMethod)
            } as MethodType
            let success = newSwizzleWithStaticFuncContext(theClass: TestModel.self,
                                                          original: #selector(TestModel.superMethod(_:)),
                                                          hookBlock: block)
            XCTAssert(success == true)
        }
        
        let e1 = XCTestExpectation()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            let obj = TestModel()
            let result = TestResult()
            obj.superMethod(result)
            
            XCTAssert(result.isSubCMDWrong == false)
            XCTAssert(result.isSuperCMDWrong == false)
            XCTAssert(result.isSwizzledCMDWrong == false)
            XCTAssert(result.executedMethods == [.swizzledSubMethod, .superMethod])
            
            e1.fulfill()
        }
        
        wait(for: [e1], timeout: 10)
        
    }
    
//    // only sub method + secure swizzling
//    func testSubMethod() {
//        let success = swizzleMethodForTestModel(theClass: TestModel.self,
//                                                original: #selector(TestModel.subMethod(_:)))
//        { (self: AnyObject, _cmd: Selector, result: TestResult) in
//            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "subMethod:"
//            result.executedMethods.append(.swizzledSubMethod)
//        }
//        XCTAssert(success == true)
//
//        let obj = TestModel()
//        let result = TestResult()
//        obj.subMethod(result)
//
//        XCTAssert(result.isSubCMDWrong == false)
//        XCTAssert(result.isSuperCMDWrong == false)
//        XCTAssert(result.isSwizzledCMDWrong == false)
//        XCTAssert(result.executedMethods == [.swizzledSubMethod, .subMethod])
//    }
//
//    // in overrided method + secure swizzling
//    func testOverridedMethod() {
//        let success = swizzleMethodForTestModel(theClass: TestModel.self,
//                                                original: #selector(TestModel.overridedMethod(_:)))
//        { (self: AnyObject, _cmd: Selector, result: TestResult) in
//            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "overridedMethod:"
//            result.executedMethods.append(.swizzledSubMethod)
//        }
//        XCTAssert(success == true)
//
//        let obj = TestModel()
//        let result = TestResult()
//        obj.overridedMethod(result)
//
//        XCTAssert(result.isSubCMDWrong == false)
//        XCTAssert(result.isSuperCMDWrong == false)
//        XCTAssert(result.isSwizzledCMDWrong == false)
//        XCTAssert(result.executedMethods == [.swizzledSubMethod, .subMethod, .superMethod])
//    }
//
//    // test "super object" with "superMethod" method
//    func testSuperObject() {
//        let success = swizzleMethodForTestModel(theClass: TestModel.self,
//                                                original: #selector(TestModel.superMethod(_:)))
//        { (self: AnyObject, _cmd: Selector, result: TestResult) in
//            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
//            result.executedMethods.append(.swizzledSubMethod)
//        }
//        XCTAssert(success == true)
//
//        let obj = TestSuperModel()
//        let result = TestResult()
//        obj.superMethod(result)
//        XCTAssert(result.executedMethods == [.superMethod])
//    }
//
//    // crash because Infinite loop
//    func testSwizzleSuperThenSub() {
//        let successForSuper = swizzleMethodForTestModel(theClass: TestSuperModel.self,
//                                                        original: #selector(TestSuperModel.superMethod(_:)))
//        { (self: AnyObject, _cmd: Selector, result: TestResult) in
//            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
//            result.executedMethods.append(.swizzledSuperMethod)
//        }
//        XCTAssert(successForSuper == true)
//
//        let successForSub = swizzleMethodForTestModel(theClass: TestModel.self,
//                                                      original: #selector(TestModel.superMethod(_:)))
//        { (self: AnyObject, _cmd: Selector, result: TestResult) in
//            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
//            result.executedMethods.append(.swizzledSubMethod)
//        }
//        XCTAssert(successForSub == true)
//
//        let obj = TestModel()
//        let result = TestResult()
//        obj.superMethod(result)
//
//        XCTAssert(result.isSubCMDWrong == false)
//        XCTAssert(result.isSuperCMDWrong == false)
//        XCTAssert(result.isSwizzledCMDWrong == false)
//        XCTAssert(result.executedMethods == [.swizzledSubMethod, .superMethod])
//    }
//
//    // sub swizzling not work
//    func testSwizzleSubThenSuper() {
//        let successForSub = swizzleMethodForTestModel(theClass: TestModel.self,
//                                                      original: #selector(TestModel.superMethod(_:)))
//        { (self: AnyObject, _cmd: Selector, result: TestResult) in
//            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
//            result.executedMethods.append(.swizzledSubMethod)
//        }
//        XCTAssert(successForSub == true)
//
//        let successForSuper = swizzleMethodForTestModel(theClass: TestSuperModel.self,
//                                                        original: #selector(TestSuperModel.superMethod(_:)))
//        { (self: AnyObject, _cmd: Selector, result: TestResult) in
//            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
//            result.executedMethods.append(.swizzledSuperMethod)
//        }
//        XCTAssert(successForSuper == true)
//
//        let obj = TestModel()
//        let result = TestResult()
//        obj.superMethod(result)
//
//        XCTAssert(result.isSubCMDWrong == false)
//        XCTAssert(result.isSuperCMDWrong == false)
//        XCTAssert(result.isSwizzledCMDWrong == false)
//        XCTAssert(result.executedMethods == [.swizzledSuperMethod, .superMethod])
//    }
    
}
