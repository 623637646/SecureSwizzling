//
//  Result.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 22/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import Foundation

@objcMembers
class TestCMDResult: NSObject {
    
    @objc enum Executed: Int {
        case superMethod = 0
        case selfMethod = 1
        case swizzledMethod = 2
    }
    
    var executedMethods: [Executed] = []
    
    var objc_executedMethods: [Int] {
        get {
            return executedMethods.map { (executed) -> Int in
                return executed.rawValue
            }
        }
        set {
            executedMethods = newValue.map({ (executed) -> Executed in
                return Executed.init(rawValue: executed)!
            })
        }
    }
    
    var isSuperCMDWrong: Bool = false
    var isSelfCMDWrong: Bool = false
    var isSwizzledCMDWrong: Bool = false
    
    override init() {
        super.init()
    }
    
}
