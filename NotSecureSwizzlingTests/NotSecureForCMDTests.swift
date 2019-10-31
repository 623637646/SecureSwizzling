//
//  CMDNotSecureTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class CMDNotSecureTests: XCTestCase {
    
    // only super method + unsecure swizzling
    func testSuperMethod() {
        XCTAssert(swizzle_onlySuper_cmd_unsecureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.onlySuper(result)
        
        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.isSwizzledCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }
    
    // only self method + unsecure swizzling
    func testSelfMethod() {
        XCTAssert(swizzle_onlySelf_cmd_unsecureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.onlySelf(result)
        
        XCTAssert(result.isSelfCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod])
    }
    
    // in both method + unsecure swizzling
    func testOverridedMethod() {
        XCTAssert(swizzle_inBoth_cmd_unsecureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.inBoth(result)
        
        XCTAssert(result.isSelfCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod, .superMethod])
    }

}
