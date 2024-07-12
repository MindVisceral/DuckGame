shader_type spatial;
render_mode unshaded, cull_disabled;


uniform float lightning = 1;

void fragment() {
	ALBEDO = vec3(lightning, lightning, lightning);
}