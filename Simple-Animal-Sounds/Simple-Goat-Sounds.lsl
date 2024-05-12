list soundKeys = [
    "43851c72-1e5e-caf1-24f5-6d1f73baffa7",
    "82fcece7-14dd-d079-5c67-6eec86d5adf5",
    "02cb944a-48a3-83e0-1046-e49239cf110f",
    "184187f3-89cf-b9db-c1f0-77c104629c01"
];

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
        randomSound();
    }
}
