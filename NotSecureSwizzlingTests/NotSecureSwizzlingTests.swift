//
//  NotSecureSwizzlingTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 18/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class NotSecureSwizzlingTests: XCTestCase {
    
    func testSwizzling() {
        XCTAssert(Animal().shit() == [animalShitting])
        XCTAssert(Dog().shit() == [animalShitting])
        
        self.swizzledAnimal()
        
        XCTAssert(Animal().shit() == [animalShitting, _animalShitting])
    }
    
    func swizzledAnimal() {
        let originalSelector = #selector(Animal.shit)
        let swizzledSelector = #selector(Animal._animal_shit)
        
        let originalMethod = class_getInstanceMethod(Animal.self, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(Animal.self, swizzledSelector)!
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }

}
