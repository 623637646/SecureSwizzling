//
//  SuperNotSecureSwizzling.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 25/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import Foundation

func swizzle_onlySuper_super_unsecureSwizzling() -> Bool {
    swizzle_SuperNotSecure(class: TestModel.self,
                         originalSel: #selector(TestModel.onlySuper(_:)),
                         swizzledSelector: #selector(TestModel._onlySuper(_:)))
}

func swizzle_onlySelf_super_unsecureSwizzling() -> Bool {
    swizzle_SuperNotSecure(class: TestModel.self,
                         originalSel: #selector(TestModel.onlySelf(_:)),
                         swizzledSelector: #selector(TestModel._onlySelf(_:)))
}

func swizzle_inBoth_super_unsecureSwizzling() -> Bool {
    swizzle_SuperNotSecure(class: TestModel.self,
                         originalSel: #selector(TestModel.inBoth(_:)),
                         swizzledSelector: #selector(TestModel._(inBoth:)))
}

private func swizzle_SuperNotSecure(`class`: AnyClass, originalSel: Selector, swizzledSelector: Selector) -> Bool {
    // prepare
    guard let originalMethod = class_getInstanceMethod(`class`, originalSel) else {
        return false
    }
    guard let swizzledMethod = class_getInstanceMethod(`class`, swizzledSelector) else {
        return false
    }
    // swizzling
    method_exchangeImplementations(originalMethod, swizzledMethod)
    return true
}
