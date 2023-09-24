vector rotationAmount = <0.0,009.0,0.0>;
rotation rotationChange;

vector positionChange = <0.004,0.0,0.0>;


integer sucked = FALSE;

integer volume = TRUE;

integer slow = FALSE;
float currentSleep;

float slowTimer = 1;
float slowSleep = 0.5;

float fastTimer = 0.5;
float fastSleep = 0.25;

float volumeLevel = 0.3;

rotation covertRotation (vector initial) {
        vector radians = initial*DEG_TO_RAD; // Change to Radians
        return llEuler2Rot(radians); // Change to a Rotation
}

default
{
    state_entry()
    {
        rotationChange = covertRotation(rotationAmount);
    }

    touch(integer toucher)
    {
        if (llDetectedKey(0) == llGetOwner()) {
            if (slow == TRUE) {
                llSetTimerEvent(slowTimer);
                currentSleep = slowSleep;
            } else {
                llSetTimerEvent(fastTimer);
                currentSleep = fastSleep;
            }
        }
        
    }

    timer()
    {
        if (sucked == FALSE) {
            llSetLinkPrimitiveParams(0,[
                PRIM_ROT_LOCAL, llGetLocalRot() * rotationChange,
                PRIM_POS_LOCAL, llGetLocalPos() + positionChange]);
            llSleep(fastSleep);
            sucked = TRUE;
        } else {
            if (volume == TRUE) {
                llPlaySound("Sound", volumeLevel);
            }
            llSetLinkPrimitiveParams(0,[
                PRIM_ROT_LOCAL, llGetLocalRot() / rotationChange,
                PRIM_POS_LOCAL, llGetLocalPos() - positionChange]);
            sucked = FALSE;
        }
        
    }
}
