
integer marketplaceButton = 2;
integer facebookButton = 19;
integer instagramButton = 13;
integer flickrButton = 17;
integer emailButton = 1;

string marketplaceURL = "https://marketplace.secondlife.com/stores/244066";
string facebookURL = "https://www.facebook.com/profile.php?id=100087757505302";
string instagramURL = "https://www.instagram.com/littlepawssecondlife/";
string flickrURL = "https://www.flickr.com/photos/196727381@N04/";
string contactNotecard = "Littlepaws Contact Information";

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
        llOwnerSay((string)touchedButton);
        GiveResult(touchedButton, toucher);
    }
}