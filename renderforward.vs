#version 150
#extension GL_ARB_explicit_attrib_location : enable
layout(location=0) in vec3 position;
layout(location=1) in vec3 vertexcolor;
layout(location=2) in vec3 normal;//WTF???
layout(location=3) in vec2 uv;

#define NOROT

out vec2 uvpos;
out vec3 cameracolor;
uniform int patchoffset;
out vec3 viewvec;
out vec3 norvec;
out vec3 surfacenormal;
out float fragdep;
out vec4 screenspacepos;
//out vec3 camvec;

//out flat float zdep;

uniform sampler2D normals;
uniform sampler2D positions; 
uniform sampler2D colors; 
//@TEX normals
//@TEX positions
//@TEX colors
uniform float randseed; 

uniform mat3 director;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main(void)
{
	uvpos = uv;
	//vec3 rotator = vec3(0.01, 1, sin(patchoffset+randseed)+1.1);
	vec3 rotator = vec3(0.01, 1, 1.1);

	vec3 direction = texelFetch(normals, ivec2(patchoffset % textureSize(normals, 0).x, patchoffset / textureSize(normals, 0).y), 0).xyz;
	vec3 transpos = position - texelFetch(positions, ivec2(patchoffset % textureSize(positions, 0).x, patchoffset / textureSize(positions, 0).y), 0).xyz /*- direction*0.1*/;
	//gl_ClipDistance[0] = dot(direction, transpos)-0.00000001;
	gl_ClipDistance[0] = dot(direction, transpos);
	//transpos += direction*0.001;

	vec3 horiz = normalize(cross(direction, rotator));
	vec3 vert = normalize(cross(horiz, direction));
	//direction = director*direction;
	//horiz= director*horiz;
	//vert = director*vert;

	gl_Position.z = dot(direction, transpos);
	gl_Position.x = -dot(horiz, transpos-direction*gl_Position.z);
	gl_Position.y = dot(vert, transpos-direction*gl_Position.z);

	//float rotateamount = rand(vec2(patchoffset+0.5374612927640, randseed*0.9372))*3.1415925/2;
	float rotateamount = 0;// rand(vec2(patchoffset+0.5374612927640, randseed*0.9372))*3.1415925/2;
	//float rotateamount = rand(vec2(0.5374612927640, randseed*0.9372))*3.1415925/2;
	//float rotateamount = sin(patchoffset/128*0.5)*3.1416/4;
	//rotateamount = 7.5;
	gl_Position.xy = mat2(cos(rotateamount), -sin(rotateamount), sin(rotateamount), cos(rotateamount))*gl_Position.xy;
	gl_Position.xyz = director*gl_Position.xyz;

//	gl_Position.z -= 0.001;//reduce sparklies by moving camera backward?

	//gl_Position.xy *= 0.5;//wider fov
	//gl_Position.xy *= 1.1;//narrower fov

	

	gl_Position.w = gl_Position.z;
	//gl_Position.z = gl_Position.z * (gl_Position.z/100-1.00000001);
	//gl_Position.z = gl_Position.z * (gl_Position.z/100-1.00000001);
	//gl_Position.z = gl_Position.z * (gl_Position.z/100-1.00000001);
	gl_Position.z = (gl_Position.z/100-0.00001/*-1.00000001*/);
	//gl_Position.z = clamp(gl_Position.z*1000,-1,1)*pow(gl_Position.z, 2)/100-1;
//	gl_Position.z = -gl_Position.z;
	//gl_Position.z = gl_Position.z/100-1.00000001;//***
	//gl_Position.z = gl_Position.z/100-1;
//	gl_Position.z = gl_Position.z*(gl_Position.z * (gl_Position.z/100-1.00000001));
//	gl_Position.z *= gl_Position.z;
//	gl_Position.z = gl_Position.z/100-1.0000000001;
	//gl_Position.z = -gl_Position.z;
//	gl_Position.z = gl_Position.z*0.5+0.5;
	cameracolor = texelFetch(colors, ivec2(patchoffset % textureSize(normals, 0).x, patchoffset / textureSize(normals, 0).y), 0).xyz;
	//gl_Position = vec4(-dot(horiz, transpos), dot(vert, transpos), dot(direction, transpos)/500.0-1.000001, 1);
//	gl_Position.z = clamp(gl_Position.z, -2, 0.99);


	norvec = direction;
	viewvec = transpos;
	surfacenormal = normal;

//	camvec = director*direction;

	fragdep = dot(director*direction, transpos)/100-0.000001;
	screenspacepos = gl_Position;

//	zdep = gl_Position.z;
}
