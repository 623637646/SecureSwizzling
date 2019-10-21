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
        var isCMDWrong: ObjCBool = false
        
        XCTAssert(obj.getMethodName(&isCMDWrong) == "getMethodName:")
        XCTAssert(isCMDWrong.boolValue == false)
        
        XCTAssert(obj._getMethodName(&isCMDWrong) == "_getMethodName:")
        XCTAssert(isCMDWrong.boolValue == false)
    }
    
    // inherited method + no-swizzling
    func testInheritedMethodWithoutSwizzling() {
        let obj = TestCMDModel()
        var isCMDWrong: ObjCBool = false
        
        XCTAssert(obj.getMethodName(inBase: &isCMDWrong) == "getMethodNameInBase:")
        XCTAssert(isCMDWrong.boolValue == false)
        
        XCTAssert(obj._getMethodName(inBase: &isCMDWrong) == "_getMethodNameInBase:")
        XCTAssert(isCMDWrong.boolValue == false)
    }
    
    // override method + unsafe swizzling
    func testOverrideMethodWithSwizzledCMDNotSecure() {
        XCTAssert(swizzle_CMDNotSecure(class: TestCMDModel.self,
                                       originalSel: #selector(TestCMDModel.getMethodName(_:)),
                                       swizzledSelector: #selector(TestCMDModel._getMethodName(_:))) == true)
        
        let obj = TestCMDModel()
        var isCMDWrong: ObjCBool = false
        XCTAssert(obj.getMethodName(&isCMDWrong) == "_getMethodName:")
        XCTAssert(isCMDWrong.boolValue == true)
        
        XCTAssert(obj._getMethodName(&isCMDWrong) == "getMethodName:")
        XCTAssert(isCMDWrong.boolValue == true)
    }
    
    // inherited method + unsafe swizzling
    func testInheritedMethodWithSwizzledCMDNotSecure() {
        XCTAssert(swizzle_CMDNotSecure(class: TestCMDModel.self,
                                       originalSel: #selector(TestCMDModel.getMethodName(inBase:)),
                                       swizzledSelector: #selector(TestCMDModel._getMethodName(inBase:))) == true)
        
        let obj = TestCMDModel()
        var isCMDWrong: ObjCBool = false
        XCTAssert(obj.getMethodName(inBase: &isCMDWrong) == "_getMethodNameInBase:")
        XCTAssert(isCMDWrong.boolValue == true)
        
        XCTAssert(obj._getMethodName(inBase: &isCMDWrong) == "getMethodNameInBase:")
        XCTAssert(isCMDWrong.boolValue == true)
    }
    
//    func testSwizzledCMDSecure() {
//        XCTAssert(swizzle_CMDSecure(class: TestCMDModel.self,
//                                    originalSel: #selector(TestCMDModel.getMethodName(_:)),
//                                    swizzledSelector: #selector(TestCMDModel._getMethodName(_:))) == true)
//
//        let obj = TestCMDModel()
//        var isCMDWrong: ObjCBool = false
//        XCTAssert(obj.getMethodName(&isCMDWrong) == "_getMethodName:")
//        XCTAssert(isCMDWrong.boolValue == false)
//
////        XCTAssert(obj._getMethodName(&isCMDWrong) == "getMethodName:")
////        XCTAssert(isCMDWrong.boolValue == false)
//    }

}
