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
    func testSuperMethod() {
        XCTAssert(swizzle_onlySuper_super_unsecureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.onlySuper(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }
    
    // only self method + unsecure swizzling
    func testSelfMethod() {
        XCTAssert(swizzle_onlySelf_super_unsecureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.onlySelf(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod])
    }
    
    // in both method + unsecure swizzling
    func testOverridedMethod() {
        XCTAssert(swizzle_inBoth_super_unsecureSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.inBoth(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod, .superMethod])
    }
    
    // tedt "super object" with "onlySuper" method
    func test_superObject_onlySuper() {
        XCTAssert(swizzle_onlySuper_super_unsecureSwizzling() == true)
        
        let obj = TestSuperModel()
        let result = TestResult()
        XCTAssertNoThrow(obj.onlySuper(result))
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }

}
