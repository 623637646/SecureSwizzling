//
//  SwizzleWithStaticFuncContext.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 5/11/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import Foundation

//private typealias MethodType = @convention(c) (AnyObject, Selector, AnyClass...) -> Void

//typealias MemoryType<T> = (originalIMPPointer: UnsafeMutablePointer<IMP?>, replacementIMP: IMP, hookBlock:T)?


struct Context<T> {
    let store: UnsafeMutablePointer<IMP?>
    let hookBlock: T
    var replacement: IMP {
        return unsafeBitCast(hookBlock, to: IMP.self)
    }
    
    init(hookBlock: T) {
        self.hookBlock = hookBlock
        // TODO:
        self.store = {
            let pointer = UnsafeMutablePointer<IMP?>.allocate(capacity: 1)
            pointer.initialize(to: nil)
            return pointer
        }()
        
//        let replacementBlock: T = {
//
//        } as! T
//
//        self.replacement = unsafeBitCast({
//            (self: AnyObject, _cmd: Selector, result: TestResult) in
//            IMPCallBackFunc?(self, _cmd, result)
//            originalIMPPointer.withMemoryRebound(to: MethodType?.self, capacity: 1) { (pointer) -> Void in
//                pointer.pointee?(self, _cmd, result)
//            }
//        } as MethodType, to: IMP.self)
    }
    
    class C {
        deinit {
            print("deinit")
        }
    }
    
    let c: C = C()

}

func newSwizzleWithStaticFuncContext<T>(theClass: AnyClass, original: Selector, hookBlock: T) -> Bool {
    let context = Context(hookBlock: hookBlock)
    return swizzleMethodWithStaticFunc(theClass: theClass, original: original, replacement: context.replacement, store: context.store)
}

private func swizzleMethodWithStaticFunc(theClass: AnyClass, original: Selector, replacement: IMP, store: UnsafeMutablePointer<IMP?>) -> Bool {
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
