// HUD button face numbers
integer paButton = 2;
integer erButton = 3;
integer psButton = 4;
integer ssButton = 7;
integer obButton = 6;
integer dlButton = 5;
integer csButton = 8;
integer sdButton = 9;
integer rdButton = 10;
integer whiteButton = 13;
integer blueButton = 12;
integer greenButton = 11;
integer pinkButton = 14;
integer redButton = 15;
integer yellowButton = 16;

integer talkChannel = -456789;

default
{
    on_rez( integer param) {
        llResetScript();
    }
    touch_start( integer numTouchers )
    {
        if(llDetectedLinkNumber(0) == paButton) {
            llSay(talkChannel, "prehistoricAdventures");
        }
        else if(llDetectedLinkNumber(0) == erButton) {
            llSay(talkChannel, "explorersRoar");
        }
        else if(llDetectedLinkNumber(0) == psButton) {
            llSay(talkChannel, "princessaurus");
        }
        else if(llDetectedLinkNumber(0) == ssButton) {
            llSay(talkChannel, "spiderSwing");
        }
        else if(llDetectedLinkNumber(0) == obButton) {
            llSay(talkChannel, "outbackBlue");
        }
        else if(llDetectedLinkNumber(0) == dlButton) {
            llSay(talkChannel, "dreamyLilac");
        }
        else if(llDetectedLinkNumber(0) == csButton) {
            llSay(talkChannel, "clearSkies");
        }
        else if(llDetectedLinkNumber(0) == sdButton) {
            llSay(talkChannel, "sunnyDays");
        }
        else if(llDetectedLinkNumber(0) == rdButton) {
            llSay(talkChannel, "rainbowDelight");
        }
        else if(llDetectedLinkNumber(0) == whiteButton) {
            llSay(talkChannel, "white");
        }
        else if(llDetectedLinkNumber(0) == blueButton) {
            llSay(talkChannel, "blue");
        }
        else if(llDetectedLinkNumber(0) == greenButton) {
            llSay(talkChannel, "green");
        }
        else if(llDetectedLinkNumber(0) == pinkButton) {
            llSay(talkChannel, "pink");
        }
        else if(llDetectedLinkNumber(0) == redButton) {
            llSay(talkChannel, "red");
        }
        else if(llDetectedLinkNumber(0) == yellowButton) {
            llSay(talkChannel, "yellow");
        }
    }
}