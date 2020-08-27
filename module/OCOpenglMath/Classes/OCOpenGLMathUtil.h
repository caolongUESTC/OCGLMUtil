//
//  OCOpenGLMathUtil.h
//  Pods-OpenGLCoding02
//
//  Created by 曹龙 on 2020/8/27.
//

#import <Foundation/Foundation.h>
#import "OCMat4.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCOpenGLMathUtil : NSObject
/*******
 *      param: 需要位移的变量。
 *      @return 位移矩阵
 *
 ************/
+ (OCMat4 *)initTransformWithVec: (NSArray *)arr;




@end

NS_ASSUME_NONNULL_END
