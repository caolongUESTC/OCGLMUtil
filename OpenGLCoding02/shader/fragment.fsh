varying lowp vec2 varyTextCoord;

uniform sampler2D ourTexture1;
uniform sampler2D ourTexture2;

void main()
{
    gl_FragColor = mix(texture2D(ourTexture2, varyTextCoord) ,texture2D(ourTexture1, varyTextCoord), 0.4);
}
