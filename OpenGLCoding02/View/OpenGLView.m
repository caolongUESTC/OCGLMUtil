//
//  OpenGLView.m
//  OpenGLCoding02
//
//  Created by 曹龙 on 2020/8/26.
//  Copyright © 2020 曹龙. All rights reserved.
//

#import "OpenGLView.h"
#import "OCOpenGLMath-umbrella.h"
#import "TimerUtil.h"
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/glext.h>

@interface OpenGLView()
@property (nonatomic, strong) EAGLContext *context;
@property (nonatomic, strong) CAEAGLLayer *eagLayer;
@property (nonatomic, assign) GLuint programId; //程序

//MARK: -- 缓存空间
@property (nonatomic, assign) GLuint colorRenderBufferId; //渲染缓存
@property (nonatomic, assign) GLuint colorFrameBufferId;    //帧缓存
@property (nonatomic, assign) GLuint depthRenderBufferId; //深度缓冲


@property (nonatomic, strong) CADisplayLink *displayLink;
@end

@implementation OpenGLView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupLayer];
        [self setupContext];
        [self setTimerDisplay];
    }
    return self;
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

//MARK: 初始化过程
- (void)setupLayer {
    [self setContentScaleFactor:[[UIScreen mainScreen] scale]]; //调整缩放因子
    self.eagLayer = (CAEAGLLayer *)self.layer;
    [OpenGLCommonUtil setupEAGLLayer:self.eagLayer];
}
- (void)setupContext {
    self.context = [OpenGLCommonUtil generateGL2Context];
}


- (void)generateColorRenderBufferId {
    glGenBuffers(1, &_colorRenderBufferId);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBufferId);
    [self.context renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.eagLayer];
}
////创建深度缓冲区
- (void)generateDepthBufferId {
    int depthWidth,depthHeight;
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &depthWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &depthHeight);
    glGenRenderbuffers(1, &_depthRenderBufferId);
    glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBufferId);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, depthWidth, depthHeight);
}
- (void)generateColorFrameBufferId {
    glGenFramebuffers(1, &_colorFrameBufferId);
    glBindFramebuffer(GL_FRAMEBUFFER, _colorFrameBufferId);
    
    // Attach color render buffer and depth render buffer to frameBuffer
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                              GL_RENDERBUFFER, _colorRenderBufferId);
    
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT,
                              GL_RENDERBUFFER, _depthRenderBufferId);
    
    // Set color render buffer as current render buffer
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBufferId);
}

- (void)setupRenderBuffer {
    [self generateColorRenderBufferId];
    [self generateDepthBufferId];
    [self generateColorFrameBufferId];
    // Check FBO satus
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    if (status != GL_FRAMEBUFFER_COMPLETE) {
        NSLog(@"Error: Frame buffer is not completed.");
        exit(1);
    }
}

- (void)destoryRenderAndFrameBuffer {
    glDeleteFramebuffers(1, &_colorFrameBufferId);
    self.colorFrameBufferId = 0;
    glDeleteRenderbuffers(1, &_colorRenderBufferId);
    self.colorRenderBufferId = 0;
    glDeleteRenderbuffers(1, &_depthRenderBufferId);
    self.depthRenderBufferId = 0;
}

//MARK: - 系统回调
- (void)layoutSubviews {
    [super layoutSubviews];
    [self destoryRenderAndFrameBuffer];
    [self setupRenderBuffer];
    [self render];
}

//MARK: -- 渲染

- (void)render {
    //清屏
    [self clearScreen];
    //加载shader
    [self compileAndLink];
    //发送数据到gpu
    [self postMessageToGPU];
    //绘制
    [self glDrawPhoto];
}

//1.清除屏幕内容。
- (void)clearScreen {
    glEnable(GL_DEPTH_TEST);
    glClearColor(1.0, 1.0, 1.0, 1.0); //将背景颜色设置为对应颜色,对应元素 r g b a。
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    
    CGFloat scale= [[UIScreen mainScreen] scale];
    glViewport(self.frame.origin.x * scale, self.frame.origin.y * scale,
               self.frame.size.width * scale, self.frame.size.height * scale); //设置视口大小
   
}

//2.编译和链接程序。
- (void)compileAndLink {
    OpenGLCompileUtil *util = [[OpenGLCompileUtil alloc] init];
    
    NSString *vertFile = [[NSBundle mainBundle] pathForResource:@"vertex" ofType:@"vsh"]; //顶点着色器。
    NSString *fragFile = [[NSBundle mainBundle] pathForResource:@"fragment" ofType:@"fsh"];//片段着色器。
    self.programId = [util loadShaders:vertFile fragment:fragFile];
    if ([util linkProgram:self.programId] == GL_FALSE) {
        return; //编译流程产生了错误。
    }
    glUseProgram(self.programId); //使用程序
}

