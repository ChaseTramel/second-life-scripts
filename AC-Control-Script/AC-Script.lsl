
integer dialogChannel;
integer dialogListener;
string openingDialogueMenu = "Select an option.";
string accessDialogueMenu = "Select who can access the object.";
list dialogChoices = ["Access", "Heater On/Off", "AC On/Off", "Mist On/Off", "Stop All"];
list permisions = ["Owner", "Group", "Everyone"];

integer heaterOn = FALSE;
integer mistOn = FALSE;
integer coolOn = FALSE;
string access;

integer messageChannel = -4123456;  // Channel for messages

dialogPrompt (key toucher) {
    llListenRemove(dialogListener);  // Remove dialogListener if one exists
    llDialog(toucher, openingDialogueMenu, dialogChoices, dialogChannel);  // Create dialog box
    dialogListener = llListen(dialogChannel, "", toucher, "");  // Create dialogListener
    return;
}

default
{
    state_entry()
    {
        dialogChannel = -1 - (integer)("0x" + llGetSubString( (string) llGetKey(), -7, -1) );  // Create random negative channel for dialog
        access = "Owner";
    }

    touch(integer numTouchers)
    {
        key toucher = llDetectedKey(0);
        if (access == "Owner" && toucher == llGetOwner()) {
            dialogPrompt(toucher);
        } else if (access == "Group" && llDetectedGroup(0)) {
            dialogPrompt(toucher);
        } else if (access == "Everyone") {
            dialogPrompt(toucher);
        }      
    }

    listen( integer channel, string name, key id, string message )
    {
        if (message == "Access") {
            llDialog(id, accessDialogueMenu, permisions, dialogChannel);
        } else if (message == "Owner") {
            access = "Owner";
            llOwnerSay("Access has been set to Owner only.");
        } else if (message == "Group") {
            access = "Group";
            llOwnerSay("Access has been set to Group only.");
        } else if (message == "Everyone") {
            access = "Everyone";
            llOwnerSay("Access has been set to Everyone.");
        } else if (message == "Heater On/Off") {
            if (heaterOn == FALSE) {
                heaterOn = TRUE;
                llRegionSay(messageChannel, "heatOn");
                llListenRemove(dialogListener);
            } else if (heaterOn == TRUE) {
                heaterOn = FALSE;
                llRegionSay(messageChannel, "heatOff");
                llListenRemove(dialogListener);
            }
        } else if (message == "AC On/Off") { 
            if (coolOn == FALSE) {
                coolOn = TRUE;
                llRegionSay(messageChannel, "coolOn");
                llListenRemove(dialogListener);
            } else if (coolOn == TRUE) {
                coolOn = FALSE;
                llRegionSay(messageChannel, "coolOff");
                llListenRemove(dialogListener);
            } 
        }
        else if (message == "Mist On/Off") {
            if (mistOn == FALSE) {
                mistOn = TRUE;
                llRegionSay(messageChannel, "mistOn");
                llListenRemove(dialogListener);
            } 
            else if (mistOn == TRUE) {
                mistOn = FALSE;
                llRegionSay(messageChannel, "mistOff");
                llListenRemove(dialogListener);
            }
        }
        else if (message == "Stop All") {
            heaterOn = FALSE;
            coolOn = FALSE;
            mistOn = FALSE;
            llRegionSay(messageChannel, "stop");
            llListenRemove(dialogListener);
        }
    }
    changed(integer change)
    {
        if (change & CHANGED_OWNER)
            llResetScript();
    }

}