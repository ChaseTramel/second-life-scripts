integer moving;
float high = 0.10;
float med = 0.05;
float low = 0.01;
float off = 0.00;
vector color = <1.0, 1.0, 1.0>;  
integer counter;
integer face = 6;
integer listener;
integer talkChannel = -456789;

QuickBlink() {
    counter++;
    if (EvenNumber(counter)) {
        llSetPrimitiveParams([
            PRIM_GLOW, face, high,
            PRIM_POINT_LIGHT, TRUE, color, high, 3, .75 ]);
        return;
    } else {
        SteadyLightUp();
    }
}
SlowBlink() {
    counter++;
    if (NotDivisibleByFive(counter)) {
        llSetPrimitiveParams([
            PRIM_GLOW, face, med,
            PRIM_POINT_LIGHT, TRUE, color, med, 3, .75 ]);
    } else {
        BlinkOff();
    }
}

SteadyLightUp() {
    llSetPrimitiveParams([
        PRIM_GLOW, face, low,
        PRIM_POINT_LIGHT, TRUE, color, low, 3, .75 ]);
}
BlinkOff() {
    llSetPrimitiveParams([
        PRIM_GLOW, face, off,
        PRIM_POINT_LIGHT, TRUE, color, off, 3, .75 ]);
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
        listener = llListen(talkChannel, "", "", "");
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
    listen( integer channel, string name, key id, string message )
    {
        llSetTimerEvent(.1);
        if (message == "white") {
            color = <1.0, 1.0, 1.0>;
        } else if (message == "blue") {
            color = <0.0, 0.0, 1.0>;
        } else if (message == "green") {
            color = <0.0, 1.0, 0.0>;
        } else if (message == "red") {
            color = <1.0, 0.0, 0.0>;
        } else if (message == "yellow") {
            color = <1.0, 1.0, 0.0>;
        } else if (message == "pink") {
            color = <1.0, 0.0, 1.0>;
        } else if (message == "off") {
            llSetTimerEvent(0.0);
            BlinkOff();
        }
    }
}