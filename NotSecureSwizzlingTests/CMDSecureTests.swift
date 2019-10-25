//
//  CMDSecureTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 25/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class CMDSecureTests: XCTestCase {
    
    // only super method + secure swizzling
    func test_onlySuper_secureSwizzling() {
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
    func test_onlySelf_secureSwizzling() {
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
    func test_inBoth_secureSwizzling() {
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
