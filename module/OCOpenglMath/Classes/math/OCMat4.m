//
//  OCMat4.m
//  Pods-OpenGLCoding02
//
//  Created by 曹龙 on 2020/8/27.
//

#import "OCMat4.h"

@interface OCMat4()

@property (nonatomic, strong) OCVec4 *rowOne;
@property (nonatomic, strong) OCVec4 *rowTwo;
@property (nonatomic, strong) OCVec4 *rowThree;
@property (nonatomic, strong) OCVec4 *rowFour;

@end


@implementation OCMat4
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rowOne = [OCVec4 new];
        self.rowTwo = [OCVec4 new];
        self.rowThree = [OCVec4 new];
        self.rowFour = [OCVec4 new];
    }
    return self;
}

- (instancetype)initIdentity {
    self = [super init];
    if (self) {
        self.rowOne = [OCVec4 new];
        self.rowTwo = [OCVec4 new];
        self.rowThree = [OCVec4 new];
        self.rowFour = [OCVec4 new];
        self.rowOne[0] = @(1);
        self.rowTwo[1] = @(1);
        self.rowThree[2] = @(1);
        self.rowFour[3] = @(1);
    }
    return self;
}

- (OCMat4 *)add:(OCMat4 *)mat {
    OCMat4 *sum = [OCMat4 new];
    for(int i = 0; i < 4; i++) {
        for(int j = 0; j < 4; j++) {
            sum[i][j] = @(self[i][j].doubleValue + mat[i][j].doubleValue);
        }
    }
    return sum;
}

- (OCMat4 *)subtract:(OCMat4 *)mat {
    OCMat4 *difference = [OCMat4 new];
    for(int i = 0; i < 4; i++) {
        for(int j = 0; j < 4; j++) {
            difference[i][j] = @(self[i][j].doubleValue - mat[i][j].doubleValue);
        }
    }
    return difference;
}

- (OCMat4 *)multiply:(OCMat4 *)mat {
    OCMat4 *product = [OCMat4 new];
    for(int i = 0; i < 4; i++) {
        for(int j = 0; j < 4; j++) {
            for (int innerM = 0; innerM < 4; innerM++) {
                product[i][j] = @(self[i][innerM].doubleValue + mat[innerM][j].doubleValue);
            }
        }
    }
    return product;
}


- (OCVec4 *)objectAtIndexedSubscript:(NSUInteger)index {
    OCVec4 *num;
    if (index == 0) {
        num = self.rowOne;
    } else if (index == 1) {
        num = self.rowTwo;
    } else if (index == 2) {
        num = self.rowThree;
    } else if (index == 3) {
        num = self.rowFour;
    }
    return num;
}
- (void)setObject:(OCVec4 *)anObject atIndexedSubscript:(NSUInteger)index {
    if (![anObject isKindOfClass:[OCVec4 class]]) {
        return;
    }
    if (index == 0) {
        self.rowOne = anObject;
    } else if (index == 1) {
        self.rowTwo = anObject;
    } else if (index == 2) {
        self.rowThree = anObject;
    } else if (index == 3) {
        self.rowFour = anObject;
    }
}

- (void)convert2Arr:(GLfloat [16])arr {
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            arr[i*4+j] = self[i][j].doubleValue;
        }
    }
}

@end
