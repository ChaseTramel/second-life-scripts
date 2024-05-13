list soundKeys = [
    "fa01dde8-216d-5857-fbfc-dcb1672f983a",
    "a6762e32-92b2-b2af-25c3-12faea19aca6",
    "dc0d17aa-8012-d1d7-1dc3-a9f2414451e9",
    "318448da-2613-b96f-8d30-383872a19fd1",
    "1114dad7-208b-d4f7-0e79-bd7c7e8f8f5f",
    "bf2d2a9d-362a-361d-e780-0f60b264f051",
    "658160c9-4d5b-860c-3cf8-f95ee38fa247",
    "8d27f936-0d41-bb88-eeca-47d6397f760c"
    ];

float volume = 0.6;

integer timeGap = 60;
float randomness = 60.0;

randomSound() {
    llSay(0, "Oink Oink");
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