//3.数据发送。将数据从CPU -> GPU
- (void)postMessageToGPU {
    //处在 -0.5 这个平面上
    GLfloat attrArr[] = {
        -0.5f, -0.5f, -0.5f,  0.0f, 0.0f,
         0.5f, -0.5f, -0.5f,  1.0f, 0.0f,
         0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
         0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
        -0.5f,  0.5f, -0.5f,  0.0f, 1.0f,
        -0.5f, -0.5f, -0.5f,  0.0f, 0.0f,

        -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
         0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
         0.5f,  0.5f,  0.5f,  1.0f, 1.0f,
         0.5f,  0.5f,  0.5f,  1.0f, 1.0f,
        -0.5f,  0.5f,  0.5f,  0.0f, 1.0f,
        -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,

        -0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
        -0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
        -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
        -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
        -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
        -0.5f,  0.5f,  0.5f,  1.0f, 0.0f,

         0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
         0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
         0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
         0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
         0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
         0.5f,  0.5f,  0.5f,  1.0f, 0.0f,

        -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
         0.5f, -0.5f, -0.5f,  1.0f, 1.0f,
         0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
         0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
        -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
        -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,

        -0.5f,  0.5f, -0.5f,  0.0f, 1.0f,
         0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
         0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
         0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
        -0.5f,  0.5f,  0.5f,  0.0f, 0.0f,
        -0.5f,  0.5f, -0.5f,  0.0f, 1.0f
    };
    
    
    GLuint attrBuffer;
    glGenBuffers(1, &attrBuffer); //申请一个顶点数组。
    glBindBuffer(GL_ARRAY_BUFFER, attrBuffer); //bind cpu<->gpu
    glBufferData(GL_ARRAY_BUFFER, sizeof(attrArr), attrArr, GL_DYNAMIC_DRAW); //将数据发送到gpu
    
    //将前面传过去的数据 解释成变量。
    GLuint position = glGetAttribLocation(self.programId, "position"); //为vsh 生成变量。
    glVertexAttribPointer(position, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, NULL);//解释获取方式。
    glEnableVertexAttribArray(position); //使用变量。
    
    GLuint textCoor = glGetAttribLocation(self.programId, "textCoordinate"); //为vsh 生成变量
    glVertexAttribPointer(textCoor, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3 );
    glEnableVertexAttribArray(textCoor);
    
    GLuint textureId = [[OpenGLTextureUtil new] setupTexture:@"for_test"]; //生成一张纹理
    GLuint textbackId = [[OpenGLTextureUtil new] setupTexture:@"textureBack"]; //生成背景纹理
    //绑定不同纹理的关系
    glActiveTexture(GL_TEXTURE0); // 指定纹理单元GL_TEXTURE0
    glBindTexture(GL_TEXTURE_2D, textureId); // 绑定，即可从_textureID中取出图像数据。
    GLuint location = glGetUniformLocation(self.programId, "ourTexture1");
    glUniform1i(location, 0); // 与glActiveTexture指定的纹理单元的序号对应
    
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, textbackId);
    glUniform1i(glGetUniformLocation(self.programId, "ourTexture2"), 1);
    
    
    //2.对shader里面的变量进行赋值。
    GLuint modelLoc = glGetUniformLocation(self.programId, "model"); //模型矩阵变量
    GLKMatrix4 mMatrix = GLKMatrix4Rotate(GLKMatrix4Identity, 45*PI/180, 1, 0, 0);
    glUniformMatrix4fv(modelLoc, 1, GL_FALSE, mMatrix.m);
    
    GLuint viewLoc = glGetUniformLocation(self.programId, "view");//观察矩阵变量
    //观察矩阵可以通过lookat来创建
    GLfloat radius = 10; //观察点的半径
    static GLfloat s = 0; //变量
    GLKMatrix4 vMatrix = GLKMatrix4MakeLookAt(sin(s) * radius, 0, cos(s) * radius, 0, 0, 0, 0, 1, 0);
    s = s + 0.01 * PI;
    glUniformMatrix4fv(viewLoc, 1, GL_FALSE, vMatrix.m);
    
    GLuint projectionLoc = glGetUniformLocation(self.programId, "pro"); //投影矩阵
    GLKMatrix4 projection = GLKMatrix4MakePerspective(PI/4, self.frame.size.width / self.frame.size.height, 0.1, 100);
    glUniformMatrix4fv(projectionLoc, 1, GL_FALSE, projection.m);

}


- (void)glDrawPhoto {
    glDrawArrays(GL_TRIANGLES, 0, 36); //使用openGL将图像绘制出来。
    [self.context presentRenderbuffer:GL_RENDERBUFFER]; //将renderBuffer 的内容展现出来。
}

//MARK: -- 回调
- (void)setTimerDisplay {
    self.displayLink = [CADisplayLink displayLinkWithTarget:[TimerUtil proxyWithDelegate:self] selector:@selector(render)];
    self.displayLink.preferredFramesPerSecond = 60;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)dealloc {
    [self.displayLink invalidate];
    self.displayLink = nil;
}
@end
