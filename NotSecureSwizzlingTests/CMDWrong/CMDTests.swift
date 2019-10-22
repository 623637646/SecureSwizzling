//
//  CMDTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class CMDTests: XCTestCase {
    
    // MARK: No Swizzling
    
    // only super method + no-swizzling
    func test_onlySuper_noSwizzling() {
        let obj = TestCMDModel()
        let result = TestCMDResult()
        obj.onlySuper(result)
        
        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.superMethod])
    }

    // only self method + no-swizzling
    func test_onlySelf_noSwizzling() {
        let obj = TestCMDModel()
        let result = TestCMDResult()
        obj.onlySelf(result)

        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.selfMethod])
    }

    // in both method + no-swizzling
    func test_inBoth_noSwizzling() {
        let obj = TestCMDModel()
        let result = TestCMDResult()
        obj.inBoth(result)

        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.selfMethod, .superMethod])
    }
    
    // MARK: Unsecure Swizzling
    
    // only super method + unsecure swizzling
    func test_onlySuper_unsecureSwizzling() {
        XCTAssert(swizzle_CMDNotSecure(class: TestCMDModel.self,
                                       originalSel: #selector(TestCMDModel.onlySuper(_:)),
                                       swizzledSelector: #selector(TestCMDModel._onlySuper(_:))) == true)
        
        let obj = TestCMDModel()
        let result = TestCMDResult()
        obj.onlySuper(result)
        
        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.isSwizzledCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }
    
    // only self method + unsecure swizzling
    func test_onlySelf_unsecureSwizzling() {
        XCTAssert(swizzle_CMDNotSecure(class: TestCMDModel.self,
                                       originalSel: #selector(TestCMDModel.onlySelf(_:)),
                                       swizzledSelector: #selector(TestCMDModel._onlySelf(_:))) == true)
        
        let obj = TestCMDModel()
        let result = TestCMDResult()
        obj.onlySelf(result)
        
        XCTAssert(result.isSelfCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod])
    }
    
    // in both method + unsecure swizzling
    func test_inBoth_unsecureSwizzling() {
        XCTAssert(swizzle_CMDNotSecure(class: TestCMDModel.self,
                                       originalSel: #selector(TestCMDModel.inBoth(_:)),
                                       swizzledSelector: #selector(TestCMDModel._(inBoth:))) == true)
        
        let obj = TestCMDModel()
        let result = TestCMDResult()
        obj.inBoth(result)
        
        XCTAssert(result.isSelfCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == true) // MARK: It's wrong here
        XCTAssert(result.executedMethods == [.swizzledMethod, .selfMethod, .superMethod])
    }

    // MARK: Secure Swizzling
    
    // only super method + secure swizzling
    func test_onlySuper_secureSwizzling() {
        
        doit()
        
        let obj = TestCMDModel()
        let result = TestCMDResult()
        obj.onlySuper(result)
        
        XCTAssert(result.isSelfCMDWrong == false)
        XCTAssert(result.isSuperCMDWrong == false)
        XCTAssert(result.isSwizzledCMDWrong == false)
        XCTAssert(result.executedMethods == [.swizzledMethod, .superMethod])
    }

}
