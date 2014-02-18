#version 150
#extension GL_ARB_explicit_attrib_location : enable
//@FBOUT oldradio SMALL FLOAT
//@FBOUT radio SMALL FLOAT
//@TEX uvmap_rgba
uniform sampler2D uvmap_rgba;
layout(location=0) out vec4 oldradio;
layout(location=1) out vec4 radio;
in vec2 uv; 
void main(void)
{
	radio = oldradio= texture(uvmap_rgba, uv);
	radio.rgb *= 5;
	oldradio.rgb *= 5;
	
	//radio *= 10;
	//oldradio *= 10;
//	color.rgb = color.rgb*100;
}
