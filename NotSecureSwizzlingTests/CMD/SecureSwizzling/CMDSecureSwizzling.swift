//
//  CMDSecureSwizzling.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 23/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import Foundation

private typealias MethodType = @convention(c) (AnyObject, Selector, TestCMDResult) -> Void

// MARK: only super

private var onlySuperMethodOriginal: UnsafeMutablePointer<MethodType?> = UnsafeMutablePointer.allocate(capacity: 1)

private let onlySuperMethodSwizzled: MethodType = {
    (self: AnyObject, _cmd: Selector, result: TestCMDResult) in
    result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) == "_onlySuper:"
    result.executedMethods.append(.swizzledMethod)
    onlySuperMethodOriginal.pointee?(`self`, _cmd, result)
}

func swizzle_onlySuper_secureSwizzling() -> Bool {
    let ptr = onlySuperMethodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1, { (ptr) -> UnsafeMutablePointer<IMP?> in
        return ptr
    })
    
    return class_swizzleMethodAndStore(theClass: TestCMDModel.self,
                                       original: #selector(TestCMDModel.onlySuper(_:)),
                                       replacement: unsafeBitCast(onlySuperMethodSwizzled, to: IMP.self),
                                       store: ptr)
}

// MARK: only self

private var onlySelfMethodOriginal: UnsafeMutablePointer<MethodType?> = UnsafeMutablePointer.allocate(capacity: 1)

private let onlySelfMethodSwizzled: MethodType = {
    (self: AnyObject, _cmd: Selector, result: TestCMDResult) in
    result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) == "_onlySelf:"
    result.executedMethods.append(.swizzledMethod)
    onlySelfMethodOriginal.pointee?(`self`, _cmd, result)
}

func swizzle_onlySelf_secureSwizzling() -> Bool {
    let ptr = onlySelfMethodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1, { (ptr) -> UnsafeMutablePointer<IMP?> in
        return ptr
    })
    
    return class_swizzleMethodAndStore(theClass: TestCMDModel.self,
                                       original: #selector(TestCMDModel.onlySelf(_:)),
                                       replacement: unsafeBitCast(onlySelfMethodSwizzled, to: IMP.self),
                                       store: ptr)
}

// MARK: in both

private var inBothMethodOriginal: UnsafeMutablePointer<MethodType?> = UnsafeMutablePointer.allocate(capacity: 1)

private let inBothMethodSwizzled: MethodType = {
    (self: AnyObject, _cmd: Selector, result: TestCMDResult) in
    result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) == "_inBoth:"
    result.executedMethods.append(.swizzledMethod)
    inBothMethodOriginal.pointee?(`self`, _cmd, result)
}

func swizzle_inBoth_secureSwizzling() -> Bool {
    let ptr = inBothMethodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1, { (ptr) -> UnsafeMutablePointer<IMP?> in
        return ptr
    })
    
    return class_swizzleMethodAndStore(theClass: TestCMDModel.self,
                                       original: #selector(TestCMDModel.inBoth(_:)),
                                       replacement: unsafeBitCast(inBothMethodSwizzled, to: IMP.self),
                                       store: ptr)
}

// MARK: utilities

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


