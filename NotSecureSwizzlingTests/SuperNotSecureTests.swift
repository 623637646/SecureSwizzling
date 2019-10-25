//
//  SuperNotSecureTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 25/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class SuperNotSecureTests: XCTestCase {

    // only super method + unsecure swizzling
    func test_onlySuper() {
        XCTAssert(swizzle_onlySuper_super_unsecureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResultModel()
        obj.onlySuper(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }
    
    // only self method + unsecure swizzling
    func test_onlySelf() {
        XCTAssert(swizzle_onlySelf_super_unsecureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResultModel()
        obj.onlySelf(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod])
    }
    
    // in both method + unsecure swizzling
    func test_inBoth() {
        XCTAssert(swizzle_inBoth_super_unsecureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResultModel()
        obj.inBoth(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod, .superMethod])
    }
    
    // tedt "super object" with "onlySuper" method
    func test_superObject_onlySuper() {
        XCTAssert(swizzle_onlySuper_super_unsecureSwizzling() == true)
        
        let obj = TestSuperModel()
        let result = TestResultModel()
        XCTAssertNoThrow(obj.onlySuper(result))
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }

}
