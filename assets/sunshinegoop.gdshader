shader_type canvas_item;

uniform sampler2D NOISE_PATTERN;
uniform vec2 scroll = vec2(.5, .5);
uniform vec2 scroll2 = vec2(.5, .5);
uniform vec2 noise_scale = vec2(1,1);
uniform vec2 noise_scale2 = vec2(1,1);
uniform sampler2D TONE_MAPPING;
uniform float blur : hint_range(0,7) = 3.0;
uniform float base_intensity : hint_range(0, .5) = .1;
uniform float intensity_factor : hint_range(0, 5.0) = 1.5;
uniform float pauseTime : hint_range(0,1) = 1;

void fragment(){
	float tex_alpha = textureLod(TEXTURE, UV, blur).a;
	float pattern_intensity1 = texture(NOISE_PATTERN, UV * noise_scale + TIME * scroll * pauseTime).r;
	float pattern_intensity2 = texture(NOISE_PATTERN, UV * noise_scale2 + TIME * scroll2 * pauseTime).r;
	float intensity = tex_alpha * intensity_factor * (pattern_intensity1 * pattern_intensity2) + base_intensity;
	COLOR = texture(TONE_MAPPING, vec2(intensity));
}