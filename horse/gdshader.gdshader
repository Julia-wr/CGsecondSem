shader_type spatial;

uniform float fatness = 0.0;
uniform vec3 my_color : source_color = vec3(1.0, 0.0, 0.0);

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX += fatness * NORMAL;
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = my_color;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
