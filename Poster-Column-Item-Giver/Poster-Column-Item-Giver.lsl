// other vars

// soonest poster, front top placement
integer firstPosterFace = 4;  // Tree Farm
key firstPosterImage = "Tree Farm";
string firstPosterMessage = "Join us for cider, hot cocoa, sled rides, and so much more winter fun on December 10th at noon SLT!";
string firstPosterURL = "https://discord.gg/JsNErxDA?event=1047999168817406033";

// second soonest poster, front bottom placement
integer secondPosterFace  = 6;  // Polar Express
string secondPosterImage = "Polar Express";
string secondPosterMessage = "";
string secondPosterURL = "";

// furthest poster, top back placement
integer thirdPosterFace = 3;  // Christmas Caroling
key thirdPosterImage = "Caroling";
string thirdPosterMessage = "";
string thirdPosterURL = "";

// general promo poster, bottom back placement
integer serverPromoFace = 5;  //General Promo, Winter
key serverPromoImage = "Winter Promo";
string serverPromoMessage = "Join our Discord server for updates on all of our great events!";
string serverPromoURL = "https://discord.gg/Bk6qBbfzB9";


////
SetPosters (key image, integer face) {
    llSetTexture(image, face);
}
DeliverItems (key toucher, integer touched) {
    if (touched == firstPosterFace) {
        llGiveInventory(toucher, firstPosterImage);
        llLoadURL(toucher, firstPosterMessage, firstPosterURL);
        return;
    } else if (touched == secondPosterFace) {
        llGiveInventory(toucher, secondPosterImage);
        llLoadURL(toucher, secondPosterMessage, secondPosterURL);
        return;
    } else if (touched == thirdPosterFace) {
        llGiveInventory(toucher, thirdPosterImage);
        llLoadURL(toucher, serverPromoMessage, serverPromoURL);
        return;
    } else if (touched == serverPromoFace) {
        llGiveInventory(toucher, serverPromoImage);
        llLoadURL(toucher, serverPromoMessage, serverPromoURL);
        return;
    }
}
default {
    state_entry() {
        SetPosters(firstPosterImage, firstPosterFace);
        SetPosters(secondPosterImage, secondPosterFace);
        SetPosters(thirdPosterImage, thirdPosterFace);
        SetPosters(serverPromoImage, serverPromoFace);
    }
    touch_start(integer toucherQuant) {
        key toucher = llDetectedKey(0);
        integer touchedPoster = llDetectedTouchFace(0);
        DeliverItems(toucher, touchedPoster);
    }
}