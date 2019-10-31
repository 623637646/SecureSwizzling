//
//  SuperNotSecureTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 25/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class NotSecureForSuperTests: XCTestCase {

    // only super method + unsecure swizzling
    func testSuperMethod() {
        XCTAssert(swizzleSuperMethodUnsecureForSuperSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.superMethod(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }
    
    // only self method + unsecure swizzling
    func testSelfMethod() {
        XCTAssert(swizzleSelfMethodUnsecureForSuperSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.selfMethod(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod])
    }
    
    // in both method + unsecure swizzling
    func testOverridedMethod() {
        XCTAssert(swizzleOverridedMethodUnsecureForSuperSwizzling() == true)
        
        let obj = TestModel()
        let result = TestResult()
        obj.overridedMethod(result)
        
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod, .superMethod])
    }
    
    // tedt "super object" with "superMethod" method
    func testSuperMethodWithSuperObject() {
        XCTAssert(swizzleSuperMethodUnsecureForSuperSwizzling() == true)
        
        let obj = TestSuperModel()
        let result = TestResult()
        XCTAssertNoThrow(obj.superMethod(result))
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }

}
