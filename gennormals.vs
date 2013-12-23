#version 150
#extension GL_ARB_explicit_attrib_location : enable
layout(location=0) in vec3 position;
layout(location=1) in vec3 vertexcolor;
layout(location=2) in vec3 norm;
layout(location=3) in vec2 uv;

out vec3 normal;
void main(void)
{
	normal = norm;
	gl_Position = vec4(uv.x*2-1, uv.y*2-1, 0,1);
}
