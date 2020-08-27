attribute vec4 position;
attribute vec2 textCoordinate;
varying lowp vec2 varyTextCoord;

uniform mat4 model;
uniform mat4 view;
uniform mat4 pro;
void main()
{
    varyTextCoord = textCoordinate;
    
    vec4 vPos = position;

    vPos =  pro * view * model * vPos;
    //图像翻转
    gl_Position = vPos;
}
