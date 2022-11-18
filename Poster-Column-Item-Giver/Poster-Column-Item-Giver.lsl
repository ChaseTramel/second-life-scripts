integer topLeftPoster;
integer bottomLeftPoster;
integer topRightPoster;
integer bottomRightPoster;

DeliverItems (key toucher, integer touched) {
    if (touched == topLeftPoster) {
        llOwnerSay("Top left poster touched.");
        return;
    } else if (touched == bottomLeftPoster) {
        llOwnerSay("Bottom left poster touched.");
        return;
    } else if (touched == topRightPoster) {
        llOwnerSay("Top right poster touched.");
        return;
    } else if (touched == bottomRightPoster) {
        llOwnerSay("Bottom right poster touched.");
        return;
    }
}
default {
    touch_start(integer toucherQuant) {
        key toucher = llDetectedKey(0);
        integer touchedPoster = llDetectedTouchFace(0);
        llOwnerSay((string)touchedPoster);
        DeliverItems(toucher, touchedPoster);
    }
}