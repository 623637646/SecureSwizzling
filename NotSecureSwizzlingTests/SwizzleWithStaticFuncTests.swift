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
        IMPCallBackFunc = { (self: AnyObject, _cmd: Selector, result: TestResult) in
            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
            result.executedMethods.append(.swizzledMethodInSub)
        }
        let success = swizzleMethodWithStaticFunc(theClass: TestModel.self,
                                                  original: #selector(TestModel.superMethod(_:)),
                                                  replacement: replacementIMP,
                                                  store: originalIMPPointer)
        XCTAssert(success == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.superMethod(result)
        
        XCTAssert(result.isSubCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethodInSub, .superMethod])
    }
    
    // only sub method + secure swizzling
    func testSubMethod() {
        IMPCallBackFunc = { (self: AnyObject, _cmd: Selector, result: TestResult) in
            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "subMethod:"
            result.executedMethods.append(.swizzledMethodInSub)
        }
        let success = swizzleMethodWithStaticFunc(theClass: TestModel.self,
                                                  original: #selector(TestModel.subMethod(_:)),
                                                  replacement: replacementIMP,
                                                  store: originalIMPPointer)
        XCTAssert(success == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.subMethod(result)
        
        XCTAssert(result.isSubCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethodInSub, .subMethod])
    }
    
    // in overrided method + secure swizzling
    func testOverridedMethod() {
        IMPCallBackFunc = { (self: AnyObject, _cmd: Selector, result: TestResult) in
            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "overridedMethod:"
            result.executedMethods.append(.swizzledMethodInSub)
        }
        let success = swizzleMethodWithStaticFunc(theClass: TestModel.self,
                                                  original: #selector(TestModel.overridedMethod(_:)),
                                                  replacement: replacementIMP,
                                                  store: originalIMPPointer)
        XCTAssert(success == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.overridedMethod(result)
        
        XCTAssert(result.isSubCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethodInSub, .subMethod, .superMethod])
    }
    
    // test "super object" with "superMethod" method
    func testSuperObject() {
        IMPCallBackFunc = { (self: AnyObject, _cmd: Selector, result: TestResult) in
            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
            result.executedMethods.append(.swizzledMethodInSub)
        }
        let success = swizzleMethodWithStaticFunc(theClass: TestModel.self,
                                                  original: #selector(TestModel.superMethod(_:)),
                                                  replacement: replacementIMP,
                                                  store: originalIMPPointer)
        XCTAssert(success == true)
        
        let obj = TestSuperModel()
        let result = TestResult()
        obj.superMethod(result)
        XCTAssert(result.executedMethods == [.superMethod])
    }
    
    func testSwizzleSuperThenSub() {
        IMPCallBackFuncForSuper = { (self: AnyObject, _cmd: Selector, result: TestResult) in
            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
            result.executedMethods.append(.swizzledMethodInSuper)
        }
        let successForSuper = swizzleMethodWithStaticFunc(theClass: TestSuperModel.self,
                                                          original: #selector(TestSuperModel.superMethod(_:)),
                                                          replacement: replacementIMPForSuper,
                                                          store: originalIMPPointerForSuper)
        XCTAssert(successForSuper == true)
        
        IMPCallBackFunc = { (self: AnyObject, _cmd: Selector, result: TestResult) in
            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
            result.executedMethods.append(.swizzledMethodInSub)
        }
        let success = swizzleMethodWithStaticFunc(theClass: TestModel.self,
                                                  original: #selector(TestModel.superMethod(_:)),
                                                  replacement: replacementIMP,
                                                  store: originalIMPPointer)
        XCTAssert(success == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.superMethod(result)
        
        XCTAssert(result.isSubCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethodInSub, .swizzledMethodInSuper, .superMethod])
    }
    
    func testSwizzleSubThenSuper() {
        IMPCallBackFunc = { (self: AnyObject, _cmd: Selector, result: TestResult) in
            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
            result.executedMethods.append(.swizzledMethodInSub)
        }
        let success = swizzleMethodWithStaticFunc(theClass: TestModel.self,
                                                  original: #selector(TestModel.superMethod(_:)),
                                                  replacement: replacementIMP,
                                                  store: originalIMPPointer)
        XCTAssert(success == true)
        
        IMPCallBackFuncForSuper = { (self: AnyObject, _cmd: Selector, result: TestResult) in
            result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) != "superMethod:"
            result.executedMethods.append(.swizzledMethodInSuper)
        }
        let successForSuper = swizzleMethodWithStaticFunc(theClass: TestSuperModel.self,
                                                          original: #selector(TestSuperModel.superMethod(_:)),
                                                          replacement: replacementIMPForSuper,
                                                          store: originalIMPPointerForSuper)
        XCTAssert(successForSuper == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.superMethod(result)
        
        XCTAssert(result.isSubCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        // MARK: It's wrong here, should be [.swizzledMethodInSub, .swizzledMethodInSuper, .superMethod]
        XCTAssert(result.executedMethods == [.swizzledMethodInSub, .superMethod])
    }
    
}

private typealias MethodType = @convention(c) (AnyObject, Selector, TestResult) -> Void

// For sub model

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


// For super model

private var originalIMPPointerForSuper: UnsafeMutablePointer<IMP?> = {
    let pointer = UnsafeMutablePointer<IMP?>.allocate(capacity: 1)
    pointer.initialize(to: nil)
    return pointer
}()

private let replacementIMPForSuper: IMP = unsafeBitCast({
    (self: AnyObject, _cmd: Selector, result: TestResult) in
    IMPCallBackFuncForSuper?(self, _cmd, result)
    originalIMPPointerForSuper.withMemoryRebound(to: MethodType?.self, capacity: 1) { (pointer) -> Void in
        pointer.pointee?(self, _cmd, result)
    }
} as MethodType, to: IMP.self)

private var IMPCallBackFuncForSuper: ((_ self: AnyObject, _ _cmd: Selector, _ result: TestResult)->())? = nil


// MARK: utilities

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
