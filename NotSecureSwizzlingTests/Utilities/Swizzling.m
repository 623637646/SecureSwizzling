//
//  Swizzling.m
//  NotSecureSwizzlingTests
//
//  Created by Yanni Wang on 22/10/19.
//  Copyright © 2019 Yanni. All rights reserved.
//

#import "Swizzling.h"
#import <objc/runtime.h>
#import "TestCMDModel.h"
#import "NotSecureSwizzlingTests-Swift.h"

typedef IMP *IMPPointer;

static void MethodSwizzle(id self, SEL _cmd, id arg1);
static void (*MethodOriginal)(id self, SEL _cmd, id arg1);

static void MethodSwizzle(id self, SEL _cmd, TestCMDResult *result) {
    result.isSwizzledCMDWrong = NO; // here is not in objective-c class. _cmd is just a parameter
    result.objc_executedMethods = [result.objc_executedMethods arrayByAddingObject:@(ExecutedSwizzledMethod)];
    MethodOriginal(self, _cmd, result);
}

BOOL class_swizzleMethodAndStore(Class class, SEL original, IMP replacement, IMPPointer store) {
    IMP imp = NULL;
    Method method = class_getInstanceMethod(class, original);
    if (method) {
        const char *type = method_getTypeEncoding(method);
        imp = class_replaceMethod(class, original, replacement, type);
        if (!imp) {
            imp = method_getImplementation(method);
        }
    }
    if (imp && store) { *store = imp; }
    return (imp != NULL);
}

BOOL doit(void) {
    return class_swizzleMethodAndStore(TestCMDModel.self,
                                @selector(onlySuper:),
                                (IMP)MethodSwizzle,
                                (IMP *)&MethodOriginal);
}
