//
//  SwizzleWithoutCopyIMPTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 25/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class SwizzleWithoutCopyIMPTests: XCTestCase {

    // only super method + unsecure swizzling
    func testSuperMethod() {
        XCTAssert(swizzleSuperMethodUnsecureForSuperSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.superMethod(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }
    
    // only sub method + unsecure swizzling
    func testSubMethod() {
        XCTAssert(swizzleSubMethodUnsecureForSuperSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.subMethod(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .subMethod])
    }
    
    // in overrided method + unsecure swizzling
    func testOverridedMethod() {
        XCTAssert(swizzleOverridedMethodUnsecureForSuperSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.overridedMethod(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .subMethod, .superMethod])
    }
    
    // tedt "super object" with "superMethod" method
    func testSuperMethodWithSuperObject() {
        XCTAssert(swizzleSuperMethodUnsecureForSuperSwizzling() == true)
        
        let obj = TestSuperModel()
        let result = TestResult()
        obj.superMethod(result)
        XCTAssert(result.executedMethods == [.superMethod])
    }

}

func swizzleSuperMethodUnsecureForSuperSwizzling() -> Bool {
    swizzleNotSecureForSuper(class: TestModel.self,
                             originalSel: #selector(TestModel.superMethod(_:)),
                             swizzledSelector: #selector(TestModel._superMethod(_:)))
}

func swizzleSubMethodUnsecureForSuperSwizzling() -> Bool {
    swizzleNotSecureForSuper(class: TestModel.self,
                             originalSel: #selector(TestModel.subMethod(_:)),
                             swizzledSelector: #selector(TestModel._subMethod(_:)))
}

func swizzleOverridedMethodUnsecureForSuperSwizzling() -> Bool {
    swizzleNotSecureForSuper(class: TestModel.self,
                             originalSel: #selector(TestModel.overridedMethod(_:)),
                             swizzledSelector: #selector(TestModel._overridedMethod(_:)))
}

private func swizzleNotSecureForSuper(`class`: AnyClass, originalSel: Selector, swizzledSelector: Selector) -> Bool {
    // prepare
    guard let originalMethod = class_getInstanceMethod(`class`, originalSel) else {
        return false
    }
    guard let swizzledMethod = class_getInstanceMethod(`class`, swizzledSelector) else {
        return false
    }
    // swizzling
    method_exchangeImplementations(originalMethod, swizzledMethod)
    return true
}
