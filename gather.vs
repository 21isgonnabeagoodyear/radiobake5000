#version 150
#extension GL_ARB_explicit_attrib_location : enable
uniform int patchoffset;
uniform sampler2D hemicube;
//@TEX hemicube
uniform sampler2D oldradio;//used only to get the resolution
//@TEX oldradio
out vec3 col;
uniform float speed;

void main(void)
{
	vec4 tcol = texelFetch(hemicube, ivec2(gl_VertexID % textureSize(hemicube, 0).x, gl_VertexID/textureSize(hemicube, 0).y), 0);
	tcol.a = clamp(tcol.a, 0, 1);
	col = tcol.rgb*tcol.a;
	col.rgb *= 1/float(textureSize(hemicube, 0).x*textureSize(hemicube, 0).y);
	col.rgb *= 1/5.0;//hemicube has 5 sides
//	col.rgb *= 1/9.0;
//	col.rgb *= 0.000001;
//	col.rgb *= 0.000001;
//	col.rgb *= cos(3.1416/2*(gl_VertexID % 256)/256.0);
//	col.rgb *= cos(3.1416/2*(gl_VertexID / 256)/256.0);
	//col.rgb *= clamp(1-length(vec2(gl_VertexID % textureSize(hemicube, 0).x, gl_VertexID/textureSize(hemicube, 0).x)/textureSize(hemicube, 0).x*2-vec2(1,1)), 0,1);
//	col.rgb *= clamp(dot(normalize(vec3(vec3(vec2(gl_VertexID % textureSize(hemicube, 0).x, gl_VertexID/textureSize(hemicube, 0).x)/textureSize(hemicube, 0).x, 0)*2-vec3(1,1,-1))), vec3(0,0,1)), 0,1);


/*
	vec3 vvec = vec3(gl_VertexID % textureSize(hemicube, 0).x, gl_VertexID/textureSize(hemicube, 0).y, 1);
	vvec.xy = vvec.xy/vec2(textureSize(hemicube, 0).xy);
	vvec.xy = vvec.xy *2-vec2(1,1);
	vvec = normalize(vvec);
	col.rgb *= dot(vvec, vec3(0,0,1));
*/
vec2 texcoord = (vec2(gl_VertexID % textureSize(hemicube, 0).x,gl_VertexID/textureSize(hemicube, 0).y)/vec2(textureSize(hemicube, 0)))*2-vec2(1,1);
col.rgb *= vec3(vec3(dot(normalize(vec3(texcoord.xy, 1)), vec3(0,0,1))));
//col.rgb *= 1000;
//col.rg = texcoord*0.5+vec2(0.5,0.5);
//col.b =0;


	//TODO:lambert cosine
	col.rgb *= speed;//(speed + 20);//speed doesn't seem to be getting set
	gl_Position = vec4((patchoffset % textureSize(oldradio, 0).x)/float(textureSize(oldradio, 0)), (patchoffset/textureSize(oldradio, 0).y)/float(textureSize(oldradio, 0)), 0, 1);
	gl_Position.xy = gl_Position.xy*2-vec2(1,1);
}
