key owner;
integer moving;
float high = 0.8;
float med = 0.6;
float low = 0.4;
float off = 0.0;
integer counter;

QuickNoseBlink() {
    counter++;
    if (EvenNumber(counter)) {
        llSetPrimitiveParams([
            PRIM_GLOW, ALL_SIDES, high,
            PRIM_POINT_LIGHT, TRUE, red, high, 3, .75 ]);
        return;
    } else {
        SteadyNose();
    }
}
SlowNoseBlink() {
    counter++;
    if (NotDivisibleByFive(counter)) {
        llSetPrimitiveParams([
            PRIM_GLOW, ALL_SIDES, med,
            PRIM_POINT_LIGHT, TRUE, red, med, 3, .75 ]);
    } else {
        SteadyNose();
    }
}

SteadyNose() {
    llSetPrimitiveParams([
        PRIM_GLOW, ALL_SIDES, low,
        PRIM_POINT_LIGHT, TRUE, red, low, 3, .75 ]);
}
OffNose() {
    llSetPrimitiveParams([
        PRIM_GLOW, ALL_SIDES, off,
        PRIM_POINT_LIGHT, TRUE, red, off, 3, .75 ]);
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
        SteadyNose();
        counter = 0;
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
            QuickNoseBlink();
        } else if (llGetAgentInfo(llGetOwner()) & AGENT_FLYING) {
            SlowNoseBlink();
        } else {
            // llOwnerSay("No magic.");
            counter = 0;
            SteadyNose();
        }
    }
}