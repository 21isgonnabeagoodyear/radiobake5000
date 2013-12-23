#version 150
#extension GL_ARB_explicit_attrib_location : enable
//@FBOUT radio SMALL FLOAT
out vec4 color;
in vec3 col;
void main(void)
{
	color = vec4(col,1);
}
