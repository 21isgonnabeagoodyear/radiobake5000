#version 150
#extension GL_ARB_explicit_attrib_location : enable

out vec4 color;
in vec2 sspos;
uniform sampler2D unprocessedscreen;
uniform sampler2D unprocessedscreendepth;
uniform sampler2D normals;
uniform sampler2D positions; 
//@TEX unprocessedscreen
//@TEX unprocessedscreendepth
//@TEX normals
//@TEX positions


float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

#define NUMSAMPLES 30

vec2 complexsquare(vec2 inc)
{
	return vec2(inc.x*inc.x-inc.y*inc.y, inc.x*inc.y+inc.y*inc.x);
}

void main(void)
{
	color = texture(unprocessedscreen, sspos.xy*0.5+vec2(0.5,0.5));
	if(gl_FragCoord.x < 256 && gl_FragCoord.y < 256 )
		color = texture(normals, gl_FragCoord.xy/256.0)*0.5+vec4(0.5,0.5,0.5,0.5);
	else if(gl_FragCoord.x < 256 *2 && gl_FragCoord.y < 256 )
		color = texture(positions, gl_FragCoord.xy/256.0-vec2(1,0))*0.5+vec4(0.5,0.5,0.5,0.5);

}