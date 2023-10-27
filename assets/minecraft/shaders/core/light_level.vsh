#version 150

#moj_import <config.glsl>
#moj_import <light.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform vec3 ChunkOffset;
uniform int FogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out vec4 normal;

vec4 color_from_ligh_level(vec4 color, ivec2 uv, vec3 normal);
float fog_distance(mat4 modelViewMat, vec3 pos, int shape);

void main() {
    vec3 pos = Position + ChunkOffset;
    gl_Position = ProjMat * ModelViewMat * vec4(pos, 1.0);

    normal = ProjMat * ModelViewMat * vec4(Normal, 0.0);
    vertexDistance = fog_distance(ModelViewMat, pos, FogShape);

    vec4 lightLevelColor = color_from_ligh_level(Color, UV2, Normal);

    if(lightLevelColor == Color) {
        vertexColor = Color * minecraft_sample_lightmap(Sampler2, UV2);
    } else {
        vertexColor = Color * mix(color_from_ligh_level(Color, UV2, Normal), minecraft_sample_lightmap(Sampler2, UV2), MIX_INTERPOLATION);
    }

    texCoord0 = UV0;
}

vec4 color_from_ligh_level(vec4 color, ivec2 uv, vec3 normal) {
    if(COLOR_ONLY_ON_TOP_OF_BLOCKS && normal.y < 0.5) {
        return color;
    }

    int blockLightLevel = uv.x / 16;

    vec4 lightLevelColor = LIGHT_LEVEL_COLORS[blockLightLevel];

    if(lightLevelColor == NO_COLOR) {
        return color;
    }

    return lightLevelColor;
}

float fog_distance(mat4 modelViewMat, vec3 pos, int shape) {
    if (shape == 0) {
        return length((modelViewMat * vec4(pos, 1.0)).xyz);
    } else {
        float distXZ = length((modelViewMat * vec4(pos.x, 0.0, pos.z, 1.0)).xyz);
        float distY = length((modelViewMat * vec4(0.0, pos.y, 0.0, 1.0)).xyz);
        return max(distXZ, distY);
    }
}