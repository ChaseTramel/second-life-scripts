///Variables for needs decay
float sleep = 100;
float food = 100;
float hygiene = 100;
float bathroom = 100;
float sleepDecay = 0.104;
/* Calculating sleep decay rate:
    One should be completely exhausted (0% sleep) after 16 hours
    There are 960 minutes in 16 hours
    100 / 960 = 0.104
    In other words, to reach 0% sleep in 16 hours, the need must decay at a rate of 0.104 per minute.
*/
float foodDecay = 0.208;
/* Calculating food decay rate:
    One should eat three times a day, therefore every 8 hours
    There are 480 minutes in 8 hours
    100 / 480 = 0.208
    In other words, to reach 0% food in 8 hours, the need must decay at a rate of 0.208 per minute
*/
float hygieneDecay = 0.069;
/* Calculating food decay rate:
    One should shower once a day, therefore every 24 hours.
    There are 1440 minutes in 24 hours.
    100 / 1440 = 0.069
    In other words, in order to reach 0% hygiene in 24 hours, the need must decay at a rate of 0.069 per minnute
*/
float bathroomDecay = 0.417;
/* Calculating bladder decay rate:
    One should pee 6 times a day, therefore every 4 hours
    There are 240 minutes in four hours
    100 / 240 = 0.417
    In other words, in order to reach 0% bathroom 6 times a day, the need must decay at a rate of 0.417 per minute
*/
//vars for need increase buttons. These values reflect the link number of each prim button on the HUD.
integer sleep1Button = 26; //using numbers instead of '+' to avoid confusion
integer sleep2Button = 25;
integer sleep3Button = 24;
integer food1Button = 21;
integer food2Button = 22;
integer food3Button = 23;
integer hygiene1Button = 20;
integer hygiene2Button = 19;
integer hygiene3Button = 18;
integer bathroom3Button = 17;
//vars for menu buttons. these are the link number of each prim button referenced
integer resetButton = 14;
integer storeButton = 15;
integer bugButton = 16;
integer minButton = 13;
integer maxButton = 6;
integer detachMaxButton = 12;
integer detachMinButton = 7;
//vars for maximized bars. Again, the link number of the prim
integer sleepBarMax = 11;
integer foodBarMax = 10;
integer hygieneBarMax = 9;
integer bathroomBarMax = 8;
vector originalBarSizeMax = <0.015305, 0.345129, 0.046387>;
float originalBarWidthMax = 0.345129;  //FIX THIS, this should be originalBarSizeMax.y, but that isn't working, argh.
//vars for minimized bars
integer sleepBarMin = 5;
integer foodBarMin = 4;
integer hygieneBarMin = 3;
integer bathroomBarMin = 2;
integer originalBarSizeMin;
integer originalBarWidthMin;
//other vars
key owner = NULL_KEY;  //starts with a null value
integer update = 1;  //how many seconds between updates, i.e., how often timer() runs
integer maxxed = TRUE;  //tracking whether minimized or maximized
float displayFloor = 5.0;  //minimum need value to display
vector black = <0.0, 0.0, 0.0>;
float  opaque = 1.0;
vector maxxedRotation = <0.0, 0.0, 0.0>;  //the rotation that the linkset is in to show the maximized view
vector minnedRotation = <0.0, 90.0, 0.0>;  //the rotation that the linkset is in to show the minimized view
integer active;  //for spam prevention
integer listenerID;
//functions
ResetEverything() { //LATER: add a dialogue box confirming you want to reset everything?
    llOwnerSay("Reseting everything.");  //debug, might keep it in
    llSetTimerEvent(0.0);  // pausing the timer
    sleep = 100;
    food = 100;
    hygiene = 100;
    bathroom = 100;
    llSetTimerEvent(update);  //continue the timer as normal
}
float DecayProcess(float need, float decay) {
    integer updateDecay = 60 / update;  //the decay rate above is in minutes, but update is often in seconds, thus we need a decay rate adjustment
    if (need > 0 && need <= 100) {  //if need is in normal range
      //need -= (decay / updateDecay);  //decay it
      need -= decay; //faster normal decay for testing / debugging: this is one minute of decay per update
    } else if (need > 100) {  //if need is over normal range
        need = 100; //set it to 100
    } else { //if need is below normal range
        need = 0; //set it to zero
    } return need;
}
DisplayUpdate(float need, integer barLink) {
    if(need > displayFloor) {  //if need above minimum size, do normal stuff
        //llSetLinkPrimitiveParamsFast(barLink,[ PRIM_TEXT, "", ZERO_VECTOR, 0]);  //remove any hover text
        float bigBarWidth = originalBarWidthMax * (need / 100);  //calculate size to proprotionally represent the need %
        float smallBarWidth = originalBarSizeMin * (need / 100) //calc. size of minimized bars
        llSetLinkPrimitiveParamsFast(barLink,[PRIM_SIZE, <0.015305, barWidth, 0.046387>]); //adjust size of need bar. LATER: adjust bar to always be left aligned 
        //set size of minimized bars
    } else {  //if need is at or below minimum size
        //llSetLinkPrimitiveParamsFast(barLink,[ PRIM_TEXT, "!", black, opaque]);  //set an alert hover text. Replace this with something else later?
        float bigBarWidth = originalBarWidthMax * (displayFloor/100);  //calculate minimum bar size
        float smallBarWidth = originalBarSizeMin * (displayFloor/100);
        llSetLinkPrimitiveParamsFast(barLink,[PRIM_SIZE, <0.015305, barWidth, 0.046387>]);  //set bar width to that
        //set size of minimized bars
    }
    // llOwnerSay("Just updated "+(string)need+" display. The width is now "+(string)barWidth+".");  //debug
} 
SpamPrevention() {
    llOwnerSay("Please wait for the HUD to update before pressing buttons again.");
    llSleep(update * 3);
}
ChangeMinMax() {
    if (maxxed == FALSE) { //if currently minimized but sent here, maximize
        //set linkset rotation to maxxedRotation
        //set maxxed to TRUE
    } else if (maxxed == TRUE) {  //if currently maximized but sent here, minimize
        //set linkset rotation to minnedRotation
        //set maxxed to FALSE
    }
}
SleepButtons(integer button) {  //thought process here is that while you're sleeping, you often wake up to use the bathroom or wake up hungry
    if(button == sleep1Button) { //if sleep+
        sleep += 33;
        bathroom -= 15;
        food -= 15;
    } else if(button == sleep2Button) { //if sleep++
        sleep += 66;
        bathroom -= 20;
        food -= 20;
        hygiene -= 5;  //if you're sleeping long enough, you might get sweaty, etc.
    } else {  //if sleep++
        sleep += 100;
        bathroom -= 25;
        food -= 25;
        hygiene -= 10;
    }
}
FoodButtons(integer button) {  //thought process here is that eating definitely makes you have to use the br, if can often make you sleepy, and might be messy
    if(button == food1Button) { //if food+
        food += 33;
        bathroom -= 15;
        sleep -= 5;
        hygiene -= 5;
    } else if(button == food2Button) { //if food++
        food += 66;
        bathroom -= 20;
        sleep -= 10;
        hygiene -= 10;
    } else {    //if food+++
        food += 100;
        bathroom -= 25;
        sleep -= 15;
        hygiene -= 15;
    }
}
HygieneButtons(integer button) {  //can't think of any other need effects of hygiene
    if(button == hygiene1Button) {  //if hygiene+
        hygiene += 33;
    } else if (button == hygiene2Button) {  //if hygiene++
        hygiene += 66;
    } else {  //if hygiene+++
        hygiene += 100;        
    }
}
BathroomButtons(integer button) {  //obviously using the bathroom makes your hands and possibly body dirty
    bathroom += 100;  //only one button for bathroom
    hygiene -= 33;
}
MenuButtons(integer button, key toucher) {
    integer dialogResponse;
    if(button == resetButton) {  
        dialogResponse = ConfirmDialog(button, toucher);
        ResetEverything();
    } else if(button == storeButton) {
        llLoadURL(toucher, "Here's the Littlepaws marketplace store!", "https://marketplace.secondlife.com/stores/244066");
    } else if(button == bugButton) {
        llLoadURL(toucher, "Please report bugs here:", "https://github.com/ChaseLittlepaws/SuperSimpleNeedsHUD/issues");
    } else if (button == detachMaxButton || button == detachMinButton) {  //later, add dialogue box confirming detach
        dialogResponse = ConfirmDialog(button, toucher);
        llOwnerSay("Fix DetachHUD()");  //this isn't working right now. run_time_permissions throws a syntax error
    } else if(button == minButton || button = maxButton) {
        ChangeMinMax();
    }
}
/*DetachHUD() {
    llRequestPermissions(owner, PERMISSION_ATTACH);  //request attachement permissions
    run_time_permissions(integer perm) {
        if(perm && PERMISSION_ATTACH) {
            llOwnerSay("Detaching SSNeeds HUD");
            llDetachFromAvatar();
        } else {
            llOwnerSay("I don't have permissions to do that.");
        }
    }
}*/
integer ConfirmDialog(integer button, key toucher){
    integer dialogChannel = -1 - (integer)("0x" + llGetSubString( (string) llGetKey(), -7, -1) ); //generates a negative, semi-random, non-zero channel for dialog menus to speak in
    list dialogOptions = ["Yes", "No"];
    if(button == resetButton) {
        llDialog(toucher, "Do you really want to reset all of the values?", dialogOptions, dialogChannel);
        listenId = llListen(dialogChannel, "", toucher, "");
    } else if(button == detachMaxButton || button == detachMinButton) {
        llDialog(toucher, "Do you really want to detach the SSNeeds HUD?", dialogOptions, dialogChannel);
        listenId = llListen(dialogChannel, "", toucher, "");
    } 
    listen(integer channel, string name, key id, string message) {
        if(message == "Yes") {
            return TRUE;
        } else {
            return FALSE;
        }
    }
}
default {
    state_entry() {
        ResetEverything(); //this is only here for debug purposes. Possibly remove later
        owner = llGetOwner();  //to compare to toucher
    }
    timer () {
        sleep = DecayProcess(sleep, sleepDecay);
        food = DecayProcess(food, foodDecay);
        hygiene = DecayProcess(hygiene, hygieneDecay);
        bathroom = DecayProcess(bathroom, bathroomDecay);
        DisplayUpdate(sleep, sleepBarMax);
        DisplayUpdate(food, foodBarMax);
        DisplayUpdate(hygiene, hygieneBarMax);
        DisplayUpdate(bathroom, bathroomBarMax);  //display updates after decay process so HUD will never display outside of normal ranges
        llListenRemove(listenerID);
        active = FALSE;
        // llOwnerSay("Sleep: "+(string)sleep+"\nFood: "+(string)food+"\nHygiene: "+(string)hygiene+"\nBathroom: "+(string)bathroom);  //debug message
    }
    touch_start(integer toucherQuant) {
        if(active == TRUE) SpamPrevention();
        active = TRUE;
        llListenRemove(listenerID);
        key toucher = llDetectedKey(0);  //grab the uuid of toucher
        if(toucher != owner) {  //if someone other than the owner touches the hud, that's weird.
            llOwnerSay("That's weird, someone else touched your Super Simple Needs HUD?");  //debug message
        } else {  //if toucher is owner, good
            integer touchedButton = llDetectedLinkNumber(0);  //grab the link number of the touched prim
            //llOwnerSay("That button is: "+(string)llGetLinkPrimitiveParams(touchedButton, [PRIM_SIZE]));  //debug
            llOwnerSay("You touched "+(string)touchedButton+". ");  //debug message
            if(touchedButton == sleep1Button || touchedButton == sleep2Button || touchedButton == sleep3Button) {  //if touched button is one of the sleep buttons
                SleepButtons(touchedButton);
            } else if(touchedButton == food1Button || touchedButton == food2Button || touchedButton == food3Button) { //if touched button is one of the food buttons
                FoodButtons(touchedButton);
            } else if(touchedButton == hygiene1Button || touchedButton == hygiene2Button || touchedButton == hygiene3Button) {  //if touched button is one of the hygiene buttons
                HygieneButtons(touchedButton);
            } else if(touchedButton == bathroom3Button) {  //if touched button is the bathroom button
                BathroomButtons(touchedButton);
            } else { //otherwise, probably a menu button
                MenuButtons(touchedButton, toucher);
            }
        //llOwnerSay("\nSleep: "+(string)sleep+"\nFood: "+(string)food+"\nHygiene: "+(string)hygiene+"\nBathroom: "+(string)bathroom);  //debug message
        }
    }
}
