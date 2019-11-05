//
//  SwizzleWithStaticFuncContext.swift
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 5/11/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

import Foundation

struct SwizzleWithStaticFuncContext {
    
    private typealias MethodType = @convention(c) (AnyObject, Selector, TestResult) -> Void

    var originalIMPPointer: UnsafeMutablePointer<IMP?> = {
        let pointer = UnsafeMutablePointer<IMP?>.allocate(capacity: 1)
        pointer.initialize(to: nil)
        return pointer
    }()

    var replacementIMP: IMP

    private var IMPCallBackFunc: ((_ self: AnyObject, _ _cmd: Selector, _ result: TestResult)->())? = nil
    
    init() {
        replacementIMP = unsafeBitCast({[weak self] in
                (self: AnyObject, _cmd: Selector, result: TestResult) in
        //        IMPCallBackFunc?(self, _cmd, result)
            self.originalIMPPointer.withMemoryRebound(to: MethodType?.self, capacity: 1) { (pointer) -> Void in
                    pointer.pointee?(self, _cmd, result)
                }
            } as MethodType, to: IMP.self)
    }
    
    deinit {
        originalIMPPointer.deinitialize(count: 1)
        originalIMPPointer.deallocate()
    }
    
}
