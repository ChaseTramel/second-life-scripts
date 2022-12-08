// other vars

// soonest poster, front top placement
integer firstPosterFace = 4;  // Cookie Decorating
key firstPosterImage = "Cookie Decorating";
string firstPosterMessage = "Get ready for a sugary good time on Saturday at 4pm SLT!";
string firstPosterURL = "https://discord.gg/Uts3fJf8?event=1046545276925653012";

// second soonest poster, front bottom placement
integer secondPosterFace  = 6;  // Fantasy in Lights
string secondPosterImage = "Fantasy in Lights";
string secondPosterMessage = "Celebrate the season with this walk through community light display opening December 7th at 6pm SLT!";
string secondPosterURL = "https://discord.gg/B3yqcRHQ?event=1046549730357944380";

// furthest poster, top back placement
integer thirdPosterFace = 3;  // Tree Farm
key thirdPosterImage = "Tree Farm";
string thirdPosterMessage = "Join us for sled rides, hot cocoa, and more winter fun on December 10th at noon SLT!";
string thirdPosterURL = "https://discord.gg/TetYHBHd?event=1047999168817406033";

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