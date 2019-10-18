//
//  Child.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 18/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import UIKit

class Child: Base {
    override func childCallBaseMethod(log: String) -> String {
        let log = super.childCallBaseMethod(log: log)
        return "\(log) Child".trimmingCharacters(in: .whitespaces)
    }
    
    override func childNotCallBaseMethod(log: String) -> String {
        return "\(log) Child".trimmingCharacters(in: .whitespaces)
    }
    
    class override func childCallBaseMethod(log: String) -> String {
        let log = super.childCallBaseMethod(log: log)
        return "\(log) Child".trimmingCharacters(in: .whitespaces)
    }
    
    class override func childNotCallBaseMethod(log: String) -> String {
        return "\(log) Child".trimmingCharacters(in: .whitespaces)
    }
}

extension Child {
    
    override func _childCallBaseMethod(log: String) -> String {
        return self._childCallBaseMethod(log: "\(log)_")
    }
    
    override func _childNotCallBaseMethod(log: String) -> String {
        return self._childNotCallBaseMethod(log: "\(log)_")
    }
    
    class override func _childCallBaseMethod(log: String) -> String {
        return self._childCallBaseMethod(log: "\(log)_")
    }
    
    class override func _childNotCallBaseMethod(log: String) -> String {
        return self._childNotCallBaseMethod(log: "\(log)_")
    }
    
}
