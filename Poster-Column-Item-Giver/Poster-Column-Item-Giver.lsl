// other vars

// soonest poster, front top placement
integer firstPosterFace = 4;  // Yule Ball
key firstPosterImage = "Yule Ball";
string firstPosterMessage = "Let's welcome in the changing of the seasons with live entertainment and drinks amount friends!";
string firstPosterURL = "https://discord.gg/VV8pyHSf?event=1053399105646366872";

// second soonest poster, front bottom placement
integer secondPosterFace  = 6;  // Ugly Christmas Sweater Party
string secondPosterImage = "Ugly Sweater";
string secondPosterMessage = "Join us to celebrate the cheesy and cliche parts of Christmas with this fun social!";
string secondPosterURL = "https://discord.gg/VV8pyHSf?event=1053400731492810782";

// furthest poster, top back placement
integer thirdPosterFace = 3;  // NYE Ball
key thirdPosterImage = "NYE Ball";
string thirdPosterMessage = "Ring in the new year with all your friends and family from Fox Hollow!";
string thirdPosterURL = "https://discord.gg/VV8pyHSf?event=1053422714452459570";

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