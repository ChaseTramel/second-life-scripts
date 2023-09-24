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

float volumeLevel = 0.4;

string dialogMenu = "Choose from the options below:";
list dialogChoices = ["Speed Toggle", "Sound Toggle"];
integer dialogChannel;
integer listener;

rotation covertRotation (vector initial) {
        vector radians = initial*DEG_TO_RAD; // Change to Radians
        return llEuler2Rot(radians); // Change to a Rotation
}

dialogPrompt (key toucher) {
    llDialog(toucher, dialogMenu, dialogChoices, dialogChannel);
    llListenRemove(listener);
    listener = llListen(dialogChannel, "", toucher, "");
    return;
}

default
{
    state_entry()
    {
        rotationChange = covertRotation(rotationAmount);
        dialogChannel = -1 - (integer)("0x" + llGetSubString( (string) llGetKey(), -7, -1) );
        llSetTimerEvent(slowTimer);
        currentSleep = slowSleep;
    }

    touch(integer toucher)
    {
        key toucher = llDetectedKey(0);
        if (toucher == llGetOwner()) {
            dialogPrompt(toucher);
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
    listen( integer channel, string name, key id, string message )
    {
        if (message == "Sound Toggle" && volume == FALSE) {
            volume = TRUE;
            llListenRemove(listener);
        } else if (message == "Sound Toggle" && volume == TRUE) {
            volume = FALSE;
            llListenRemove(listener);
        } else if (message == "Speed Toggle" && slow == FALSE) {
            slow = TRUE;
            llSetTimerEvent(slowTimer);
            currentSleep = slowSleep;
            llListenRemove(listener);
        } else if (message == "Speed Toggle" && slow == TRUE) {
            slow = FALSE;
            llSetTimerEvent(fastTimer);
            currentSleep = fastSleep;
            llListenRemove(listener);
        }
    }
}
