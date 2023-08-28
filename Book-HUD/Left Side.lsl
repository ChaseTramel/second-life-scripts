string blank = "8dcd4a48-2d37-4909-9f78-f7a9eb4ef903";
// page 0 is blank
// page number is cover

integer countTextures() {
    integer pages = llGetInventoryNumber( INVENTORY_TEXTURE );
    return pages;
}

integer currentPage () {
    integer currentPage = (integer)llGetTexture(ALL_SIDES);
    return currentPage;
}

default
{
    state_entry() {
        countTextures();
        llSetTexture(blank, ALL_SIDES);
    }
    touch_start(integer toucherQuant){
        integer numberOfPages = countTextures();
        if (llGetTexture(ALL_SIDES) == blank) {  // if blank
            llSetTexture((string)numberOfPages, ALL_SIDES);  //set to cover
            llMessageLinked(LINK_ALL_OTHERS, currentPage(), "", "");
        } else if (currentPage() - 1 == 0){  // if on the last page
            llSetTexture(blank, ALL_SIDES);  //set to bkank
            llMessageLinked(LINK_ALL_OTHERS, currentPage(), "", "");
        } else {  //otherwise, you're in the middle of the book
            llSetTexture((string)(currentPage() - 1), ALL_SIDES);
            llMessageLinked(LINK_ALL_OTHERS, currentPage(), "", "");
        }
    }
}
