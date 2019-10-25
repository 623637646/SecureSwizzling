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
    func test_onlySuper_unsecureSwizzling() {
        XCTAssert(swizzle_onlySuper_unsecureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResultModel()
        obj.onlySuper(result)
        
        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.isSwizzledCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }
    
    // only self method + unsecure swizzling
    func test_onlySelf_unsecureSwizzling() {
        XCTAssert(swizzle_onlySelf_unsecureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResultModel()
        obj.onlySelf(result)
        
        XCTAssert(result.isSelfCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod])
    }
    
    // in both method + unsecure swizzling
    func test_inBoth_unsecureSwizzling() {
        XCTAssert(swizzle_inBoth_unsecureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResultModel()
        obj.inBoth(result)
        
        XCTAssert(result.isSelfCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod, .superMethod])
    }

}
