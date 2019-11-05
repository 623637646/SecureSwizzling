//
//  SwizzleWithCopyIMPTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class SwizzleWithCopyIMPTests: XCTestCase {
    
    // only super method + unsecure swizzling
    func testSuperMethod() {
        XCTAssert(swizzleWithCopyIMP(class: TestModel.self,
                                     originalSel: #selector(TestModel.superMethod(_:)),
                                     swizzledSelector: #selector(TestModel._superMethod(_:))) == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.superMethod(result)
        
        XCTAssert(result.isSubCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.isSwizzledCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }
    
    // only sub method + unsecure swizzling
    func testSubMethod() {
        XCTAssert(swizzleWithCopyIMP(class: TestModel.self,
                                     originalSel: #selector(TestModel.subMethod(_:)),
                                     swizzledSelector: #selector(TestModel._subMethod(_:))) == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.subMethod(result)
        
        XCTAssert(result.isSubCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.executedMethods == [.swizzledMethod, .subMethod])
    }
    
    // in overrided method + unsecure swizzling
    func testOverridedMethod() {
        XCTAssert(swizzleWithCopyIMP(class: TestModel.self,
                                     originalSel: #selector(TestModel.overridedMethod(_:)),
                                     swizzledSelector: #selector(TestModel._overridedMethod(_:))) == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.overridedMethod(result)
        
        XCTAssert(result.isSubCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.executedMethods == [.swizzledMethod, .subMethod, .superMethod])
    }
    
    // test "super object" with "superMethod" method
    func testSuperObject() {
        XCTAssert(swizzleWithCopyIMP(class: TestModel.self,
                                     originalSel: #selector(TestModel.superMethod(_:)),
                                     swizzledSelector: #selector(TestModel._superMethod(_:))) == true)
        
        let obj = TestSuperModel()
        let result = TestResult()
        obj.superMethod(result)
        XCTAssert(result.executedMethods == [.superMethod])
    }
    
}

private func swizzleWithCopyIMP(`class`: AnyClass, originalSel: Selector, swizzledSelector: Selector) -> Bool {
    // prepare
    guard let originalMethod = class_getInstanceMethod(`class`, originalSel) else {
        return false
    }
    guard let swizzledMethod = class_getInstanceMethod(`class`, swizzledSelector) else {
        return false
    }
    let originalIMP = method_getImplementation(originalMethod)
    let swizzledIMP = method_getImplementation(swizzledMethod)
    let originalTypeEncoding = method_getTypeEncoding(originalMethod)
    let swizzledEncoding = method_getTypeEncoding(swizzledMethod)
    
    // swizzling
    if class_addMethod(`class`, originalSel, swizzledIMP, swizzledEncoding) {
        class_replaceMethod(`class`, swizzledSelector, originalIMP, originalTypeEncoding)
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    return true
}
