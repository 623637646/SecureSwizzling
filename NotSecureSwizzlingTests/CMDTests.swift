//
//  CMDTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class CMDTests: XCTestCase {

    // override method + no-swizzling
    func testOverrideMethodWithoutSwizzling() {
        let obj = TestCMDModel()
        var isCMDAndMethodEqual: ObjCBool = false
        
        XCTAssert(obj.getMethodName(&isCMDAndMethodEqual) == "getMethodName:")
        XCTAssert(isCMDAndMethodEqual.boolValue == true)
        
        XCTAssert(obj._getMethodName(&isCMDAndMethodEqual) == "_getMethodName:")
        XCTAssert(isCMDAndMethodEqual.boolValue == true)
    }
    
    // inherited method + no-swizzling
    func testInheritedMethodWithoutSwizzling() {
        let obj = TestCMDModel()
        var isCMDAndMethodEqual: ObjCBool = false
        
        XCTAssert(obj.getMethodName(inBase: &isCMDAndMethodEqual) == "getMethodNameInBase:")
        XCTAssert(isCMDAndMethodEqual.boolValue == true)
        
        XCTAssert(obj._getMethodName(inBase: &isCMDAndMethodEqual) == "_getMethodNameInBase:")
        XCTAssert(isCMDAndMethodEqual.boolValue == true)
    }
    
    // override method + unsafe swizzling
    func testOverrideMethodWithSwizzledCMDNotSecure() {
        XCTAssert(swizzle_CMDNotSecure(class: TestCMDModel.self,
                                       originalSel: #selector(TestCMDModel.getMethodName(_:)),
                                       swizzledSelector: #selector(TestCMDModel._getMethodName(_:))) == true)
        
        let obj = TestCMDModel()
        var isCMDAndMethodEqual: ObjCBool = false
        XCTAssert(obj.getMethodName(&isCMDAndMethodEqual) == "_getMethodName:")
        XCTAssert(isCMDAndMethodEqual.boolValue == false)
        
        XCTAssert(obj._getMethodName(&isCMDAndMethodEqual) == "getMethodName:")
        XCTAssert(isCMDAndMethodEqual.boolValue == false)
    }
    
    // inherited method + unsafe swizzling
    func testInheritedMethodWithSwizzledCMDNotSecure() {
        XCTAssert(swizzle_CMDNotSecure(class: TestCMDModel.self,
                                       originalSel: #selector(TestCMDModel.getMethodName(inBase:)),
                                       swizzledSelector: #selector(TestCMDModel._getMethodName(inBase:))) == true)
        
        let obj = TestCMDModel()
        var isCMDAndMethodEqual: ObjCBool = false
        XCTAssert(obj.getMethodName(inBase: &isCMDAndMethodEqual) == "_getMethodNameInBase:")
        XCTAssert(isCMDAndMethodEqual.boolValue == false)
        
        XCTAssert(obj._getMethodName(inBase: &isCMDAndMethodEqual) == "getMethodNameInBase:")
        XCTAssert(isCMDAndMethodEqual.boolValue == false)
    }
    
//    func testSwizzledCMDSecure() {
//        XCTAssert(swizzle_CMDSecure(class: TestCMDModel.self,
//                                    originalSel: #selector(TestCMDModel.getMethodName(_:)),
//                                    swizzledSelector: #selector(TestCMDModel._getMethodName(_:))) == true)
//
//        let obj = TestCMDModel()
//        var isCMDAndMethodEqual: ObjCBool = false
//        XCTAssert(obj.getMethodName(&isCMDAndMethodEqual) == "_getMethodName:")
//        XCTAssert(isCMDAndMethodEqual.boolValue == true)
//
//        XCTAssert(obj._getMethodName(&isCMDAndMethodEqual) == "getMethodName:")
//        XCTAssert(isCMDAndMethodEqual.boolValue == true)
//    }

}
