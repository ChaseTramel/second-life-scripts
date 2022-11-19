// other vars

// soonest poster, front top placement
integer firstPosterFace = 4;  // Charlie Brown Movie
key firstPosterImage = "Charlie Brown";
string firstPosterMessage = "Join us for two showings of A Charlie Brown Thanksgiving on November 19th.";
string firstPosterURL = "https://discord.gg/WeyjhYr7?event=1041132597184561172";

// second soonest poster, front bottom placement
integer secondPosterFace  = 6;  // Friendsgiving
string secondPosterImage = "Friendsgiving";
string secondPosterMessage = "Ready to celebrate with your found family in Fox Hollow on the 23rd?";
string secondPosterURL = "https://discord.gg/5ezDuXZA?event=1043259000013201468";

// furthest poster, top back placement
integer thirdPosterFace = 3;  // Gratitude Gala
key thirdPosterImage = "Gratitude Gala";
string thirdPosterMessage = "A formal event celebrating our gratitude in this amazing community.";
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