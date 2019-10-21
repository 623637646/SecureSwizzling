//
//  CMDTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class CMDTests: XCTestCase {

    // normal method + no-swizzling
    func testNormalMethodWithoutSwizzling() {
        let obj = TestCMDModel()
        var isCMDWrong: ObjCBool = false
        
        XCTAssert(obj.getMethodName(inSubclass: &isCMDWrong) == "getMethodNameInSubclass:")
        XCTAssert(isCMDWrong.boolValue == false)
        
        XCTAssert(obj._getMethodName(inSubclass: &isCMDWrong) == "_getMethodNameInSubclass:")
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
    
    // override method + no-swizzling
    func testOverrideMethodWithoutSwizzling() {
        let obj = TestCMDModel()
        var isCMDWrong: ObjCBool = false
        
        XCTAssert(obj.getMethodName(inBoth: &isCMDWrong) == "getMethodNameInBoth:getMethodNameInBoth:")
        XCTAssert(isCMDWrong.boolValue == false)
        
        XCTAssert(obj._getMethodName(inBoth: &isCMDWrong) == "getMethodNameInBoth:_getMethodNameInBoth:")
        XCTAssert(isCMDWrong.boolValue == false)
    }
    
    // normal method + unsafe swizzling
    func testNormalMethodWithSwizzledCMDNotSecure() {
        XCTAssert(swizzle_CMDNotSecure(class: TestCMDModel.self,
                                       originalSel: #selector(TestCMDModel.getMethodName(inSubclass:)),
                                       swizzledSelector: #selector(TestCMDModel._getMethodName(inSubclass:))) == true)
        
        let obj = TestCMDModel()
        var isCMDWrong: ObjCBool = false
        XCTAssert(obj.getMethodName(inSubclass: &isCMDWrong) == "_getMethodNameInSubclass:")
        XCTAssert(isCMDWrong.boolValue == true) // MARK: It's wrong here
        
        XCTAssert(obj._getMethodName(inSubclass: &isCMDWrong) == "getMethodNameInSubclass:")
        XCTAssert(isCMDWrong.boolValue == true) // MARK: It's wrong here
    }
    
    // inherited method + unsafe swizzling
    func testInheritedMethodWithSwizzledCMDNotSecure() {
        XCTAssert(swizzle_CMDNotSecure(class: TestCMDModel.self,
                                       originalSel: #selector(TestCMDModel.getMethodName(inBase:)),
                                       swizzledSelector: #selector(TestCMDModel._getMethodName(inBase:))) == true)
        
        let obj = TestCMDModel()
        var isCMDWrong: ObjCBool = false
        XCTAssert(obj.getMethodName(inBase: &isCMDWrong) == "_getMethodNameInBase:")
        XCTAssert(isCMDWrong.boolValue == true) // MARK: It's wrong here
        
        XCTAssert(obj._getMethodName(inBase: &isCMDWrong) == "getMethodNameInBase:")
        XCTAssert(isCMDWrong.boolValue == true) // MARK: It's wrong here
    }
    
    // override method + unsafe swizzling
    func testOverrideMethodWithSwizzledCMDNotSecure() {
        XCTAssert(swizzle_CMDNotSecure(class: TestCMDModel.self,
                                       originalSel: #selector(TestCMDModel.getMethodName(inBoth:)),
                                       swizzledSelector: #selector(TestCMDModel._getMethodName(inBoth:))) == true)
        
        
        let obj = TestCMDModel()
        var isCMDWrong: ObjCBool = false
        XCTAssert(obj.getMethodName(inBoth: &isCMDWrong) == "getMethodNameInBoth:_getMethodNameInBoth:")
        XCTAssert(isCMDWrong.boolValue == true) // MARK: It's wrong here
        
        XCTAssert(obj._getMethodName(inBoth: &isCMDWrong) == "getMethodNameInBoth:getMethodNameInBoth:")
        XCTAssert(isCMDWrong.boolValue == true) // MARK: It's wrong here
    }
    
//    func testSwizzledCMDSecure() {
//        XCTAssert(swizzle_CMDSecure(class: TestCMDModel.self,
//                                    originalSel: #selector(TestCMDModel.getMethodNameInSubclass(_:)),
//                                    swizzledSelector: #selector(TestCMDModel._getMethodName(_:))) == true)
//
//        let obj = TestCMDModel()
//        var isCMDWrong: ObjCBool = false
//        XCTAssert(obj.getMethodNameInSubclass(&isCMDWrong) == "_getMethodName:")
//        XCTAssert(isCMDWrong.boolValue == false)
//
////        XCTAssert(obj._getMethodName(&isCMDWrong) == "getMethodNameInSubclass:")
////        XCTAssert(isCMDWrong.boolValue == false)
//    }

}
