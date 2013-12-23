#version 150
#extension GL_ARB_explicit_attrib_location : enable
layout(location=0) in vec3 position;
layout(location=1) in vec3 vertexcolor;
layout(location=2) in vec2 normal;
layout(location=3) in vec2 uv;

out vec2 uvpos;
out vec3 cameracolor;
uniform int patchoffset;

uniform sampler2D normals;
uniform sampler2D positions; 
uniform sampler2D colors; 
//@TEX normals
//@TEX positions
//@TEX colors

void main(void)
{
	uvpos = uv;
	vec3 direction = texelFetch(normals, ivec2(patchoffset % textureSize(normals, 0).x, patchoffset / textureSize(normals, 0).y), 0).xyz;
	vec3 transpos = position - texelFetch(positions, ivec2(patchoffset % textureSize(positions, 0).x, patchoffset / textureSize(positions, 0).y), 0).xyz;
	vec3 horiz = normalize(cross(direction, vec3(0,1,0.1)));
	vec3 vert = normalize(cross(horiz, direction));
	gl_Position.z = dot(direction, transpos);
	gl_Position.x = -dot(horiz, transpos-direction*gl_Position.z);
	gl_Position.y = dot(vert, transpos-direction*gl_Position.z);
	gl_Position.w =gl_Position.z;
	gl_Position.z = gl_Position.z * (gl_Position.z/100-1.00001);
	cameracolor = texelFetch(colors, ivec2(patchoffset % textureSize(normals, 0).x, patchoffset / textureSize(normals, 0).y), 0).xyz;
	//gl_Position = vec4(-dot(horiz, transpos), dot(vert, transpos), dot(direction, transpos)/500.0-1.000001, 1);
//	gl_Position.z = clamp(gl_Position.z, -2, 0.99);
}
