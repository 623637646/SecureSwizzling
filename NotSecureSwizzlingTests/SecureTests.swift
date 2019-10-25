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
    func test_onlySuper() {
        XCTAssert(swizzle_onlySuper_secureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResultModel()
        obj.onlySuper(result)
        
        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }
    
    // only self method + secure swizzling
    func test_onlySelf() {
        XCTAssert(swizzle_onlySelf_secureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResultModel()
        obj.onlySelf(result)
        
        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod])
    }
    
    // in both method + secure swizzling
    func test_inBoth() {
        XCTAssert(swizzle_inBoth_secureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResultModel()
        obj.inBoth(result)
        
        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod, .superMethod])
    }

}
