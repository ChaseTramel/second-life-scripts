integer moving;
float high = 0.8;
float med = 0.6;
float low = 0.4;
float off = 0.0;
integer counter;

FlyingSounds() {
    llLoopSound("Flying Bells", high);
}
HoverSounds() {
    llLoopSound("Hover Bells", med);
}
WalkingSounds() {
    llLoopSound("Footsteps", med);
}
NoSounds() {
    llStopSound();
}

default {
    on_rez( integer param) {
        llResetScript();
    }
    state_entry() {
        NoSounds();
        llCollisionSound("Snort", low);
        llSetTimerEvent(.5);
    }
    moving_start() {
        moving = TRUE;
        // llOwnerSay("Moving!");
    }
    moving_end(){
        llStopSound();
        moving = FALSE;
        // llOwnerSay("Not moving!");
    }
    timer() {
        if (llGetAgentInfo(llGetOwner()) & AGENT_FLYING & moving) {
            FlyingSounds();
        } else if (llGetAgentInfo(llGetOwner()) & AGENT_FLYING) {
            HoverSounds();
        } else if (llGetAgentInfo(llGetOwner()) & AGENT_WALKING) {
            WalkingSounds();
        } else {
            NoSounds();
        }
    }
}