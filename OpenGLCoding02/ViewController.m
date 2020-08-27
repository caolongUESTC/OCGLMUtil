//
//  ViewController.m
//  OpenGLCoding02
//
//  Created by 曹龙 on 2020/8/26.
//  Copyright © 2020 曹龙. All rights reserved.
//

#import "ViewController.h"
#import <OCOpenGLMathUtil.h>
#import "OpenGLView.h"

@interface ViewController ()
@property (nonatomic, strong) OpenGLView *openGLView;
@end

@implementation ViewController

- (OpenGLView *)openGLView {
    if (!_openGLView) {
        _openGLView = [OpenGLView new];
        [self.view addSubview:_openGLView];
    }
    return _openGLView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.openGLView.frame = CGRectInset(self.view.bounds, 0, 20);
}
@end
