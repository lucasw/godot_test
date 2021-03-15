shader_type spatial;
// render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;
// render_mode skip_vertex_transform, diffuse_lambert_wrap, specular_phong;
render_mode skip_vertex_transform, diffuse_lambert_wrap, blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx;

uniform vec4 albedo : hint_color;
uniform sampler2D texture_albedo : hint_albedo;
uniform float specular;
uniform float metallic;
uniform float roughness : hint_range(0,1);
uniform float point_size : hint_range(0,128);
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;

uniform float resolution = 256;
uniform float cull_distance = 900.0;

varying vec4 vertex_coordinates;


void vertex() {
	UV=UV * uv1_scale.xy + uv1_offset.xy;
 
    // https://github.com/marmitoTH/godot-psx-shaders/blob/master/PSX%20Shaders/psx_lit.shader

    // TODO(lucasw) this interacts poorly with omni-light
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	NORMAL = abs(vec4(NORMAL, 1.) * MODELVIEW_MATRIX).xyz;
	float vPos_w = (PROJECTION_MATRIX * vec4(VERTEX, 1.0)).w;
	VERTEX.xy = vPos_w * floor(resolution * VERTEX.xy / vPos_w) / resolution;
	vertex_coordinates = vec4(UV * VERTEX.z, VERTEX.z, .0);
	
    // TODO(lucasw) make this optional
    float vertex_distance = length((MODELVIEW_MATRIX * vec4(VERTEX, 1.0)));
	if (vertex_distance > cull_distance) {
		VERTEX = vec3(.0);
    }
}

void fragment() {
  	vec4 albedo_tex = texture(texture_albedo, vertex_coordinates.xy / vertex_coordinates.z);
	// vec4 albedo_tex = texture(texture_albedo, UV);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	METALLIC = metallic;
	ROUGHNESS = roughness;
	SPECULAR = specular;
}