list soundKeys = [
    "2ed87b04-f6fc-6f0b-3a42-51b7ab771e6b",
    "3d4fbf30-2d28-a6ba-d5a7-3657fc9944a3",
    "cacb6d23-c71d-02d8-a0ee-dda96ceb72bd"
];

float volume = 0.6;

integer timeGap = 60;
float randomness = 60.0;

randomSound() {
    llSay(0, "Quack Quack.");
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
