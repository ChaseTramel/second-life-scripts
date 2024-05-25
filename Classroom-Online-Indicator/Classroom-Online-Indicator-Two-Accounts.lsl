integer poster = 1;
integer ownerOnline;
key firstAccount = "0cd1d5d1-235a-4f0e-bf20-75b7ed4b5942";
key secondAccount = "62fecfda-ed11-41e0-9e9e-5badab4d1de9";
string notecard = "Mr Chase's Contact Info";
key queryID;

default
{
    state_entry()
    {
        llSetTexture("Offline", poster);
        llSetTimerEvent(10); // Check every 10 seconds
    }

    timer()
    {
        queryID = llRequestAgentData(secondAccount, DATA_ONLINE);
    }

    dataserver(key receivedQueryID, string data)
    {
        if (receivedQueryID == queryID)
        {
            if (data == "1")
            {
                ownerOnline = TRUE;
                llSetTexture("Online", poster);
            }
            else
            {
                ownerOnline = FALSE;
                llSetTexture("Offline", poster);
            }
        }
    }

    touch_start(integer toucherQuant) {
        key toucher = llDetectedKey(0);
        llInstantMessage(toucher, "Let me check if Mr. Chase is online.");
        if (ownerOnline == TRUE) {
            llInstantMessage(firstAccount, llGetUsername(toucher) + " needs help in your classroom.");
            llInstantMessage(secondAccount, llGetUsername(toucher) + " needs help in your classroom.");
            llInstantMessage(toucher, "Mr. Chase is online and has been messaged that you need help.");
            return;
        } else {
            llInstantMessage(toucher, "Mr. Chase is offline. Here's a notecard with his contact information. Please feel free to contact him!");
            if (llGetInventoryType(notecard) == INVENTORY_NOTECARD) {
                llInstantMessage(secondAccount, llGetUsername(toucher) + " needs help in your classroom.");
                llGiveInventory(toucher, notecard);
            } else {
                llInstantMessage(toucher, "Sorry, I couldn't find the notecard. Please contact Mr. Chase directly.");
            }
        }
    }
}