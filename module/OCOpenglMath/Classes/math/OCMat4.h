//
//  OCMat4.h
//  Pods-OpenGLCoding02
//
//  Created by 曹龙 on 2020/8/27.
//

#import <Foundation/Foundation.h>
#import "OCVec3.h"

NS_ASSUME_NONNULL_BEGIN

static const CGFloat PI = 3.1415926;

@interface OCMat4 : NSObject
/**
 *
 * 单位矩阵初始化
 * @return 单位矩阵
 *********/
- (instancetype)initIdentity;


/****
 * 矩阵加法
 * @param mat 加数
 * @return 和
 **********/
- (OCMat4 *)add:(OCMat4 *)mat;

/**
 *  矩阵减法
 * @param mat 减数
 * @return 差
 ********/
- (OCMat4 *)subtract:(OCMat4 *)mat;

/******
 * 乘法
 * @param mat 乘数
 * @return 积
 ****/
- (OCMat4 *)multiply:(OCMat4 *)mat;

/*******
 * 转换成数组
 *  @param arr 将数据复制到arr
 *
 ****/
- (void)convert2Arr:(GLfloat [_Nonnull 16])arr;

//支持数组的形式获取。
- (nullable OCVec4 *)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(OCVec4 *)anObject atIndexedSubscript:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
