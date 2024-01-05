use <gen_sprued_keycaps.scad>

keycap_ids = [
    // Left Keyboard Side
    "cs_t_1_l" ,  // 1u outer
    "cs_r3x_1",   // Convex middle key
    "cs_t_1_r",   // 1u inner
    // "cs_t_15_r",  // 1.5u inner (corne style)

    // Right Keyboard Side
    // "cs_t_15_l",  // 1.5u inner (corne style)
    "cs_t_1_l",   // 1u inner
    "cs_r3x_1",   // Convex middle key
    "cs_t_1_r",   // 1u outer

    // Alternative convex middle keys
    "cs_r2x_1",
    "cs_r2x_1"
];

gen_sprued_keycaps(keycap_ids);
