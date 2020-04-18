shader_type canvas_item;

uniform float relative_time_left : hint_range(0, 1) = 1.0;
uniform vec4 start_color : hint_color;
uniform vec4 end_color : hint_color;

void fragment() {
	COLOR = mix(end_color, start_color, relative_time_left);
}