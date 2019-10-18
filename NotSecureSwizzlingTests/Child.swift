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
        return "\(log)Child"
    }
    
    override func childNotCallBaseMethod(log: String) -> String {
        return "\(log)Child"
    }
    
    class override func childCallBaseMethod(log: String) -> String {
        let log = super.childCallBaseMethod(log: log)
        return "\(log)Child"
    }
    
    class override func childNotCallBaseMethod(log: String) -> String {
        return "\(log)Child"
    }
}
