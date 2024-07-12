shader_type spatial;
render_mode unshaded, cull_disabled;


uniform float lightning = 0.0;

void fragment() {
	ALBEDO = vec3(lightning, lightning, lightning);
}