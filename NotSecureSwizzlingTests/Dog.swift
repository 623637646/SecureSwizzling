//
//  Child.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 18/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import UIKit

let dogShitting = "a dog is shitting"

class Dog: Animal {
    
}

extension Dog {
    
    @objc dynamic func _dog_shit() -> [String] {
        print(dogShitting)
        var result = self._dog_shit()
        result.insert(dogShitting, at: 0)
        return result
    }
    
}
