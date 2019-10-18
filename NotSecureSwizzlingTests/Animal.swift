//
//  Base.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 18/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import UIKit

let animalShitting = "-> an animal is shitting"

let _animalShitting = "-> swizzled an animal is shitting"

class Animal: NSObject {
    
    @objc dynamic func shit() -> [String] {
        print(animalShitting)
        return [animalShitting]
    }
    
}

extension Animal {
    
    @objc dynamic func _animal_shit() -> [String] {
        var result = self._animal_shit()
        result.append(_animalShitting)
        print(_animalShitting)
        return result
    }
    
}
