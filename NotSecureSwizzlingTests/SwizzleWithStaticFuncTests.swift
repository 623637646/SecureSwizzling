//
//  SwizzleWithStaticFuncTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 25/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class SwizzleWithStaticFuncTests: XCTestCase {
    
    // only super method + secure swizzling
    func testSuperMethod() {
        let success = swizzleMethodForTestModel(theClass: TestModel.self,
                                                original: #selector(TestModel.superMethod(_:)))
        { (self: AnyObject, _cmd: Selector, result: TestResult) in
            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
            result.executedMethods.append(.swizzledSubMethod)
        }
        XCTAssert(success == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.superMethod(result)
        
        XCTAssert(result.isSubCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledSubMethod, .superMethod])
    }
    
    // only sub method + secure swizzling
    func testSubMethod() {
        let success = swizzleMethodForTestModel(theClass: TestModel.self,
                                                original: #selector(TestModel.subMethod(_:)))
        { (self: AnyObject, _cmd: Selector, result: TestResult) in
            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "subMethod:"
            result.executedMethods.append(.swizzledSubMethod)
        }
        XCTAssert(success == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.subMethod(result)
        
        XCTAssert(result.isSubCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledSubMethod, .subMethod])
    }
    
    // in overrided method + secure swizzling
    func testOverridedMethod() {
        let success = swizzleMethodForTestModel(theClass: TestModel.self,
                                                original: #selector(TestModel.overridedMethod(_:)))
        { (self: AnyObject, _cmd: Selector, result: TestResult) in
            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "overridedMethod:"
            result.executedMethods.append(.swizzledSubMethod)
        }
        XCTAssert(success == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.overridedMethod(result)
        
        XCTAssert(result.isSubCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledSubMethod, .subMethod, .superMethod])
    }
    
    // test "super object" with "superMethod" method
    func testSuperObject() {
        let success = swizzleMethodForTestModel(theClass: TestModel.self,
                                                original: #selector(TestModel.superMethod(_:)))
        { (self: AnyObject, _cmd: Selector, result: TestResult) in
            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
            result.executedMethods.append(.swizzledSubMethod)
        }
        XCTAssert(success == true)
        
        let obj = TestSuperModel()
        let result = TestResult()
        obj.superMethod(result)
        XCTAssert(result.executedMethods == [.superMethod])
    }
    
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

private typealias MethodType = @convention(c) (AnyObject, Selector, TestResult) -> Void

private var originalIMPPointer: UnsafeMutablePointer<IMP?> = {
    let pointer = UnsafeMutablePointer<IMP?>.allocate(capacity: 1)
    pointer.initialize(to: nil)
    return pointer
}()

private let replacementIMP: IMP = unsafeBitCast({
    (self: AnyObject, _cmd: Selector, result: TestResult) in
    IMPCallBackFunc?(self, _cmd, result)
    originalIMPPointer.withMemoryRebound(to: MethodType?.self, capacity: 1) { (pointer) -> Void in
        pointer.pointee?(self, _cmd, result)
    }
} as MethodType, to: IMP.self)

private var IMPCallBackFunc: ((_ self: AnyObject, _ _cmd: Selector, _ result: TestResult)->())? = nil


// MARK: utilities

private func swizzleMethodForTestModel(theClass: AnyClass,
                                       original: Selector,
                                       replacement: @escaping ((_ self: AnyObject, _ _cmd: Selector, _ result: TestResult) -> Void)) -> Bool {
    IMPCallBackFunc = replacement
    return swizzleMethodWithStaticFunc(theClass: theClass,
                                       original: original,
                                       replacement: replacementIMP,
                                       store: originalIMPPointer)
}

private func swizzleMethodWithStaticFunc(theClass: AnyClass, original: Selector, replacement: IMP, store: UnsafeMutablePointer<IMP?>) -> Bool {
    guard let originalMethod = class_getInstanceMethod(theClass, original) else {
        return false
    }
    let originalTypeEncoding = method_getTypeEncoding(originalMethod)
    var originalIMP = class_replaceMethod(theClass, original, replacement, originalTypeEncoding)
    if originalIMP == nil {
        originalIMP = method_getImplementation(originalMethod)
    }
    guard let impNotNil = originalIMP else {
        return false
    }
    store.pointee = impNotNil
    return true
}
