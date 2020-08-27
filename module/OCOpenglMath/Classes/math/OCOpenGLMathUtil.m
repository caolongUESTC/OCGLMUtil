//
//  OCOpenGLMathUtil.m
//  Pods-OpenGLCoding02
//
//  Created by 曹龙 on 2020/8/27.
//

#import "OCOpenGLMathUtil.h"

@implementation OCOpenGLMathUtil

+ (OCMat4 *)transformWith: (OCVec3 *)vec {
    OCMat4 *mat = [[OCMat4 alloc] initIdentity];
    mat[0][3] = vec[0];
    mat[1][3] = vec[1];
    mat[2][3] = vec[2];
    
    
    return mat;
}

+ (OCMat4 *)scaleWith:(OCVec3 *)vec {
    OCMat4 *mat = [[OCMat4 alloc] initIdentity];
    mat[0][0] = vec[0];
    mat[1][1] = vec[1];
    mat[2][2] = vec[2];
    
    return mat;
}

+ (OCMat4 *)rotateWith:(CGFloat)angle axis:(OCVec3 *)vec {
    vec = [vec normalize];
    OCMat4 *mat = [[OCMat4 alloc] initIdentity];
    mat[0][0] = @(cos(angle) + vec.x.doubleValue * vec.x.doubleValue * (1 - cos(angle)));
    mat[0][1] = @(vec.x.doubleValue * vec.y.doubleValue * (1 - cos(angle)) + vec.z.doubleValue * sin(angle));
    mat[0][2] = @(vec.x.doubleValue * vec.z.doubleValue * (1 - cos(angle)) - vec.y.doubleValue * sin(angle));
       
    mat[1][0] = @(vec.y.doubleValue * vec.x.doubleValue * (1 -cos(angle)) - vec.z.doubleValue * sin(angle));
    mat[1][1] = @(cos(angle) + vec.y.doubleValue * vec.y.doubleValue * (1 - cos(angle)));
    mat[1][2] = @(vec.y.doubleValue * vec.z.doubleValue * (1-cos(angle)) + vec.x.doubleValue * sin(angle));
       
    mat[2][0] = @(vec.z.doubleValue * vec.x.doubleValue * (1 - cos(angle)) + vec.y.doubleValue * sin(angle));
    mat[2][1] = @(vec.z.doubleValue * vec.y.doubleValue * (1 - cos(angle)) - vec.x.doubleValue * sin(angle));
    mat[2][2] = @(cos(angle) + vec.z.doubleValue * vec.z.doubleValue *(1 - cos(angle)));
       
    return mat;
}

+ (OCMat4 *)perspective:(CGFloat)fovy aspect:(CGFloat)radio near:(CGFloat)near far:(CGFloat)far {
    OCMat4 *perspective = [OCMat4 new];
    CGFloat halfTan = tan(fovy/2);
    perspective[0][0] = @(1 / (radio * halfTan));
    perspective[1][1] = @(1 / (halfTan));
    perspective[2][3] = @(-1);
    
    perspective[2][2] = @(- (far + near) / (far - near));
    perspective[3][2] = @(- (2 * far * near) / (far - near));
    return perspective;
}
@end
