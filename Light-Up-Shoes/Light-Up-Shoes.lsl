integer moving;
float high = 0.3;
float med = 0.2;
float low = 0.1;
float off = 0.0;
vector white = <1, 1, 1>;  
integer counter;
integer face = 5;

QuickBlink() {
    counter++;
    if (EvenNumber(counter)) {
        llSetPrimitiveParams([
            PRIM_GLOW, 5, high,
            PRIM_POINT_LIGHT, TRUE, white, high, 3, .75 ]);
        return;
    } else {
        BlinkOff();
    }
}
SlowBlink() {
    counter++;
    if (NotDivisibleByFive(counter)) {
        llSetPrimitiveParams([
            PRIM_GLOW, 5, med,
            PRIM_POINT_LIGHT, TRUE, white, med, 3, .75 ]);
    } else {
        BlinkOff();
    }
}

SteadyLightUp() {
    llSetPrimitiveParams([
        PRIM_GLOW, 5, low,
        PRIM_POINT_LIGHT, TRUE, white, low, 3, .75 ]);
}
BlinkOff() {
    llSetPrimitiveParams([
        PRIM_GLOW, 5, off,
        PRIM_POINT_LIGHT, TRUE, white, off, 3, .75 ]);
}

integer EvenNumber(integer number) {
 if (number % 2 == 0) {
    // llOwnerSay(string(number) + "is even ");
    return 1;
 } else {
    // llOwnerSay(string(number) + "is odd ");
    return 0;
 }
}
integer NotDivisibleByFive(integer number) {
    if (number % 5 == 0) {
        return 0;
    } else {
        return 1;
    }
}
default {
    on_rez( integer param) {
        llResetScript();
    }
    state_entry() {
        BlinkOff();
        counter = 0;
        llSetTimerEvent(.1);
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
        if (llGetAgentInfo(llGetOwner()) &  AGENT_WALKING) {
            // llOwnerSay("blinking quickly!");
            QuickBlink();
        } else if (llGetAgentInfo(llGetOwner()) & AGENT_FLYING) {
            SlowBlink();
            // llOwnerSay("blinking slowly!");
        } else {
            // llOwnerSay("not blinking");
            counter = 0;
            BlinkOff();
        }
    }
}