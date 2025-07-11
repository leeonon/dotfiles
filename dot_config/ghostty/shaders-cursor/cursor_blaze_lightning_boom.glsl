#define PI 3.14159265359
// Standalone implementation of lightning and explosion cursor effects
// Uses pre-declared uniforms from the cursor system:
// iResolution, iTime, iCurrentCursor, iPreviousCursor, iTimeCursorChange, iChannel0

// Random number generator must be defined first
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

// Color schemes - uncomment your preferred one
// Original blue-white scheme
//#define COLOR_SCHEME_BLUE
// Gold-purple scheme
#define COLOR_SCHEME_GOLD_PURPLE

// Randomly choose between color schemes based on time and position
vec4 getLightningCoreColor(vec2 pos) {
    float choice = random(vec2(floor(iTime * 0.5), pos.x * 100.0 + pos.y * 50.0));
    if (choice > 0.5) {
        return vec4(1.0, 0.9, 0.2, 1.0);  // Gold core
    } else {
        return vec4(0.8, 0.9, 1.0, 1.0);  // Blue-white core
    }
}

vec4 getLightningEdgeColor(vec2 pos) {
    float choice = random(vec2(floor(iTime * 0.5), pos.x * 100.0 + pos.y * 50.0));
    if (choice > 0.5) {
        return vec4(0.7, 0.2, 1.0, 0.7); // Purple edges
    } else {
        return vec4(0.4, 0.6, 1.0, 0.7);  // Blue edges
    }
}
// Balanced ray parameters for fire explosion
#define RAY_BRIGHTNESS 8.0
#define RAY_GAMMA 3.0
#define RAY_DENSITY 3.5
#define RAY_CURVATURE 10.0
#define RAY_RED 2.5
#define RAY_GREEN 1.0
#define RAY_BLUE 0.3

// Balanced fire explosion colors
const vec4 EXPLOSION_CORE1_COLOR = vec4(1.0, 0.95, 0.7, 1.0);   // White-hot core
const vec4 EXPLOSION_CORE2_COLOR = vec4(1.0, 0.85, 0.3, 1.0);   // Bright yellow
const vec4 EXPLOSION_HOT1_COLOR = vec4(1.0, 0.7, 0.2, 1.0);      // Yellow-orange 
const vec4 EXPLOSION_HOT2_COLOR = vec4(1.0, 0.5, 0.1, 1.0);      // Orange
const vec4 EXPLOSION_MID1_COLOR = vec4(1.0, 0.3, 0.0, 1.0);      // Orange-red
const vec4 EXPLOSION_MID2_COLOR = vec4(1.0, 0.2, 0.0, 1.0);      // Red
const vec4 EXPLOSION_COOL_COLOR = vec4(0.8, 0.1, 0.0, 1.0);      // Deep red

float distanceToLine(vec2 p, vec2 a, vec2 b) {
    vec2 pa = p - a;
    vec2 ba = b - a;
    float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    return length(pa - ba * h);
}

// Inspired by https://www.shadertoy.com/view/XlsGWS
// Created by S.Guillitte (CC BY-NC-SA 3.0)

float hash(float x) {
    return fract(21654.6512 * sin(385.51 * x));
}

float hash(vec2 p) {
    return fract(sin(p.x*15.32+p.y*35.78) * 43758.23);
}

vec2 hash2(vec2 p) {
    return vec2(hash(p*.754),hash(1.5743*p.yx+4.5891))-.5;
}

vec2 noise2(vec2 x) {
    vec2 p = floor(x);
    vec2 f = fract(x);
    f = f*f*(3.0-2.0*f);
    vec2 res = mix(mix(hash2(p), hash2(p + vec2(1.0,0.0)),f.x),
                   mix(hash2(p + vec2(0.0,1.0)), hash2(p + vec2(1.0,1.0)),f.x),f.y);
    return res;
}

float dseg(vec2 ba, vec2 pa) {
    float h = clamp(dot(pa,ba)/dot(ba,ba), -0.2, 1.);
    return length(pa - ba*h);
}

