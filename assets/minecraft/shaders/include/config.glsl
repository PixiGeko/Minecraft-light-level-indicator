#version 150

vec4 rgb_to_vec4(int r, int g, int b);

vec4 NO_COLOR = vec4(0);

// --------------------------- \/ CHANGE THIS \/ --------------------------- //


// predifined colors, you can change them
vec4 RED = rgb_to_vec4(255, 0, 0);
vec4 ORANGE = rgb_to_vec4(255, 167, 0);
vec4 GREEN = rgb_to_vec4(0, 255, 0);

// you can use any color here, or NO_COLOR if you don't want a color
vec4 LIGHT_LEVEL_COLORS[16] = vec4[](
    RED, // Light level of 0
    ORANGE, // Light level of 1
    ORANGE, // Light level of 2
    ORANGE, // Light level of 3
    ORANGE, // Light level of 4
    ORANGE, // Light level of 5
    ORANGE, // Light level of 6
    ORANGE, // Light level of 7
    NO_COLOR, // Light level of 8
    NO_COLOR, // Light level of 9
    NO_COLOR, // Light level of 10
    NO_COLOR, // Light level of 11
    NO_COLOR, // Light level of 12
    NO_COLOR, // Light level of 13
    NO_COLOR, // Light level of 14
    NO_COLOR // Light level of 15
);


// true = only the top of the block is colored
// false = the entire block is colored
bool COLOR_ONLY_ON_TOP_OF_BLOCKS = true;


// value between 0 and 1 (inclusive). 
// 0.0 = the light level color is highly visible
// 1.0 = the light level color is not visible
float MIX_INTERPOLATION = 0.0;


// --------------------------- /\ CHANGE THIS /\ --------------------------- //

vec4 rgb_to_vec4(int r, int g, int b) {
    return vec4(r / 255., g / 255., b / 255., 1.);
}