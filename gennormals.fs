#version 150
#extension GL_ARB_explicit_attrib_location : enable
//@FBOUT normals SMALL FLOAT
layout(location=0) out vec4 norbuf; 
//@FBOUT positions SMALL FLOAT
layout(location=1) out vec4 posbuf; 
//@FBOUT colors SMALL FLOAT
layout(location=2) out vec4 colbuf; 
in vec3 normal; 
in vec3 pos; 
in vec3 col; 
void main(void)
{
	norbuf = vec4(normal,1);
	posbuf = vec4(pos,1);
	colbuf = vec4(col,1);
}
