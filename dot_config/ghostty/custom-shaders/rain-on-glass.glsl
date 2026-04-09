// Rain on Glass - Ghostty Shader (Optimized v2)
// Based on original HTML/WebGL shader

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

// ============================================================
// AMBER CITY BACKGROUND
// ============================================================
vec3 background(vec2 uv) {
    // Deep indigo to amber gradient
    vec3 bot = vec3(0.5, 0.25, 0.05);
    vec3 top = vec3(0.05, 0.04, 0.10);
    vec3 col = mix(bot, top, smoothstep(0.0, 1.0, uv.y));

    // Simple skyline
    for (float i = 0.0; i < 5.0; i++) {
        float h = hash(vec2(i, 0.0));
        float x = i / 5.0 + h * 0.05;
        float bh = h * 0.35 + 0.08;
        float mask = step(x, uv.x) * step(uv.x, x + 0.16) * step(uv.y, bh) * step(0.08, uv.y);
        col = mix(col, vec3(0.04, 0.03, 0.06), mask * 0.6);
    }

    // Bokeh lights
    for (float i = 0.0; i < 5.0; i++) {
        vec2 p = vec2(hash(vec2(i, 1.0)), hash(vec2(i, 2.0)) * 0.5 + 0.15);
        float b = smoothstep(0.08, 0.0, length(uv - p)) * 0.25;
        col += vec3(1.0, 0.7, 0.35) * b;
    }

    return col;
}

// ============================================================
// DROPS
// ============================================================
float dropAlpha(vec2 uv, vec2 center, float radius) {
    vec2 d = uv - center;
    d.y *= 1.15;
    float dist = length(d);
    if (dist > radius) return 0.0;
    // Only inner 35% strongly visible
    return max(0.0, 1.0 - pow(dist / (radius * 0.35), 6.0));
}

vec3 dropRefract(vec2 uv, vec2 center, float radius) {
    vec2 d = uv - center;
    d.y *= 1.15;
    float dist = length(d);
    if (dist > radius) return vec3(0.5, 0.5, 0.0);

    vec2 n = dist > 0.001 ? d / dist : vec2(0.0);
    float t = dist / radius;
    float strength = t;

    return vec3(
        n.y * 0.25 * strength + 0.5,
        n.x * 0.25 * strength + 0.5,
        sqrt(max(0.0, 1.0 - t * t))
    );
}

// ============================================================
// MAIN
// ============================================================
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 texCoord = uv;
    uv.y = 1.0 - uv.y;

    vec3 bg = background(uv);

    // Water map: R=vertical, G=horizontal, B=depth, A=alpha
    vec4 water = vec4(0.5, 0.5, 0.0, 0.0);

    // 6 falling drops with trails
    for (float i = 0.0; i < 6.0; i++) {
        float speed = 0.12 + hash(vec2(i, 0.0)) * 0.12;
        float y = fract(hash(vec2(i, 1.0)) + iTime * speed);
        float x = 0.05 + hash(vec2(i, 2.0)) * 0.9;
        float size = 0.012 + hash(vec2(i, 3.0)) * 0.018;

        vec2 center = vec2(x, y);
        float alpha = dropAlpha(uv, center, size);

        if (alpha > 0.001) {
            water = vec4(dropRefract(uv, center, size), max(water.a, alpha));
        }

        // Trail (3 segments)
        for (float t = 1.0; t <= 3.0; t++) {
            float ty = y - t * size * 0.8;
            if (ty < 0.0) ty += 1.0;
            float ta = dropAlpha(uv, vec2(x, ty), size * (1.0 - t * 0.25)) * 0.3;
            if (ta > water.a * 0.5) water.a = ta;
        }
    }

    // 8 static droplets
    for (float i = 0.0; i < 8.0; i++) {
        vec2 center = vec2(
            0.02 + hash(vec2(i + 20.0, 0.0)) * 0.96,
            0.02 + hash(vec2(i + 20.0, 1.0)) * 0.96
        );
        float size = 0.002 + hash(vec2(i + 20.0, 2.0)) * 0.005;

        float alpha = dropAlpha(uv, center, size) * 0.7;
        if (alpha > water.a * 0.3) {
            water = vec4(dropRefract(uv, center, size), alpha);
        }
    }

    // Extract
    float y = water.r;
    float x = water.g;
    float d = water.b;

    // More lenient alpha threshold for visible drops
    float a = clamp(water.a * 3.0 - 0.5, 0.0, 1.0);

    // Refraction
    vec2 refr = (vec2(x, y) - 0.5) * 2.0;
    vec2 offset = refr * (256.0 + d * 256.0) / iResolution.xy;

    // Sample terminal
    vec2 termUV = clamp(texCoord + offset * 0.025, 0.0, 1.0);
    vec4 terminal = texture(iChannel0, termUV);
    vec4 sharp = texture(iChannel0, texCoord);

    // Blend
    vec3 final = mix(bg, terminal.rgb * 1.04, a);
    final = mix(final, sharp.rgb, sharp.a * 0.95);

    fragColor = vec4(final, max(sharp.a, a * 0.2));
}
