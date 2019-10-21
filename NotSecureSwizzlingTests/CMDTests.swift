//
//  CMDTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class CMDTests: XCTestCase {

    func testNormalMethod() {
        let obj = TestCMDModel()
        var isCMDAndMethodEqual: ObjCBool = false
        XCTAssert(obj.getMethodName(&isCMDAndMethodEqual) == "getMethodName:")
        XCTAssert(isCMDAndMethodEqual.boolValue == true)
        
        XCTAssert(obj._getMethodName(&isCMDAndMethodEqual) == "_getMethodName:")
        XCTAssert(isCMDAndMethodEqual.boolValue == true)
    }
    
    func testSwizzledCMDNotSecure() {
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
    
    func testSwizzledCMDSecure() {
        XCTAssert(swizzle_CMDSecure(class: TestCMDModel.self,
                                    originalSel: #selector(TestCMDModel.getMethodName(_:)),
                                    swizzledSelector: #selector(TestCMDModel._getMethodName(_:))) == true)
        
        let obj = TestCMDModel()
        var isCMDAndMethodEqual: ObjCBool = false
        XCTAssert(obj.getMethodName(&isCMDAndMethodEqual) == "_getMethodName:")
        XCTAssert(isCMDAndMethodEqual.boolValue == true)
        
        XCTAssert(obj._getMethodName(&isCMDAndMethodEqual) == "getMethodName:")
        XCTAssert(isCMDAndMethodEqual.boolValue == true)
    }

}
