list soundKeys = [];

float volume = 0.6;

integer timeGap = 60;
float randomness = 60.0;

randomSound() {
    llSay(0, "*goat sounds*");
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
        llSay(0, "Timer.");
        randomSound();
    }
}
