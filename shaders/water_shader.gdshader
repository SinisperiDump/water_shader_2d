shader_type canvas_item;
uniform sampler2D noise: repeat_enable;
uniform float speed: hint_range(0.0, 100.0, 1.0);
uniform float opacity: hint_range(0.0, 1.0, 0.01);
uniform float detail: hint_range(0.0, 1.0, 0.01);
void fragment() {
	float t = TIME / 1000.0 * speed;
	vec2 texture_size = vec2(textureSize(TEXTURE, 0));
	vec2 texture_coords = UV * texture_size; // coords from 0.0 to 64.0
	vec2 rounded_coords = floor(texture_coords);
	vec2 george = rounded_coords / texture_size; // normalized coords, from 0.0 to 1.0
	vec4 noise_color = texture(noise, george + t);
	if(COLOR.b > 0.6)
	{
		COLOR.rgb += COLOR.rgb * smoothstep(1.0 - detail, 1.0, noise_color.r) * opacity;
	}
}
