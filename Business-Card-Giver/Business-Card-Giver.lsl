string poster = "Kasey Littlepaws, MyStory Farmer Poster";
string notecard = "Kasey Littlepaws, MyStory Farmer Notecard";

string hoverText = "Touch to learn more.";
vector white = <1.0, 1.0, 1.0>;
float solid = 1.0;


default
{
    state_entry()
    {
        llSetText(hoverText, white, solid);
    }
    touch_start(integer numTouchers)
    {
        key toucher = llDetectedKey(0);
        integer touchedPoster = llDetectedTouchFace(0);
        llGiveInventory(toucher, poster);
        llGiveInventory(toucher, notecard);
    }
}
