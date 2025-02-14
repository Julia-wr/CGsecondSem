shader_type spatial;

render_mode skip_vertex_transform;
uniform vec3 my_albedo : source_color = vec3(0.5,0.5,0.5);

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	VERTEX.y += -0.01 * VERTEX.z * VERTEX.z;
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = my_albedo;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
