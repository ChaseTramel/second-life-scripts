
integer marketplaceButton = 5;
integer facebookButton = 3;
integer instagramButton = 2;
integer flickrButton = 1;
integer questionButton = 4;

string marketplaceURL = "https://marketplace.secondlife.com/stores/244066";
string facebookURL = "https://www.facebook.com/profile.php?id=100087757505302";
string instagramURL = "https://www.instagram.com/littlepawssecondlife/";
string flickrURL = "https://www.flickr.com/photos/196727381@N04/";
string contactNotecard = "Contact Information - Littlepaws";

GiveResult (integer touchedButton, key toucher) {
    if (touchedButton == marketplaceButton) {
        llLoadURL(toucher, "Marketplace Store", marketplaceURL);
        return;
    } else if (touchedButton == facebookButton) {
        llLoadURL(toucher, "Facebook Page", facebookURL);
        return;
    } else if (touchedButton == instagramButton) {
        llLoadURL(toucher, "Instagram Page", instagramURL);
        return;
    } else if (touchedButton == flickrButton) {
        llLoadURL(toucher, "Flickr Page", flickrURL);
        return;
    } else {
        llGiveInventory(toucher, contactNotecard);
    }
}
default {
    state_entry () { }
    touch_start (integer toucherQuant) {
        key toucher = llDetectedKey(0);
        integer touchedButton = llDetectedLinkNumber(0);
        llOwnerSay(llGetUsername(toucher) + " touched a social media button!");
        GiveResult(touchedButton, toucher);
    }
}