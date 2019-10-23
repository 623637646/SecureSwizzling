//
//  NotSecureSwizzlingTests.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 18/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import XCTest

class NotSecureSwizzlingTests: XCTestCase {
    
    // MARK: Tests
    
    func testSwizzleAnimal() {
        self.swizzleAnimal()
        XCTAssert(Animal().shit() == [_animalShitting,
                                      animalShitting])
    }
    
    func testSwizzleDog() {
        self.swizzleDog()
        XCTAssert(Dog().shit() == [dogShitting,
                                   animalShitting])
    }
    
    func testSwizzleAnimalThenDog() {
        self.swizzleAnimal()
        self.swizzleDog()
        XCTAssert(Dog().shit() == [dogShitting,
                                   _animalShitting,
                                   animalShitting])
    }
    
    func testSwizzleDogThenAnimal() {
        self.swizzleDog()
        self.swizzleAnimal()
        XCTAssert(Dog().shit() == [_animalShitting,
                                   dogShitting,
                                   animalShitting])
    }
    
    // MARK: swizzle
    
    func swizzleAnimal() {
        let originalSelector = #selector(Animal.shit)
        let swizzledSelector = #selector(Animal._animal_shit)
        
        let originalMethod = class_getInstanceMethod(Animal.self, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(Animal.self, swizzledSelector)!
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    func swizzleDog() {
        let originalSelector = #selector(Dog.shit)
        let swizzledSelector = #selector(Dog._dog_shit)
        
        let originalMethod = class_getInstanceMethod(Dog.self, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(Dog.self, swizzledSelector)!
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }

}
