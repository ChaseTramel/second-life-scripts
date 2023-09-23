vector rotationAmount = <0.0,009.0,0.0>;
rotation rotationChange;

vector positionChange = <0.004,0.0,0.0>;

integer slow = FALSE;
integer sucked =FALSE;

float slowTimer = 1;
float slowSleep = 0.5;

float fastTimer = 0.5;
float fastSleep = 0.25;

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
            llSetTimerEvent(fastTimer);
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
        }
        else {
            llSetLinkPrimitiveParams(0,[
                PRIM_ROT_LOCAL, llGetLocalRot() / rotationChange,
                PRIM_POS_LOCAL, llGetLocalPos() - positionChange]);
            sucked = FALSE;
        }
        
    }
}
