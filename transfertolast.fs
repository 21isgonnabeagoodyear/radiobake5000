#version 150
#extension GL_ARB_explicit_attrib_location : enable
//@FBOUT oldradio SMALL FLOAT
//@TEX radio
uniform sampler2D radio; 
out vec4 color;
in vec2 uv; 
void main(void)
{
	color = texture(radio, uv);
	color.a =1;
//	color.rgb = color.rgb*100;
}
