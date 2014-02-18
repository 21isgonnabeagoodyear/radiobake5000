#version 150
#extension GL_ARB_explicit_attrib_location : enable
//@FBOUT hemicube SMALL FLOAT
//@FBDEP hemicubedep
//@TEX oldradio
uniform sampler2D oldradio;//uvmap_rgba;
out vec4 color;
in vec2 uvpos;
in vec3 cameracolor; 
in vec3 surfacenormal;
in flat float fragdep;
in vec4 screenspacepos;

in vec3 viewvec;
in vec3 norvec;
in vec3 camvec;
void main(void)
{
	//color = vec4(col,1);
	color = texture(oldradio, uvpos);
	color.rgb *= cameracolor;
	color.a =1;

	color.rgb *= vec3(dot(normalize(viewvec), norvec));//lambertian reflectance

	color.rgb *= clamp(-1000*dot(surfacenormal, viewvec), 0, 1);//back face opaque
//	color.rgb = vec3(dot(normalize(camvec), normalize(viewvec)));
	//color.rgb = 1/5.0*vec3(1-length(screenspacepos.xy/screenspacepos.w));

//	gl_FragDepth = fragdep;

	//color.rgb = vec3(dot(normalize(viewvec), norvec));
//	color = vec4(1,1,1,1)*(int(gl_FragCoord.x) & int(gl_FragCoord.y));
}
