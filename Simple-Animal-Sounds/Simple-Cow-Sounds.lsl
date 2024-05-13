list mooKeys = ["34c35a16-0404-ef4d-86ce-3636ecbd06a5",
"720e3dea-f86c-7870-6be6-a84fdc8035bc",
"720e3dea-f86c-7870-6be6-a84fdc8035bc",
"c8e29e41-2b49-bbea-67cf-c0a2079d5bc5",
"fa204159-cb01-d075-17bf-9b8a4e7b6ad5",
"522b88f6-d3b4-aaa7-e4fd-d6ede30290bb",
"22b83c43-8def-1258-ecd0-161f69e5e658"
];
key bellKey = "4688c6a9-a0f7-c1b8-d9b4-0ad34406f892";

float volume = 0.6;

integer timeGap = 60;
float randomness = 60.0;

randomMoo() {
    llSay(0, "Moo.");
    integer index = (integer)llFrand((float)llGetListLength(mooKeys));
    string mooKey = llList2String(mooKeys, index);
    llPlaySound(mooKey, volume);
}


default
{
    state_entry()
    {
        llSetTimerEvent(timeGap + llFrand(randomness));
    }

    touch_start(integer total_number)
    {
        llSay(0, "*bell sounds*");
        llPlaySound(bellKey, volume);
    }
    timer()
    {
        randomMoo();
    }
}
