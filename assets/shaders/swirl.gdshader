shader_type canvas_item;

uniform vec4 color_a : source_color = vec4(0.1, 0.3, 0.8, 1.0);
uniform vec4 color_b : source_color = vec4(0.9, 0.2, 0.5, 1.0);
uniform vec4 edge_color : source_color = vec4(0.5, 0.3, 0.9, 1.0);

uniform float hexes_across : hint_range(5.0, 80.0) = 60.0;

uniform float swirl_speed : hint_range(0.1,5.0) = 1.2;
uniform float swirl_strength : hint_range(0.0,10.0) = 4.0;
uniform float swirl_scale : hint_range(0.1,10.0) = 1.0;

uniform float edge_thickness : hint_range(0.0, 0.2) = 0.05;
uniform float edge_softness : hint_range(0.0, 0.1) = 0.01;

// --- HEX FUNCTIONS ---
vec3 pixel_to_hex(vec2 pos, float hex_size) {
    float q = (sqrt(3.0)/3.0 * pos.x - 1.0/3.0 * pos.y) / hex_size;
    float r = (2.0/3.0 * pos.y) / hex_size;
    float x = q;
    float z = r;
    float y = -x - z;
    return vec3(x, y, z);
}

vec3 cube_round(vec3 cube) {
    float rx = round(cube.x);
    float ry = round(cube.y);
    float rz = round(cube.z);

    float x_diff = abs(rx - cube.x);
    float y_diff = abs(ry - cube.y);
    float z_diff = abs(rz - cube.z);

    if (x_diff > y_diff && x_diff > z_diff) {
        rx = -ry - rz;
    } else if (y_diff > z_diff) {
        ry = -rx - rz;
    } else {
        rz = -rx - ry;
    }

    return vec3(rx, ry, rz);
}

vec2 hex_to_pixel(vec3 cube, float hex_size) {
    float x = hex_size * sqrt(3.0) * (cube.x + cube.z/2.0);
    float y = hex_size * 3.0/2.0 * cube.z;
    return vec2(x, y);
}

// Hexagon distance from center (flat-top)
float hex_distance(vec2 p) {
    p = abs(p);
    return max(p.x * 0.57735 + p.y * 0.5, p.y); // 0.57735 = tan(30°)
}

void fragment() {
    vec2 uv = FRAGCOORD.xy / vec2(SCREEN_PIXEL_SIZE); // normalized to pixels
    float hex_size = SCREEN_PIXEL_SIZE.x / hexes_across;
    vec2 pos = uv * SCREEN_PIXEL_SIZE;

    // --- HEX GRID ---
    vec3 hex = pixel_to_hex(pos, hex_size);
    vec3 rounded = cube_round(hex);
    vec2 center = hex_to_pixel(rounded, hex_size);
    vec2 local = pos - center;

    // --- Keep aspect ratio ---
    local.x *= SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;

    float dist = hex_distance(local / hex_size);

    // --- COLOR WAVE ---
    float wave = sin((pos.x + pos.y) * 0.02 + TIME);
    float t = (wave + 1.0) * 0.5;
    vec4 col = mix(color_a, color_b, t);

    // --- HEX EDGES ---
    float outer = smoothstep(1.0, 1.0 - edge_softness, dist);
    float inner = smoothstep(
        1.0 - edge_thickness,
        1.0 - edge_thickness - edge_softness,
        dist
    );
    float edge = outer - inner;
    col = mix(col, edge_color, edge);

    COLOR = col;
}
