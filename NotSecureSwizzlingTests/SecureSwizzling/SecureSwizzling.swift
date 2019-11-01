//
//  CMDSecureSwizzling.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 23/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import Foundation

private typealias MethodType = @convention(c) (AnyObject, Selector, TestResult) -> Void

// MARK: only super

private var onlySuperMethodOriginal: UnsafeMutablePointer<MethodType?> = {
    let pointer = UnsafeMutablePointer<MethodType?>.allocate(capacity: 1)
    pointer.initialize(to: nil)
    return pointer
}()


private let onlySuperMethodSwizzled: MethodType = {
    (self: AnyObject, _cmd: Selector, result: TestResult) in
    result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) == "_superMethod:"
    result.executedMethods.append(.swizzledMethod)
    onlySuperMethodOriginal.pointee?(`self`, _cmd, result)
}

func swizzleSuperMethodSecureSwizzling() -> Bool {
    return onlySuperMethodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1) { (pointer) -> Bool in
        return classSwizzleMethodAndStore(theClass: TestModel.self,
                                           original: #selector(TestModel.superMethod(_:)),
                                           replacement: unsafeBitCast(onlySuperMethodSwizzled, to: IMP.self),
                                           store: pointer)
    }
}

// MARK: only self

private var onlySubMethodOriginal: UnsafeMutablePointer<MethodType?> = {
    let pointer = UnsafeMutablePointer<MethodType?>.allocate(capacity: 1)
    pointer.initialize(to: nil)
    return pointer
}()

private let onlySubMethodSwizzled: MethodType = {
    (self: AnyObject, _cmd: Selector, result: TestResult) in
    result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) == "_subMethod:"
    result.executedMethods.append(.swizzledMethod)
    onlySubMethodOriginal.pointee?(`self`, _cmd, result)
}

func swizzleSubMethodSecureSwizzling() -> Bool {
    return onlySubMethodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1) { (pointer) -> Bool in
        return classSwizzleMethodAndStore(theClass: TestModel.self,
                                           original: #selector(TestModel.subMethod(_:)),
                                           replacement: unsafeBitCast(onlySubMethodSwizzled, to: IMP.self),
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
    (self: AnyObject, _cmd: Selector, result: TestResult) in
    result.isSwizzledCMDWrong = NSStringFromSelector(_cmd) == "_overridedMethod:"
    result.executedMethods.append(.swizzledMethod)
    inBothMethodOriginal.pointee?(`self`, _cmd, result)
}

func swizzleOverridedMethodSecureSwizzling() -> Bool {
    return inBothMethodOriginal.withMemoryRebound(to: IMP?.self, capacity: 1) { (pointer) -> Bool in
        return classSwizzleMethodAndStore(theClass: TestModel.self,
                                           original: #selector(TestModel.overridedMethod(_:)),
                                           replacement: unsafeBitCast(inBothMethodSwizzled, to: IMP.self),
                                           store: pointer)
    }
}

// MARK: utilities

private func classSwizzleMethodAndStore(theClass: AnyClass, original: Selector, replacement: IMP, store: UnsafeMutablePointer<IMP?>) -> Bool {
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


