// other vars

// soonest poster, front top placement
integer firstPosterFace = 4;  // Ugly Sweater
key firstPosterImage = "Ugly Sweater";
string firstPosterMessage = "Join us to celebrate the cheesy and cliche parts of Christmas with this fun social for the whole family!";
string firstPosterURL = "https://discord.gg/VV8pyHSf?event=1053400731492810782";

// second soonest poster, front bottom placement
integer secondPosterFace  = 6;  // Trivia Night
string secondPosterImage = "Triva Night";
string secondPosterMessage = "Whether you're looking to connect or compete, prove yourself at trivia!";
string secondPosterURL = "https://discord.gg/VV8pyHSf?event=1055240231042940948";

// furthest poster, top back placement
integer thirdPosterFace = 3;  // Meet & Greet
key thirdPosterImage = "Meet & Greet";
string thirdPosterMessage = "Make new friends by meeting your neighbors in this casual environment!";
string thirdPosterURL = "https://discord.gg/VV8pyHSf?event=1055601543509983242";

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