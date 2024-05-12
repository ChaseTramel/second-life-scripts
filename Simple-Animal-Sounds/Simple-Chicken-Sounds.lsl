list soundKeys = [
    "0a5914a8-f736-4716-1b4a-4ff8fcb531d1",
    "f64b36c7-840c-4d15-ba12-f2911ebffa8e",
    "6e05591c-8c18-1380-3a1a-99b3f3045b29",
    "ffe2448b-eda6-30b8-1455-6f857a68e69f",
    "ded4f7de-3adf-396b-7460-56a1eed70ec7",
    "7a63b86d-f0a7-a0a5-ba3a-2bc4d1be0f38"
];

float volume = 0.6;

integer timeGap = 60;
float randomness = 60.0;

randomSound() {
    llSay(0, "Cluck cluck.");
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
