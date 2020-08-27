//
//  OCOpenGLMathUtil.h
//  Pods-OpenGLCoding02
//
//  Created by 曹龙 on 2020/8/27.
//

#import <UIKit/UIKit.h>
#import "OCMat4.h"
#import "OCVec3.h"

NS_ASSUME_NONNULL_BEGIN
 __attribute__((deprecated("Class OCOpenGLMath is deprecated , use GLKit instead")))
@interface OCOpenGLMathUtil : NSObject
/*******
 *  将位移向量转换成
 *  @param  vec  需要的位移值
 *  @return 位移矩阵
 *
 ************/
+ (OCMat4 *)transformWith: (OCVec3 *)vec;

/****
 *  将缩放向量转
 *  @param vec 需要缩放的值
 *  @return 缩放矩阵
 *
 *******/
+ (OCMat4 *)scaleWith:(OCVec3 *)vec;

/*******
 *  将向量转换成矩阵
 *  @param angle 需要旋转的角度
 *  @param vec 需要旋转的轴
 *  @return 旋转矩阵
 *
 ********/
+ (OCMat4 *)rotateWith:(CGFloat)angle axis:(OCVec3 *)vec;

/*****
 *  透视投影矩阵
 * @param fovy 夹角
 * @param radio 宽高比
 * @param near z轴近平面距离
 * @param far z轴远平面距离
 * 
 * @return 透视投影矩阵。
 *'****/
+ (OCMat4 *)perspective:(CGFloat)fovy aspect:(CGFloat)radio near:(CGFloat)near far:(CGFloat)far;

@end

NS_ASSUME_NONNULL_END
