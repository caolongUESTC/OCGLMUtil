//
//  OCVec3.h
//  Pods-OpenGLCoding02
//
//  Created by 曹龙 on 2020/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface OCVec2 : NSObject

- (instancetype)initWith:(NSNumber *)x y:(NSNumber *)y;
@property(nonatomic, strong) NSNumber *x;
@property(nonatomic, strong) NSNumber *y;
//支持数组的形式获取。
- (nullable NSNumber *)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(NSNumber *)anObject atIndexedSubscript:(NSUInteger)index;

@end


@interface OCVec3 : NSObject
- (instancetype)initWith:(NSNumber *)x y:(NSNumber *)y z:(NSNumber *)z;
@property (nonatomic, strong) NSNumber *x;
@property (nonatomic, strong) NSNumber *y;
@property (nonatomic, strong) NSNumber *z;

- (OCVec3 *)normalize; //正规化
//支持数组的形式获取。
- (nullable NSNumber *)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(NSNumber *)anObject atIndexedSubscript:(NSUInteger)index;
@end


@interface OCVec4 : NSObject

- (instancetype)initWith:(NSNumber *)x y:(NSNumber *)y z:(NSNumber *)z w:(NSNumber *)w;
@property (nonatomic, strong) NSNumber *x;
@property (nonatomic, strong) NSNumber *y;
@property (nonatomic, strong) NSNumber *z;
@property (nonatomic, strong) NSNumber *w;

//支持数组的形式获取。
- (nullable NSNumber *)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(NSNumber *)anObject atIndexedSubscript:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
