//
//  TimerUtil.m
//  OpenGLCoding02
//
//  Created by 曹龙 on 2020/9/4.
//  Copyright © 2020 曹龙. All rights reserved.
//

#import "TimerUtil.h"
#import <QuartzCore/QuartzCore.h>

@interface TimerUtil()
@property (nonatomic, weak) id delegate;
@end

@implementation TimerUtil

+ (instancetype)proxyWithDelegate:(id)delegate {
    return [[TimerUtil alloc] initWithDelegate:delegate];
}
- (instancetype)initWithDelegate:delegate {
    _delegate = delegate;
    return self;
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _delegate;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [NSObject respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object {
    return [_delegate isEqual:object];
}

- (NSUInteger)hash {
    return [_delegate hash];
}

- (Class)superclass {
    return [_delegate superclass];
}

- (Class)class {
    return [_delegate class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_delegate isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_delegate isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_delegate conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    return YES;
}

- (NSString *)description {
    return [_delegate description];
}

- (NSString *)debugDescription {
    return [_delegate debugDescription];
}
@end