float arc(vec2 x, vec2 p, vec2 dir) {
    vec2 r = p;
    float d = 10.;
    for (int i = 0; i < 5; i++) {
        vec2 s = noise2(r+iTime)+dir;
        d = min(d,dseg(s,x-r));
        r += s;
    }
    return d*3.;
}

float lightningBranches(vec2 p, vec2 start, vec2 end, float width) {
    // Convert to reference shader's coordinate space
    vec2 x = (p - start) * 10.0;
    vec2 tgt = (end - start) * 10.0;
    
    vec2 r = tgt;
    float d = 1000.;
    float dist = length(tgt-x);
     
    // Main lightning path 
    for (int i = 0; i < 19; i++) {
        if(r.y > x.y + 5.0) break;  // Standard Y direction check
        vec2 s = (noise2(r+iTime)+vec2(0.0,0.7))*2.0;
        dist = dseg(s,x-r);
        d = min(d,dist);
        
        r += s;
        if(i-(i/5)*5==0) {
            if(i-(i/10)*10==0) d = min(d,arc(x,r,vec2(0.3,0.5)));
            else d = min(d,arc(x,r,vec2(-0.3,0.5)));
        }
    }
    
    float lightning = exp(-5.0*d) + 0.2*exp(-1.0*dist);
    return clamp(lightning, 0.0, 1.0);
}

// Noise function inspired by reference shader
float rayNoise(vec2 x) {
    return texture(iChannel0, x*.01).x;
}

// Flaring generator - inspired by reference shader
mat2 m2 = mat2(0.80, 0.60, -0.60, 0.80);
float rayFbm(vec2 p) {    
    float z = 2.0;
    float rz = -0.05;
    p *= 0.25;
    for (int i = 1; i < 6; i++) {
        rz += abs((rayNoise(p)-0.5)*2.)/z;
        z = z*1.8;
        p = p*2.0*m2;
    }
    return rz;
}

float explosionEffect(vec2 p, vec2 center, float radius) {
    vec2 uv = (p - center) / radius;
    float dist = length(uv);
    float angle = atan(uv.y, uv.x);
    
    // Directionally varied core
    float coreAngle = angle + iTime * 2.0;
    float core = pow(smoothstep(0.4, 0.0, dist), 0.5) * 
                (3.0 + 1.0 * sin(coreAngle * 5.0 + iTime * 10.0));
    
    // Asymmetric shockwaves
    float shockwave1 = smoothstep(0.2, 0.0, abs(dist - 0.2)) * 
                      (0.8 + 0.4 * sin(angle * 8.0 + iTime * 20.0));
    float shockwave2 = smoothstep(0.15, 0.0, abs(dist - 0.3)) * 
                      (0.7 + 0.5 * cos(angle * 6.0 - iTime * 15.0));
    
    // Combine with extreme contrast
    float explosion = max(core, max(shockwave1, shockwave2));
    
    // Sharp falloff with noise
    float falloff = smoothstep(0.6, 0.4, dist);
    falloff *= 1.0 - 0.3 * random(vec2(floor(angle * 10.0), floor(dist * 10.0)));
    
    return clamp(explosion * falloff, 0.0, 1.0);
}

