#version 150
#extension GL_ARB_explicit_attrib_location : enable
//@FBOUT hemicube SMALL FLOAT
//@FBDEP hemicubedep
//@TEX uvmap_rgba
uniform sampler2D uvmap_rgba;
out vec4 color;
in vec2 uvpos;
in vec3 cameracolor; 
void main(void)
{
	//color = vec4(col,1);
	color = texture(uvmap_rgba, uvpos);
	color.rgb *= cameracolor;
//	color = vec4(1,1,1,1)*(int(gl_FragCoord.x) & int(gl_FragCoord.y));
}
