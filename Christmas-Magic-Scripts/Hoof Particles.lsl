integer moving;
string magic = "f4895088-5107-1568-d169-553d5a6dbf17";

FlyingMovingMagic() {
    // llOwnerSay("flying magic");
    llParticleSystem([  PSYS_PART_MAX_AGE, 10.5,
        PSYS_PART_FLAGS, PSYS_PART_EMISSIVE_MASK | PSYS_PART_INTERP_SCALE_MASK | PSYS_PART_INTERP_COLOR_MASK,
        PSYS_PART_START_COLOR, <1, 1, 1>,
        PSYS_PART_END_COLOR, <1, 1, 1>,
        PSYS_PART_START_SCALE, <0.18,0.18,0.18>,
        PSYS_PART_END_SCALE, <0,0,0>, 
        PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_EXPLODE,
        PSYS_SRC_BURST_RATE, 0.0,
        PSYS_SRC_ACCEL, <0,0,0>,
        PSYS_SRC_BURST_PART_COUNT, 250,
        PSYS_SRC_BURST_SPEED_MIN, 0.05,
        PSYS_SRC_BURST_SPEED_MAX, 0.10,
        PSYS_PART_START_ALPHA, 1.0,
        PSYS_PART_MAX_AGE, 1.0,
        PSYS_PART_START_GLOW, 0.10,
        PSYS_PART_END_GLOW, 0.05
        ]);
}
HovingMagic() {
    // llOwnerSay("hoving magic");
    llParticleSystem([  PSYS_PART_MAX_AGE, 10.5,
        PSYS_PART_FLAGS, PSYS_PART_EMISSIVE_MASK | PSYS_PART_INTERP_SCALE_MASK | PSYS_PART_INTERP_COLOR_MASK,
        PSYS_PART_START_COLOR, <1, 1, 1>,
        PSYS_PART_END_COLOR, <1, 1, 1>,
        PSYS_PART_START_SCALE, <0.1,0.1,0.1>,
        PSYS_PART_END_SCALE, <0,0,0>, 
        PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_EXPLODE,
        PSYS_SRC_BURST_RATE, 0.5,
        PSYS_SRC_ACCEL, <0,0,0>,
        PSYS_SRC_BURST_PART_COUNT, 5,
        PSYS_SRC_BURST_SPEED_MIN, 0.05,
        PSYS_SRC_BURST_SPEED_MAX, 0.10,
        PSYS_PART_START_ALPHA, 1.0,
        PSYS_PART_MAX_AGE, 2.0,
        PSYS_PART_START_GLOW, 0.10,
        PSYS_PART_END_GLOW, 0.00
        ]);
}
NoMagic() {
    llParticleSystem([]);
}
default {
    on_rez( integer param) {
        llResetScript();
    }
    state_entry() {
        llSetTimerEvent(.5);
    }
    moving_start() {
        moving = TRUE;
        // llOwnerSay("Moving!");
    }
    moving_end(){
        moving = FALSE;
        // llOwnerSay("Not moving!");
    }
    timer() {
        if (llGetAgentInfo(llGetOwner()) & AGENT_FLYING & moving) {
            // llOwnerSay("Christmas magic!");
            FlyingMovingMagic();
        } else if (llGetAgentInfo(llGetOwner()) & AGENT_FLYING) {
            HovingMagic();
        } else {
            // llOwnerSay("No magic.");
            NoMagic();
        }
    }
}