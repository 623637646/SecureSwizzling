//
//  SecureTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 25/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class SecureTests: XCTestCase {
    
    // only super method + secure swizzling
    func testSuperMethod() {
        XCTAssert(swizzle_onlySuper_secureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.onlySuper(result)
        
        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }
    
    // only self method + secure swizzling
    func testSelfMethod() {
        XCTAssert(swizzle_onlySelf_secureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.onlySelf(result)
        
        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod])
    }
    
    // in both method + secure swizzling
    func testOverridedMethod() {
        XCTAssert(swizzle_inBoth_secureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.inBoth(result)
        
        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod, .superMethod])
    }

}
