//
//  Swizzling.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 21/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import Foundation

func swizzle_CMDNotSecure(`class`: AnyClass, originalSel: Selector, swizzledSelector: Selector) -> Bool {
    // prepare
    guard let originalMethod = class_getInstanceMethod(`class`, originalSel) else {
        return false
    }
    guard let swizzledMethod = class_getInstanceMethod(`class`, swizzledSelector) else {
        return false
    }
    let originalIMP = method_getImplementation(originalMethod)
    let swizzledIMP = method_getImplementation(swizzledMethod)
    let originalTypeEncoding = method_getTypeEncoding(originalMethod)
    let swizzledEncoding = method_getTypeEncoding(swizzledMethod)
    
    // swizzling
    if class_addMethod(`class`, originalSel, swizzledIMP, swizzledEncoding) {
        class_replaceMethod(`class`, swizzledSelector, originalIMP, originalTypeEncoding)
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    return true
}
