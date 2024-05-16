integer timeGap = 60;
float randomness = 60.0;

randomSound() {
    llSay(0, "*rabbit sounds");
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
