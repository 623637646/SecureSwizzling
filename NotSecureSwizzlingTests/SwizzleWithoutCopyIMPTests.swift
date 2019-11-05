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
        XCTAssert(swizzleSuperMethodWithoutCopyIMP() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.superMethod(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }
    
    // only sub method + unsecure swizzling
    func testSubMethod() {
        XCTAssert(swizzleSubMethodWithoutCopyIMP() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.subMethod(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .subMethod])
    }
    
    // in overrided method + unsecure swizzling
    func testOverridedMethod() {
        XCTAssert(swizzleOverridedMethodWithoutCopyIMP() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.overridedMethod(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .subMethod, .superMethod])
    }
    
    // test "super object" with "superMethod" method
    func testSuperObject() {
        XCTAssert(swizzleSuperMethodWithoutCopyIMP() == true)
        
        let obj = TestSuperModel()
        let result = TestResult()
        obj.superMethod(result)
        XCTAssert(result.executedMethods == [.superMethod])
    }

}

private func swizzleSuperMethodWithoutCopyIMP() -> Bool {
    swizzleWithoutCopyIMP(class: TestModel.self,
                             originalSel: #selector(TestModel.superMethod(_:)),
                             swizzledSelector: #selector(TestModel._superMethod(_:)))
}

private func swizzleSubMethodWithoutCopyIMP() -> Bool {
    swizzleWithoutCopyIMP(class: TestModel.self,
                             originalSel: #selector(TestModel.subMethod(_:)),
                             swizzledSelector: #selector(TestModel._subMethod(_:)))
}

private func swizzleOverridedMethodWithoutCopyIMP() -> Bool {
    swizzleWithoutCopyIMP(class: TestModel.self,
                             originalSel: #selector(TestModel.overridedMethod(_:)),
                             swizzledSelector: #selector(TestModel._overridedMethod(_:)))
}

private func swizzleWithoutCopyIMP(`class`: AnyClass, originalSel: Selector, swizzledSelector: Selector) -> Bool {
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