vec2 normalizeCoord(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

vec2 getRectangleCenter(vec4 rectangle) {
    return vec2(rectangle.x + (rectangle.z / 2.), rectangle.y - (rectangle.w / 2.));
}

float blend(float t) {
    float sqr = t * t;
    return sqr / (2.0 * (sqr - t) + 1.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Start with background texture
    vec4 baseColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    
    vec2 vu = normalizeCoord(fragCoord, 1.);
    vec4 currentCursorData = vec4(normalizeCoord(iCurrentCursor.xy, 1.), normalizeCoord(iCurrentCursor.zw, 0.));
    vec4 previousCursorData = vec4(normalizeCoord(iPreviousCursor.xy, 1.), normalizeCoord(iPreviousCursor.zw, 0.));
    
    float progress = blend(clamp((iTime - iTimeCursorChange) / 0.1, 0.0, 1.0));
    
    if (progress < 1.0) {
        vec2 centerCC = getRectangleCenter(currentCursorData);
        vec2 centerCP = getRectangleCenter(previousCursorData);
        float lineLength = distance(centerCC, centerCP);
        
        // Lightning effect when moving right
        if (currentCursorData.x > previousCursorData.x) {
            // Lightning strikes from top of screen (y = 1.0 in normalized coords)
            vec2 lightningStart = vec2(centerCC.x, 1.0);
            // Invert Y coordinate for macOS in the lightning calculation
            vec2 lightningVu = vec2(vu.x, -vu.y);
            vec2 lightningCC = vec2(centerCC.x, -centerCC.y);
            float lightning = lightningBranches(lightningVu, lightningStart, lightningCC, 0.01);
            
            // Core lightning color with random scheme
            vec4 lightningCore = getLightningCoreColor(fragCoord.xy);
            vec4 lightningEdge = getLightningEdgeColor(fragCoord.xy);
            vec4 lightningColor = mix(lightningEdge, lightningCore, lightning);
            
            // Add golden glow if gold scheme is chosen
            if (random(vec2(floor(iTime * 0.5), fragCoord.x * 0.1)) > 0.5) {
                lightningColor.rgb += vec3(0.1, 0.08, 0.0) * lightning * 0.5;
            }
            float lightningAlpha = lightning * (1.0 - progress) * 1.2;
            
            baseColor = mix(baseColor, lightningColor, lightningAlpha);
        }
        // Explosion effect when moving left
        else {
            // Larger explosion (2x size) with directional randomness
            float randSize = 0.1 + 0.1 * pow(random(vec2(iTime*2.0, centerCP.x)), 3.0);
            
            // Position firmly at bottom-right of cursor (accounting for macOS inverted Y)
            vec2 explosionPos = centerCP + vec2(
                currentCursorData.z * 0.5,  // Right offset
                currentCursorData.w * 0.5  // Bottom offset (positive Y for bottom on macOS)
            );
            
            // Add some jitter but keep it bottom-right
            explosionPos += vec2(
                random(vec2(iTime, centerCP.x)) * 0.05,
                random(vec2(iTime, centerCP.y)) * 0.05
            );
            
            // Explosion biased towards bottom-right direction
            float explosion = explosionEffect(vu, explosionPos, randSize);
            
            // Add secondary explosions in bottom-right quadrant
            for (int i = 0; i < 2; i++) {
                vec2 dir = normalize(vec2(
                    0.5 + random(vec2(float(i), iTime)) * 0.5,  // Right bias
                    0.5 + random(vec2(float(i)*1.7, iTime+1.0)) * 0.5  // Bottom bias
                ));
                vec2 offsetPos = explosionPos + dir * randSize * 0.15;
                explosion += explosionEffect(vu, offsetPos, randSize * 0.8);
            }
            explosion = clamp(explosion, 0.0, 1.0);
            
            // Calculate explosion UVs with directional bias
            vec2 explosionUV = (vu - explosionPos) / randSize;
            float angle = atan(explosionUV.y, explosionUV.x);
            
            // High-contrast fire color with directional variation
            vec3 fireColor = mix(
                vec3(1.0, 1.0, 0.3), // bright yellow
                vec3(1.0, 0.1, 0.0), // intense red
                pow(explosion, 0.5 + 0.3*sin(angle*3.0 + iTime*5.0))
            );
            
            // Add directional sparks
            float sparks = smoothstep(0.7, 1.0, explosion) * 
                         (0.8 + 0.2 * sin(iTime * 100.0 + angle * 20.0));
            fireColor = mix(fireColor, vec3(1.0), sparks * 1.2);
            
            float explosionAlpha = explosion * (1.0 - progress) * 2.5;
            baseColor.rgb = max(baseColor.rgb, fireColor * explosionAlpha);
        }
    }
    
    fragColor = baseColor;
}
