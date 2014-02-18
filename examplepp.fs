#version 150
#extension GL_ARB_explicit_attrib_location : enable

out vec4 color;
in vec2 sspos;
uniform sampler2D unprocessedscreen;
uniform sampler2D unprocessedscreendepth;
uniform sampler2D normals;
uniform sampler2D positions; 
uniform sampler2D colors; 
uniform sampler2D hemicube; 
uniform sampler2D radio; 
uniform sampler2D oldradio; 
uniform sampler2D hemicubedep; 
//@TEX unprocessedscreen
//@TEX unprocessedscreendepth
//@TEX normals
//@TEX positions
//@TEX colors
//@TEX hemicube
//@TEX radio
//@TEX oldradio
//@TEX hemicubedep


float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

#define NUMSAMPLES 30

vec2 complexsquare(vec2 inc)
{
	return vec2(inc.x*inc.x-inc.y*inc.y, inc.x*inc.y+inc.y*inc.x);
}
float avgbright(){
	float rval = 0;
	for(int i=0;i<5;i++)
		for(int j=0;j<5;j++)
			rval += length(texture(unprocessedscreen, vec2(0.2*i,0.2*j)).rgb);
	return rval/25.0;
}

void main(void)
{
	color = texture(unprocessedscreen, sspos.xy*0.5+vec2(0.5,0.5));
	//color.rgb /= clamp(avgbright()*2, 0.1, 2.0);
	color.a = 1;
	if(gl_FragCoord.x < 256 && gl_FragCoord.y < 256 )
		color = texture(normals, gl_FragCoord.xy/256.0)*0.5+vec4(0.5,0.5,0.5,0.5);
	else if(gl_FragCoord.x < 256 *2 && gl_FragCoord.y < 256 )
		color = texture(positions, gl_FragCoord.xy/256.0-vec2(1,0))*0.5+vec4(0.5,0.5,0.5,0.5);
	else if(gl_FragCoord.x < 256 *3 && gl_FragCoord.y < 256 )
		color = texture(colors, gl_FragCoord.xy/256.0-vec2(2,0))*0.5+vec4(0.5,0.5,0.5,0.5);
	else if(gl_FragCoord.x < 256 *4 && gl_FragCoord.y < 256 )
//{
		color = 5*texture(hemicube, gl_FragCoord.xy/256.0-vec2(3,0));
//color.xy = (gl_FragCoord.xy/256.0-vec2(3,0))*2-vec2(1,1);
//color = vec4(vec3(dot(normalize(vec3(color.xy, 1)), vec3(0,0,1))),1);
//}
	else if(gl_FragCoord.x < 256 *5 && gl_FragCoord.y < 256 )
		{color = vec4(fract(50*texture(hemicubedep, gl_FragCoord.xy/256.0-vec2(4,0))));color.a=1;}
	else if(gl_FragCoord.x < 256 *6 && gl_FragCoord.y < 256 )
		color = texture(radio, gl_FragCoord.xy/256.0-vec2(5,0));
	else if(gl_FragCoord.x < 256 *7 && gl_FragCoord.y < 256 )
		color = texture(oldradio, gl_FragCoord.xy/256.0-vec2(6,0));
	//color.a =1;

}
