#version 150
#extension GL_ARB_explicit_attrib_location : enable
//@FBOUT radio SMALL FLOAT
//@TEX uvmap_rgba
uniform sampler2D uvmap_rgba;
out vec4 color;
in vec2 uv; 
void main(void)
{
	color = texture(uvmap_rgba, uv);
}
