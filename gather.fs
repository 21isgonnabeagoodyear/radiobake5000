#version 150
#extension GL_ARB_explicit_attrib_location : enable
//@FBOUT radio SMALL FLOAT
out vec4 color;
in vec3 col;
void main(void)
{
//	if(!(isnan(col.x) ||isnan(col.y)||isnan(col.z)))//prevent NANs from tainting our textures when cross products make zero or whatever
	color = vec4(col,1);
}
