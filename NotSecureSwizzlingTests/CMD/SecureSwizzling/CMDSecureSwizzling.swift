//
//  CMDSecureSwizzling.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 23/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import Foundation

func swizzle_onlySuper_secureSwizzling() -> Bool {
    let ptr = methodOriginal.withMemoryRebound(to: IMP.self, capacity: 1, { (ptr) -> UnsafeMutablePointer<IMP> in
        return ptr
    })
    
    return class_swizzleMethodAndStore(class: TestCMDModel.self,
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

private var methodOriginal: UnsafeMutablePointer<@convention(block) (AnyObject, Selector, TestCMDResult) -> Void> = UnsafeMutablePointer.allocate(capacity: 1)

private var methodSwizzled: @convention(block) (AnyObject, Selector, TestCMDResult) -> Void = {
    (self: AnyObject, _cmd: Selector, result: TestCMDResult) in
    
}

private func class_swizzleMethodAndStore(class: AnyClass, original: Selector, replacement: IMP, store: UnsafeMutablePointer<IMP>) -> Bool {
    return false
}


