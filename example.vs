#version 150
#extension GL_ARB_explicit_attrib_location : enable
layout(location=0) in vec3 position;
layout(location=1) in vec3 vertexcolor;
//layout(location=2) in vec3 offset;//used for transform feedback
layout(location=2) in vec3 normal;
layout(location=3) in vec2 uv;

out vec3 col;


uniform mat4 modelviewproj;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}
void main(void)
{
	col = vec3(uv.x, uv.y, 1);//vertexcolor;
	gl_Position = modelviewproj*vec4(position,1);




return;















	mat3 director = mat3(1,0,0,0,1,0,0,0,1);
	int patchoffset = 3;
	int randseed = 3;


	vec3 direction = normalize(((modelviewproj)*vec4(0,0,0,1) - (modelviewproj)*vec4(0,0,1,1) ).xyz);
	vec3 transpos = (vec4(position,1)-inverse(modelviewproj)*vec4(0,0,0,1)).xyz;
	vec3 rotator = vec3(1, 0, 0);

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

	float rotateamount = rand(vec2(patchoffset, randseed))*2*3.14;
	gl_Position.xy = mat2(cos(rotateamount), -sin(rotateamount), sin(rotateamount), cos(rotateamount))*gl_Position.xy;
	gl_Position.xyz = director*gl_Position.xyz;

//	gl_Position.z -= 0.001;//reduce sparklies by moving camera backward?

	//gl_Position.xy *= 0.5;//wider fov

	gl_Position.w = gl_Position.z;
	//gl_Position.z = gl_Position.z * (gl_Position.z/100-1.00000001);
	//gl_Position.z = gl_Position.z * (gl_Position.z/100-1.00000001);
	//gl_Position.z = gl_Position.z * (gl_Position.z/100-1.00000001);
	gl_Position.z = (gl_Position.z/100-1.00000001);
	//gl_Position.z = clamp(gl_Position.z*1000,-1,1)*pow(gl_Position.z, 2)/100-1;
//	gl_Position.z = -gl_Position.z;
	//gl_Position.z = gl_Position.z/100-1.00000001;//***
	//gl_Position.z = gl_Position.z/100-1;
//	gl_Position.z = gl_Position.z*(gl_Position.z * (gl_Position.z/100-1.00000001));
//	gl_Position.z *= gl_Position.z;
//	gl_Position.z = gl_Position.z/100-1.0000000001;
	//gl_Position.z = -gl_Position.z;
//	gl_Position.z = gl_Position.z*0.5+0.5;

	//cameracolor = texelFetch(colors, ivec2(patchoffset % textureSize(normals, 0).x, patchoffset / textureSize(normals, 0).y), 0).xyz;

	//gl_Position = vec4(-dot(horiz, transpos), dot(vert, transpos), dot(direction, transpos)/500.0-1.000001, 1);
//	gl_Position.z = clamp(gl_Position.z, -2, 0.99);


//	norvec = direction;
//	viewvec = transpos;

//	fragdep = dot(director*direction, transpos)/100-0.000001;

//	zdep = gl_Position.z;
}
