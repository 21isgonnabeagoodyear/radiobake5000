#version 150
#extension GL_ARB_explicit_attrib_location : enable
//@FBOUT positions SMALL FLOAT
out vec4 color;
in vec3 pos; 
void main(void)
{
	color = vec4(pos,1);
}
