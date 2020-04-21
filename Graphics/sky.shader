shader_type canvas_item;

uniform float time_passed : hint_range(0, 1) = 0.0;
uniform sampler2D gradient;


float o_plus_1(float x, float y) {
	return x + y - x * y;
}
vec2 o_plus_2(vec2 x, vec2 y) {
	return x + y - x * y;
}
vec3 o_plus_3(vec3 x, vec3 y) {
	return x + y - x * y;
}
vec4 o_plus_4(vec4 x, vec4 y) {
	return x + y - x * y;
}


void fragment() {
	float rise_time = min(time_passed, 0.5);
	float grow_time = 2.0 * max(0.0, time_passed - 0.5);
	vec2 sun_center = vec2(0.5, 1.0 - rise_time);
	float sun = 1.0 - (6.0 - 5.0 * grow_time) * distance(UV, sun_center);
	
	//COLOR = o_plus_4(start_color, sun * end_color);
	COLOR = texture(gradient, vec2(sun, 0.5));
}