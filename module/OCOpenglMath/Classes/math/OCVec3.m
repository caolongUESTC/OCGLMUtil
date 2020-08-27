//
//  OCVec3.m
//  Pods-OpenGLCoding02
//
//  Created by 曹龙 on 2020/8/27.
//

#import "OCVec3.h"

@implementation OCVec2

- (instancetype)initWith:(NSNumber *)x y:(NSNumber *)y {
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.x = @(0);
        self.y = @(0);
    }
    return self;
}
//通过下标获取属性值
- (nullable NSNumber *)objectAtIndexedSubscript:(NSUInteger)index {
    NSNumber *number;
    if (index == 0) {
        number = self.x;
    } else if (index == 1) {
        number = self.y;
    }
    return number;
}

//通过下标设置属性值
- (void)setObject:(NSNumber *)anObject atIndexedSubscript:(NSUInteger)index{
    if (![anObject isKindOfClass:[NSNumber class]]) {
        return;
    }
    if (index == 0 ) {
        self.x = (NSNumber *)anObject;
    } else if (index == 1) {
        self.y = (NSNumber *)anObject;
    }
}

@end


@implementation OCVec3
- (instancetype)initWith:(NSNumber *)x y:(NSNumber *)y z:(NSNumber *)z {
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
        self.z = z;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.x = @(0);
        self.y = @(0);
        self.z = @(0);
    }
    return self;
}

- (OCVec3 *)normalize {
    //1.vec进行正规化
    OCVec3 *vec = [OCVec3 new];
    double distance = sqrt(self.x.doubleValue * self.x.doubleValue + self.y.doubleValue * self.y.doubleValue + self.z.doubleValue * self.z.doubleValue);
    vec.x = @(self.x.doubleValue / distance);
    vec.y = @(self.y.doubleValue / distance);
    vec.z = @(self.z.doubleValue / distance);
    return vec;
}
//通过下标获取属性值
- (NSNumber *)objectAtIndexedSubscript:(NSUInteger)index {
    NSNumber *number;
    if (index == 0) {
        number = self.x;
    } else if (index == 1) {
        number = self.y;
    } else if (index == 2) {
        number = self.z;
    }
    return number;
}
//通过下标设置属性值
- (void)setObject:(NSNumber *)anObject atIndexedSubscript:(NSUInteger)index{
    if (![anObject isKindOfClass:[NSNumber class]]) {
        return;
    }
    if (index == 0 ) {
        self.x = (NSNumber *)anObject;
    } else if (index == 1) {
        self.y = (NSNumber *)anObject;
    } else if (index == 2) {
        self.z = (NSNumber *)anObject;
    }
}

@end


@implementation OCVec4

- (instancetype)initWith:(NSNumber *)x y:(NSNumber *)y z:(NSNumber *)z w:(NSNumber *)w {
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
        self.z = z;
        self.w = w;
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.x = @(0);
        self.y = @(0);
        self.z = @(0);
        self.w = @(0);
    }
    return self;
}
//通过下标获取属性值
- (NSNumber *)objectAtIndexedSubscript:(NSUInteger)index {
    NSNumber *number;
    if (index == 0) {
        number = self.x;
    } else if (index == 1) {
        number = self.y;
    } else if (index == 2) {
        number = self.z;
    } else if (index == 3) {
        number = self.w;
    }
    return number;
}
//通过下标设置属性值
- (void)setObject:(NSNumber *)anObject atIndexedSubscript:(NSUInteger)index{
    if (![anObject isKindOfClass:[NSNumber class]]) {
        return;
    }
    if (index == 0 ) {
        self.x = anObject;
    } else if (index == 1) {
        self.y = anObject;
    } else if (index == 2) {
        self.z = anObject;
    } else if (index == 3) {
        self.w = anObject;
    }
}

@end
