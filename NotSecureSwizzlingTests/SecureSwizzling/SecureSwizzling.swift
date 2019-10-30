//
//  CMDSecureSwizzling.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 23/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import Foundation

private typealias MethodType = @convention(c) (AnyObject, Selector, TestResultModel) -> Void

// MARK: only super

private var onlySuperMethodOriginal: UnsafeMutablePointer<MethodType?> = {
    let pointer = UnsafeMutablePointer<MethodType?>.allocate(capacity: 1)
    pointer.initialize(to: nil)
    return pointer
}()


private let onlySuperMethodSwizzled: MethodType = {
    (self: AnyObject, _cmd: Selector, result: TestResultModel) in
    result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) == "_onlySuper:"
    result.executedMethods.append(.swizzledMethod)
    onlySuperMethodOriginal.pointee?(`self`, _cmd, result)
}

func swizzle_onlySuper_secureSwizzling() -> Bool {
    return onlySuperMethodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1) { (pointer) -> Bool in
        return class_swizzleMethodAndStore(theClass: TestModel.self,
                                           original: #selector(TestModel.onlySuper(_:)),
                                           replacement: unsafeBitCast(onlySuperMethodSwizzled, to: IMP.self),
                                           store: pointer)
    }
}

// MARK: only self

private var onlySelfMethodOriginal: UnsafeMutablePointer<MethodType?> = {
    let pointer = UnsafeMutablePointer<MethodType?>.allocate(capacity: 1)
    pointer.initialize(to: nil)
    return pointer
}()

private let onlySelfMethodSwizzled: MethodType = {
    (self: AnyObject, _cmd: Selector, result: TestResultModel) in
    result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) == "_onlySelf:"
    result.executedMethods.append(.swizzledMethod)
    onlySelfMethodOriginal.pointee?(`self`, _cmd, result)
}

func swizzle_onlySelf_secureSwizzling() -> Bool {
    return onlySelfMethodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1) { (pointer) -> Bool in
        return class_swizzleMethodAndStore(theClass: TestModel.self,
                                           original: #selector(TestModel.onlySelf(_:)),
                                           replacement: unsafeBitCast(onlySelfMethodSwizzled, to: IMP.self),
                                           store: pointer)
    }
}

// MARK: in both

private var inBothMethodOriginal: UnsafeMutablePointer<MethodType?> = {
    let pointer = UnsafeMutablePointer<MethodType?>.allocate(capacity: 1)
    pointer.initialize(to: nil)
    return pointer
}()

private let inBothMethodSwizzled: MethodType = {
    (self: AnyObject, _cmd: Selector, result: TestResultModel) in
    result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) == "_inBoth:"
    result.executedMethods.append(.swizzledMethod)
    inBothMethodOriginal.pointee?(`self`, _cmd, result)
}

func swizzle_inBoth_secureSwizzling() -> Bool {
    return inBothMethodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1) { (pointer) -> Bool in
        return class_swizzleMethodAndStore(theClass: TestModel.self,
                                           original: #selector(TestModel.inBoth(_:)),
                                           replacement: unsafeBitCast(inBothMethodSwizzled, to: IMP.self),
                                           store: pointer)
    }
}

// MARK: utilities

private func class_swizzleMethodAndStore(theClass: AnyClass, original: Selector, replacement: IMP, store: UnsafeMutablePointer<IMP?>) -> Bool {
    guard let originalMethod = class_getInstanceMethod(theClass, original) else {
        return false
    }
    let originalTypeEncoding = method_getTypeEncoding(originalMethod)
    var originalIMP = class_replaceMethod(theClass, original, replacement, originalTypeEncoding)
    if originalIMP == nil {
        originalIMP = method_getImplementation(originalMethod)
    }
    guard let impNotNil = originalIMP else {
        return false
    }
    store.pointee = impNotNil
    return true
}


