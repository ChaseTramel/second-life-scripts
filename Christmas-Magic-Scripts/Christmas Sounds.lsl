key owner;
integer moving;
float high = 0.8;
float med = 0.6;
float low = 0.4;
float off = 0.0;
integer counter;

FlyingSounds() {
    counter++;
    if (EvenNumber(counter)) {
        play sound 1
        return;
    } else {
        play sound 2
        return;
    }
}
HoverSounds() {
    counter++;
    if (DivisibleByFive == 1) {
        play 2;
        return;
    } else {
        return;
    }
}
WalkingSounds() {
    loop walking
}
NoSounds() {
    stop all sounds
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
integer DivisibleByFive(integer number) {
    if (number % 5 == 0) {
        return 1;
    } else {
        return 0;
    }
}
default {
    on_rez( integer param) {
        llResetScript();
    }
    state_entry() {
        NoSounds();
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
            FlyingSounds();
        } else if (llGetAgentInfo(llGetOwner()) & AGENT_FLYING) {
            HoverSounds();
        } else if (moving) {
            counter = 0;
            WalkingSounds();
        } else {
            NoSounds();
        }
    }
}