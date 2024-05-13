list soundKeys = [
    "017d2439-50a6-d436-111a-355ab8d78a08",
    "16fbcc71-dc18-e83b-7ab8-072e18e2057a",
    "16fbcc71-dc18-e83b-7ab8-072e18e2057a",
    "da3132ba-d487-0348-f828-be63db633411"
];

float volume = 0.6;

integer timeGap = 60;
float randomness = 60.0;

randomSound() {
    llSay(0, "Hee Haw.");
    integer index = (integer)llFrand((float)llGetListLength(soundKeys));
    string soundKey = llList2String(soundKeys, index);
    llPlaySound(soundKey, volume);
}


default
{
    state_entry()
    {
        llSetTimerEvent(timeGap + llFrand(randomness));
    }

    touch_start(integer total_number)
    {
        randomSound();
    }
    timer()
    {
        randomSound();
    }
}
