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
    func test_onlySuper() {
        let obj = TestModel()
        let result = TestResultModel()
        obj.onlySuper(result)
        
        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.superMethod])
    }

    // only self method + no-swizzling
    func test_onlySelf() {
        let obj = TestModel()
        let result = TestResultModel()
        obj.onlySelf(result)

        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.selfMethod])
    }

    // in both method + no-swizzling
    func test_inBoth() {
        let obj = TestModel()
        let result = TestResultModel()
        obj.inBoth(result)

        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.selfMethod, .superMethod])
    }

}
