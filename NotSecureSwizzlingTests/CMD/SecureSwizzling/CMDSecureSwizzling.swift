//
//  CMDSecureSwizzling.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 23/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import Foundation

// MARK: public

func swizzle_onlySuper_secureSwizzling() -> Bool {
    let ptr = methodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1, { (ptr) -> UnsafeMutablePointer<IMP?> in
        return ptr
    })
    
    return class_swizzleMethodAndStore(theClass: TestCMDModel.self,
                                       original: #selector(TestCMDModel.onlySuper(_:)),
                                       replacement: unsafeBitCast(methodSwizzled, to: IMP.self),
                                       store: ptr)
}

func swizzle_onlySelf_secureSwizzling() -> Bool {
    return false
}

func swizzle_inBoth_secureSwizzling() -> Bool {
    return false
}

// MARK: private

private typealias MethodType = @convention(c) (AnyObject, Selector, TestCMDResult) -> Void

private var methodOriginal: UnsafeMutablePointer<MethodType?> = UnsafeMutablePointer.allocate(capacity: 1)

private var methodSwizzled: MethodType = {
    (self: AnyObject, _cmd: Selector, result: TestCMDResult) in
    result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) == "_onlySelf:"
    result.executedMethods.append(.swizzledMethod)
    methodOriginal.pointee?(`self`, _cmd, result)
}

private func class_swizzleMethodAndStore(theClass: AnyClass, original: Selector, replacement: IMP, store: UnsafeMutablePointer<IMP?>) -> Bool {
    var imp: IMP? = nil
    guard let originalMethod = class_getInstanceMethod(theClass, original) else {
        return false
    }
    let originalTypeEncoding = method_getTypeEncoding(originalMethod)
    imp = class_replaceMethod(theClass, original, replacement, originalTypeEncoding)
    if imp == nil {
        imp = method_getImplementation(originalMethod)
    }
    guard let impNotNil = imp else {
        return false
    }
    store.pointee = impNotNil
    return true
}


