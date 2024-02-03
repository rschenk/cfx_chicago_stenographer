use <Choc_Chicago_Steno.scad>
use <Choc_Chicago_Steno_Convex.scad>
use <Choc_Chicago_Steno_Thumb.scad>

module gen_sprued_keycaps(keycap_ids, spacing=18, spru_radius=1.5, vertical=false) {
    translate([0, -spacing * 1, 0])
        cs_spru(keycap_ids=keycap_ids, spacing=spacing, vertical=vertical);
}

available_keycaps = [
    // keycap_id, variation, keyID, width, rot, stemRot, mirror, homing dots, homing bar

    // Top and bottom rows (R2 / R4)
    // R2 and R4 are the exact same keycap. You just rotate them by
    // 180 degrees.
    //
    // But for easier visualization I added pre-rotated models.

    ["cs_r2_1",             1, 0, 1.00, 180,  0, false, false, false],
    ["cs_r4_1",             1, 0, 1.00,   0,  0, false, false, false],

    ["cs_r2_125",           1, 5, 1.25,   0,  0, false, false, false],
    ["cs_r2_15",            1, 7, 1.50,   0,  0, false, false, false],
    ["cs_r2_175",           1, 9, 1.75,   0,  0, false, false, false],
    ["cs_r2_2",             1, 7, 2.00,   0,  0, false, false, false],
    ["cs_r2_225",           1, 7, 2.25,   0,  0, false, false, false],

    // Middle Rows (R3)
    ["cs_r3_1",             1,  1, 1.00,   0,  0, false, false, false],
    ["cs_r3_1_dot",         1,  1, 1.00,   0,  0, false, true,  false],
    ["cs_r3_1_bar",         1,  1, 1.00,   0,  0, false, false, true],
    ["cs_r3_125",           1,  6, 1.25,   0,  0, false, false, false],
    ["cs_r3_125_dot",       1,  6, 1.25,   0,  0, false, true,  false],
    ["cs_r3_125_bar",       1,  6, 1.25,   0,  0, false, false, true],
    ["cs_r3_15",            1,  8, 1.50,   0,  0, false, false, false],
    ["cs_r3_175",           1, 10, 1.75,   0,  0, false, false, false],
    ["cs_r3_2",             1, 12, 2.00,   0,  0, false, false, false],
    ["cs_r3_225",           1, 14, 2.25,   0,  0, false, false, false],

    // Lateral Columns
    ["cs_r2_lateral_l",     3,  0, 1.00, 180,  0, true,  false, false],
    ["cs_r2_lateral_r",     3,  0, 1.00, 180,  0, false, false, false],
    ["cs_r4_lateral_l",     3,  0, 1.00,   0,  0, false, false, false],
    ["cs_r4_lateral_r",     3,  0, 1.00,   0,  0, true, false, false],

    ["cs_r3_lateral_l",     3,  1, 1.00,   0,  0, false, false, false],
    ["cs_r3_lateral_l_dot", 3,  1, 1.00,   0,  0, false, true,  false],
    ["cs_r3_lateral_l_bar", 3,  1, 1.00,   0,  0, false, false, true],

    ["cs_r3_lateral_r",     3,  1, 1.00,   0,  0, true,  false, false],
    ["cs_r3_lateral_r_dot", 3,  1, 1.00,   0,  0, true,  true,  false],
    ["cs_r3_lateral_r_bar", 3,  1, 1.00,   0,  0, true,  false, true],

    // Convex
    ["cs_r2x_1",            2,  0, 1.00, 180,  0, false, false, false],
    ["cs_r4x_1",            2,  0, 1.00,   0,  0, false, false, false],
    ["cs_r3x_1",            2,  1, 1.00,   0,  0, false, false, false],

    // Thumbs
    ["cs_t_1_l",            3,  2, 1.00,   0,  0, false, false, false],
    ["cs_t_1_r",            3,  2, 1.00,   0,  0, true,  false, false],
    ["cs_t_15_l",           3,  3, 1.00,   0, 90, false, false, false],
    ["cs_t_15_r",           3,  3, 1.00,   0, 90, true,  false, false],
    ["cs_t_2_l",            3,  4, 1.00,   0, 90, false, false, false],
    ["cs_t_2_r",            3,  4, 1.00,   0, 90, true,  false, false],

    // Stem rotated thumbs for boards where the inner thumb switch is not
    // rotated
    ["cs_t_stem_rot_15_l",  3,  3, 1.00,   0,  0, false, false, false],
    ["cs_t_stem_rot_15_r",  3,  3, 1.00,   0,  0, true,  false, false],
    ["cs_t_stem_rot_2_l",   3,  4, 1.00,   0,  0, false, false, false],
    ["cs_t_stem_rot_2_r",   3,  4, 1.00,   0,  0, true,  false, false],
];

