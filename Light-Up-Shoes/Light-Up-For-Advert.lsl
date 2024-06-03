integer moving;
float high = 0.10;
float med = 0.05;
float low = 0.01;
float off = 0.00;
vector white = <1, 1, 1>;  
integer counter;
integer face = 0;

QuickBlink() {
    counter++;
    if (EvenNumber(counter)) {
        llSetPrimitiveParams([
            PRIM_GLOW, face, high
        ]);
        return;
    } else {
        BlinkOff();
    }
}
SlowBlink() {
    counter++;
    if (NotDivisibleByFive(counter)) {
        llSetPrimitiveParams([
            PRIM_GLOW, face, high
        ]);
    } else {
        BlinkOff();
    }
}

BlinkOff() {
    llSetPrimitiveParams([
        PRIM_GLOW, face, off
    ]);
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
    on_rez(integer param) {
        llResetScript();
    }
    state_entry() {
        BlinkOff();
        counter = 0;
        llSetTimerEvent(1);
    }
    timer() {
        QuickBlink();
    }
}