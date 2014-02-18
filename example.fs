#version 150
#extension GL_ARB_explicit_attrib_location : enable
//@FBOUT unprocessedscreen SCREEN
//@FBDEP unprocessedscreendepth
//@TEX radio
//@TEX somegrungytexture_rgba
//uniform sampler2D uvmap_rgba;
uniform sampler2D radio; 
uniform sampler2D somegrungytexture_rgba; 
out vec4 color;
uniform mat4 modelviewproj;
in vec3 col;
void main(void)
{
	color = vec4(col,1);
	//color = texture(uvmap_rgba, color.xy);
	color = texture(radio, color.xy);
	//color.r = sqrt(color.r);
	//color.g = sqrt(color.g);
	//color.b = sqrt(color.b);

	color.r = log(color.r*10+1);
	color.g = log(color.g*10+1);
	color.b = log(color.b*10+1);
//	color.rgb *= vec3(0.9)+0.2*texture(somegrungytexture_rgba, col.xy).rgb;
//	color = vec4(1,1,1,1)*(int(gl_FragCoord.x) & int(gl_FragCoord.y));
}
