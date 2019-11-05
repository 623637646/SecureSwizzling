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
        XCTAssert(onlySuperMethodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1) { (pointer) -> Bool in
            return swizzleMethodWithStaticFunc(theClass: TestModel.self,
                                               original: #selector(TestModel.superMethod(_:)),
                                               replacement: unsafeBitCast(onlySuperMethodSwizzled, to: IMP.self),
                                               store: pointer)
            } == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.superMethod(result)
        
        XCTAssert(result.isSubCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }
    
    // only sub method + secure swizzling
    func testSubMethod() {
        XCTAssert(onlySubMethodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1) { (pointer) -> Bool in
            return swizzleMethodWithStaticFunc(theClass: TestModel.self,
                                               original: #selector(TestModel.subMethod(_:)),
                                               replacement: unsafeBitCast(onlySubMethodSwizzled, to: IMP.self),
                                               store: pointer)
            } == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.subMethod(result)
        
        XCTAssert(result.isSubCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethod, .subMethod])
    }
    
    // in overrided method + secure swizzling
    func testOverridedMethod() {
        XCTAssert(overridedMethodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1) { (pointer) -> Bool in
            return swizzleMethodWithStaticFunc(theClass: TestModel.self,
                                               original: #selector(TestModel.overridedMethod(_:)),
                                               replacement: unsafeBitCast(overridedMethodSwizzled, to: IMP.self),
                                               store: pointer)
            } == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.overridedMethod(result)
        
        XCTAssert(result.isSubCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethod, .subMethod, .superMethod])
    }
    
    // test "super object" with "superMethod" method
    func testSuperObject() {
        XCTAssert(onlySuperMethodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1) { (pointer) -> Bool in
            return swizzleMethodWithStaticFunc(theClass: TestModel.self,
                                               original: #selector(TestModel.superMethod(_:)),
                                               replacement: unsafeBitCast(onlySuperMethodSwizzled, to: IMP.self),
                                               store: pointer)
            } == true)
        
        let obj = TestSuperModel()
        let result = TestResult()
        obj.superMethod(result)
        XCTAssert(result.executedMethods == [.superMethod])
    }
    
    func testSwizzleSubAndSuper() {
        
    }
    
}

private typealias MethodType = @convention(c) (AnyObject, Selector, TestResult) -> Void

// MARK: only super

private var onlySuperMethodOriginal: UnsafeMutablePointer<MethodType?> = {
    let pointer = UnsafeMutablePointer<MethodType?>.allocate(capacity: 1)
    pointer.initialize(to: nil)
    return pointer
}()

private let onlySuperMethodSwizzled: MethodType = {
    (self: AnyObject, _cmd: Selector, result: TestResult) in
    result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) == "_superMethod:"
    result.executedMethods.append(.swizzledMethod)
    onlySuperMethodOriginal.pointee?(`self`, _cmd, result)
}

// MARK: only sub

private var onlySubMethodOriginal: UnsafeMutablePointer<MethodType?> = {
    let pointer = UnsafeMutablePointer<MethodType?>.allocate(capacity: 1)
    pointer.initialize(to: nil)
    return pointer
}()

private let onlySubMethodSwizzled: MethodType = {
    (self: AnyObject, _cmd: Selector, result: TestResult) in
    result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) == "_subMethod:"
    result.executedMethods.append(.swizzledMethod)
    onlySubMethodOriginal.pointee?(`self`, _cmd, result)
}

// MARK: overrided

private var overridedMethodOriginal: UnsafeMutablePointer<MethodType?> = {
    let pointer = UnsafeMutablePointer<MethodType?>.allocate(capacity: 1)
    pointer.initialize(to: nil)
    return pointer
}()

private let overridedMethodSwizzled: MethodType = {
    (self: AnyObject, _cmd: Selector, result: TestResult) in
    result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) == "_overridedMethod:"
    result.executedMethods.append(.swizzledMethod)
    overridedMethodOriginal.pointee?(`self`, _cmd, result)
}

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
