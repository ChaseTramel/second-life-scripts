integer poster = 1;
integer ownerOnline;
key account = "fb9d02b2-44e7-408b-9f9d-f43d61a899b0";
string notecard = "Godmamma's MyStory Market Contact Information";
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
        queryID = llRequestAgentData(account, DATA_ONLINE);
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
        llInstantMessage(toucher, "Let me check if the owner Hunsty is online.");
        if (ownerOnline == TRUE) {
            llInstantMessage(account, llGetUsername(toucher) + " needs help at the stire.");
            llInstantMessage(toucher, "Hunsty is online and has been messaged that you need help.");
            return;
        } else {
            llInstantMessage(toucher, "Huntsy is offline. Here's a notecard with her contact information. Please feel free to contact her!");
            if (llGetInventoryType(notecard) == INVENTORY_NOTECARD) {
                llGiveInventory(toucher, notecard);
            } else {
                llInstantMessage(toucher, "Sorry, I couldn't find the notecard. Please contact Hunsty directly.");
            }
        }
    }
}