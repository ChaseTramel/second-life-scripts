integer screen = 0;
integer ownerOnline = FALSE;

default
{
    state_entry()
    {
        llSetTexture("Offline", screen);
        llSetTimerEvent(30);  ///updates every 1 seconds
    }

    timer()
    {
        key owner = llGetOwner();
        if(llRequestAgentData(owner, DATA_ONLINE)){ ///owner online
            ownerOnline = TRUE;
            llSetTexture("Online", screen);
        }
        else { ///owner off parcel
            ownerOnline = FALSE;
            llSetTexture("Offline", screen);
        }
    }
    touch_start(integer toucherQuant) {
        key toucher = llDetectedKey(0);
        llInstantMessage(toucher, "I'm sorry you're having an issue! Let me check if the owner, Kasey Littlepaws is online.");
        if (ownerOnline == TRUE) {
            llInstantMessage(llGetOwner(), llGetUsername(toucher) + " needs help at the store.");
            llInstantMessage(toucher, "The owner is online and has been messaged that you need help.");
            return;
        } else {
            llInstantMessage(toucher, "The owner is offline. Here's a notecard with her contact information. Please contact her describing your issue!");
            llGiveInventory(toucher, "Littlepaw Customer Service Contact Information");
        }
    }
        
}