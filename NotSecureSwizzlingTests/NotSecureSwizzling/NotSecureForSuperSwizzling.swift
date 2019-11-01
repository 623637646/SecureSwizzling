//
//  SuperNotSecureSwizzling.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 25/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import Foundation

func swizzleSuperMethodUnsecureForSuperSwizzling() -> Bool {
    swizzleNotSecureForSuper(class: TestModel.self,
                         originalSel: #selector(TestModel.superMethod(_:)),
                         swizzledSelector: #selector(TestModel._superMethod(_:)))
}

func swizzleSubMethodUnsecureForSuperSwizzling() -> Bool {
    swizzleNotSecureForSuper(class: TestModel.self,
                         originalSel: #selector(TestModel.subMethod(_:)),
                         swizzledSelector: #selector(TestModel._subMethod(_:)))
}

func swizzleOverridedMethodUnsecureForSuperSwizzling() -> Bool {
    swizzleNotSecureForSuper(class: TestModel.self,
                         originalSel: #selector(TestModel.overridedMethod(_:)),
                         swizzledSelector: #selector(TestModel._overridedMethod(_:)))
}

private func swizzleNotSecureForSuper(`class`: AnyClass, originalSel: Selector, swizzledSelector: Selector) -> Bool {
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
