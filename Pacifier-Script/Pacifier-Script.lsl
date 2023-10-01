// Created by Kasey Littlepaws for Lily Grace of Lovey
// For sound, add a sound file named "Sound" in the contents of the object


vector rotationAmount = <0.0,006.8,0.0>;
rotation rotationChange;

vector positionChange = <0.003,0.0,0.0>;

integer on = TRUE;

integer sucked = FALSE;

integer volume;

integer slow;
float currentSleep;

float slowTimer = 1;
float fastTimer = 0.5;

float volumeLevel = 0.4;

string dialogMenu = "Choose from the options below:";
list dialogChoices = ["Speed Toggle", "Sound Toggle", "On / Off"];
integer dialogChannel;
integer listener;

rotation covertRotation (vector initial) {
        vector radians = initial*DEG_TO_RAD; // Change to Radians
        return llEuler2Rot(radians); // Change to a Rotation
}

dialogPrompt (key toucher) {
    llListenRemove(listener);  // Remove listener if one exists
    llDialog(toucher, dialogMenu, dialogChoices, dialogChannel);  // Create dialog box
    listener = llListen(dialogChannel, "", toucher, "");  // Create listener
    return;
}

default
{
    state_entry()
    {
        rotationChange = covertRotation(rotationAmount);
        dialogChannel = -1 - (integer)("0x" + llGetSubString( (string) llGetKey(), -7, -1) );  // Create random negative channel for dialog
        llSetTimerEvent(slowTimer);
        slow = TRUE;  // Default to slow speed
        volume = TRUE; // Default to volume on
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
            llSetLinkPrimitiveParams(0,[  // Used to rotate and change position at same time
                PRIM_ROT_LOCAL, llGetLocalRot() * rotationChange,
                PRIM_POS_LOCAL, llGetLocalPos() + positionChange]);
            sucked = TRUE;
        } else {
            if (volume == TRUE) {  // If sound is on, play sound
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
            llListenRemove(listener);
        } else if (message == "Speed Toggle" && slow == TRUE) {
            slow = FALSE;
            llSetTimerEvent(fastTimer);
            llListenRemove(listener);
        } else if (message == "On / Off" && on == TRUE) {
            on = FALSE;
            llSetTimerEvent(0.0);
            llListenRemove(listener);
        } else if (message == "On / Off" && on == FALSE) {
            on = TRUE;
            llSetTimerEvent(slowTimer);
            volume = TRUE;
            llListenRemove(listener);
        }
    }
}
