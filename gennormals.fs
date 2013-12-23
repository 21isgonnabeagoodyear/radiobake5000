#version 150
#extension GL_ARB_explicit_attrib_location : enable
//@FBOUT normals SMALL FLOAT
out vec4 color;
in vec3 normal; 
void main(void)
{
	color = vec4(normal,1);
}
