//
//  NoSwizzlingTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 25/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class NoSwizzlingTests: XCTestCase {
    
    // only super method + no-swizzling
    func testSuperMethod() {
        let obj = TestModel()
        let result = TestResult()
        obj.superMethod(result)
        
        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.superMethod])
    }

    // only self method + no-swizzling
    func testSubMethod() {
        let obj = TestModel()
        let result = TestResult()
        obj.subMethod(result)

        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.subMethod])
    }

    // in both method + no-swizzling
    func testOverridedMethod() {
        let obj = TestModel()
        let result = TestResult()
        obj.overridedMethod(result)

        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.subMethod, .superMethod])
    }

}