function get_keycap(keycap_id) = [
  for (keycap = available_keycaps)
  if (keycap[0] == keycap_id)
  keycap
];

module cs_spru(keycap_ids, spacing=18, radius=1.5, vertical=false) {

    echo (str("Building sprued keycaps with keycap ids: ", keycap_ids));

    row_rotation = vertical == true ? -90 : 0;

    rotate([0, 0, row_rotation])
        union() {
            for (i = [0 : len(keycap_ids) - 1]){

                keycap_id = keycap_ids[i];

                key_rotation = vertical == true ? 90 : 0;

                translate([i * spacing, 0, 0])
                    rotate([0, 0, key_rotation])
                        cs_keycap(keycap_id);
            }

            if(len(keycap_ids) > 1) {
                for (i = [0 : len(keycap_ids) - 2]){
                    translate([(i) * spacing + spacing / 2 - 1.5, 0, 0])
                    translate([0, 0, -0.9 * radius])
                    rotate([0, 90, 0])
                    cylinder(h = 3, r = radius, $fn=12);
                }
            }
        }
}

module cs_keycap(keycap_id) {

    keycap = get_keycap(keycap_id)[0];
    assert(keycap != undef, str("Keycap with id ", keycap_id, " not found"));

    echo (str("Building: ", keycap_id));

    variation = keycap[1];
    keycap_key_id = keycap[2];
    keycap_width = keycap[3];
    keycap_rot = keycap[4];
    keycap_stem_rot = keycap[5];
    keycap_mirrored = keycap[6];
    keycap_dot = keycap[7];
    keycap_bar = keycap[8];

    // If mirror and rotation are used at the same time,
    // we need to rotate round a different axis
    //
    // If the keycap is longer than 1.5u we rotate it so that it
    // can still be placed at the same key distance on the sprue
    rotation = keycap_width > 1 ? keycap_rot + 90 : keycap_rot;
    mirroring =  keycap_mirrored == true ? [1, 0, 0] : [0, 0, 0];

    rotate([0, 0, rotation])
        mirror(mirroring)
            cs_default(
                keycap_key_id, variation, keycap_stem_rot,
                dot=keycap_dot, bar=keycap_bar
            );
}

module cs_default(keyID, variation=1, stem_rot=0, dot=false, bar=false) {

    if(variation == 1) {
        keycap_cs(
            keyID  = keyID, //change profile refer to KeyParameters Struct
            Stem   = true, //turns on shell and stems
            StemRot = stem_rot,//change stem orientation by deg
            Dish = true,
            visualizeDish=false,
            crossSection=false,
            homeDot = dot,
            homeBar = bar
        );
    } else if(variation == 2) {
        keycap_cs_convex(
            keyID  = keyID, //change profile refer to KeyParameters Struct
            Stem   = true, //turns on shell and stems
            StemRot = stem_rot,//change stem orientation by deg
            Dish = true,
            visualizeDish=false,
            homeDot = dot
        );
    } else if(variation == 3) {
        keycap_cs_thumb(
            keyID  = keyID, //change profile refer to KeyParameters Struct
            Stem   = true, //turns on shell and stems
            StemRot = stem_rot,//change stem orientation by deg
            Dish = true,
            visualizeDish=false,
            crossSection=false,
            homeDot = dot,
            homeBar = bar
        );
    }
}


