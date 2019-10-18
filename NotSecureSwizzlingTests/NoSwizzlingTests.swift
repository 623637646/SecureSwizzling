//
//  NoSwizzlingTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 18/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class NoSwizzlingTests: XCTestCase {

    func testBaseInstance() {
        let superObject = Base()
        XCTAssert(superObject.onlyBaseMethod(log: "") == "Base")
        XCTAssert(superObject.childCallBaseMethod(log: "") == "Base")
        XCTAssert(superObject.childNotCallBaseMethod(log: "") == "Base")
    }
    
    func testBaseClass() {
        XCTAssert(Base.onlyBaseMethod(log: "") == "Base")
        XCTAssert(Base.childCallBaseMethod(log: "") == "Base")
        XCTAssert(Base.childNotCallBaseMethod(log: "") == "Base")
    }
    
    func testChildInstance() {
        let subObject = Child()
        XCTAssert(subObject.onlyBaseMethod(log: "") == "Base")
        XCTAssert(subObject.childCallBaseMethod(log: "") == "BaseChild")
        XCTAssert(subObject.childNotCallBaseMethod(log: "") == "Child")
    }
    
    func testChildClass() {
        XCTAssert(Child.onlyBaseMethod(log: "") == "Base")
        XCTAssert(Child.childCallBaseMethod(log: "") == "BaseChild")
        XCTAssert(Child.childNotCallBaseMethod(log: "") == "Child")
    }

}
