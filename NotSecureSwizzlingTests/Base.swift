//
//  Base.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 18/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import UIKit

class Base: NSObject {
    final func onlyBaseMethod(log: String) -> String {
        return "\(log) Base".trimmingCharacters(in: .whitespaces)
    }
    
    func childCallBaseMethod(log: String) -> String {
        return "\(log) Base".trimmingCharacters(in: .whitespaces)
    }
    
    func childNotCallBaseMethod(log: String) -> String {
        return "\(log) Base".trimmingCharacters(in: .whitespaces)
    }
    
    class final func onlyBaseMethod(log: String) -> String {
        return "\(log) Base".trimmingCharacters(in: .whitespaces)
    }
    
    class func childCallBaseMethod(log: String) -> String {
        return "\(log) Base".trimmingCharacters(in: .whitespaces)
    }
    
    class func childNotCallBaseMethod(log: String) -> String {
        return "\(log) Base".trimmingCharacters(in: .whitespaces)
    }
}

extension Base {
    
    final func _onlyBaseMethod(log: String) -> String {
        return self._onlyBaseMethod(log: "\(log)_")
    }
    
    func _childCallBaseMethod(log: String) -> String {
        return self._childCallBaseMethod(log: "\(log)_")
    }
    
    func _childNotCallBaseMethod(log: String) -> String {
        return self._childNotCallBaseMethod(log: "\(log)_")
    }
    
    class final func _onlyBaseMethod(log: String) -> String {
        return self._onlyBaseMethod(log: "\(log)_")
    }
    
    class func _childCallBaseMethod(log: String) -> String {
        return self._childCallBaseMethod(log: "\(log)_")
    }
    
    class func _childNotCallBaseMethod(log: String) -> String {
        return self._childNotCallBaseMethod(log: "\(log)_")
    }
    
}
