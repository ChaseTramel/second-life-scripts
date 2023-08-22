default
{
    state_entry() {
        llSetTexture("Cover", 1);
    }

    touch_start(integer toucherQuant) {
        string Blank = "8dcd4a48-2d37-4909-9f78-f7a9eb4ef903";
        if (llGetTexture(1) == "Cover"){
            llSetTexture("1", 1);
            llMessageLinked(LINK_ALL_OTHERS, 1, "", "");
        } else if (llGetTexture(1) == "1") {
            llSetTexture("2", 1);
            llMessageLinked(LINK_ALL_OTHERS, 2, "", "");
        } else if (llGetTexture(1) == "2") {
            llSetTexture("3", 1);
            llMessageLinked(LINK_ALL_OTHERS, 3, "", "");
        } else if (llGetTexture(1) == "3") {
            llSetTexture("4", 1);
            llMessageLinked(LINK_ALL_OTHERS, 4, "", "");
        } else if (llGetTexture(1) == "4") {
            llSetTexture(Blank, 1);
            llMessageLinked(LINK_ALL_OTHERS, 5, "", "");
        } else {
            llSetTexture("Cover", 1);
            llMessageLinked(LINK_ALL_OTHERS, 0, "", "");
        }
    }
    link_message(integer source, integer page, string str, key id)
    {
        string Blank = "8dcd4a48-2d37-4909-9f78-f7a9eb4ef903";
        if (page == 1) {
            llSetTexture("1", 1);
        } else if (page == 2) {
            llSetTexture("2", 1);
        } else if (page == 3) {
            llSetTexture("3", 1);
        } else if (page == 4) {
            llSetTexture("4", 1);
        } else if (page == 0) {
            llSetTexture(Blank, 1);
        } else {
            llSetTexture("Cover", 1);
        }
    }
}

