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
            llSetTexture("1", ALL_SIDES);  //set to cover
            llMessageLinked(LINK_ALL_OTHERS, currentPage(), "", "");
        } else if (currentPage() + 1 == numberOfPages){  // if on the last page
            llMessageLinked(LINK_ALL_OTHERS, currentPage(), "", "");
            llSetTexture(blank, ALL_SIDES);  //set to bkank
        } else {  //otherwise, you're in the middle of the book
            llMessageLinked(LINK_ALL_OTHERS, currentPage(), "", "");
            llSetTexture((string)(currentPage() + 1), ALL_SIDES);
        }
    }
    link_message( integer sender_num, integer num, string str, key id )
    {
        
    }
}
