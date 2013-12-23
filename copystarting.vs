#version 150
#extension GL_ARB_explicit_attrib_location : enable
out vec2 uv;
void main(void)
{
	const vec2 positions[] = vec2[](vec2(-1,-1), vec2(1,-1), vec2(1,1), vec2(-1,1));//triangle fan
	gl_Position = vec4(0,0,0,1);
	gl_Position.xy = positions[gl_VertexID];
	uv = positions[gl_VertexID]*0.5+vec2(0.5,0.5);
}
