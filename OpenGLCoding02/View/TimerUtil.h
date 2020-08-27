//
//  TimerUtil.h
//  OpenGLCoding02
//
//  Created by 曹龙 on 2020/9/4.
//  Copyright © 2020 曹龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerUtil : NSProxy

- (instancetype)initWithDelegate:(id)delegate;

+ (instancetype)proxyWithDelegate:(id)delegate;
@end

NS_ASSUME_NONNULL_END
