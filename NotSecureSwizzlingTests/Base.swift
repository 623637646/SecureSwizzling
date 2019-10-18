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
        return "\(log)Base"
    }
    
    func childCallBaseMethod(log: String) -> String {
        return "\(log)Base"
    }
    
    func childNotCallBaseMethod(log: String) -> String {
        return "\(log)Base"
    }
    
    class final func onlyBaseMethod(log: String) -> String {
        return "\(log)Base"
    }
    
    class func childCallBaseMethod(log: String) -> String {
        return "\(log)Base"
    }
    
    class func childNotCallBaseMethod(log: String) -> String {
        return "\(log)Base"
    }
}
