#version 150
#extension GL_ARB_explicit_attrib_location : enable
uniform int patchoffset;
uniform sampler2D hemicube;
//@TEX hemicube
out vec3 col;

void main(void)
{
	vec4 tcol = texelFetch(hemicube, ivec2(gl_VertexID % 256, gl_VertexID/256), 0);
	col = tcol.rgb*tcol.a;
	col.rgb *= 1/(256.0*256.0);
	col.rgb *= cos(3.1416/2*(gl_VertexID % 256)/256.0);
	col.rgb *= cos(3.1416/2*(gl_VertexID / 256)/256.0);
	gl_Position = vec4((patchoffset % 256)/256.0, (patchoffset/256)/256.0, 0, 1);
	gl_Position.xy = gl_Position.xy*2-vec2(1,1);
}
