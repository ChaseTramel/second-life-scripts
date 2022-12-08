// 200L Gift Card
string small = "Littlepaws Gift Card - 200L";
integer smallPrice = 200;
// 500L Gift Card
string medium = "Littlepaws Gift Card - 500L";
integer mediumPrice = 500;
// 1000L Gift Card
string large = "Littlepaws Gift Card - 1000L";
integer largePrice = 1000;

integer WhichItem(integer paid) {
    if (paid >= 1000) return 1000;
    if (paid >= 500) return 500;
    if (paid >= 200) return 200;
    if (paid < 200) return 0;
    else return 0;
}
GiveItem(key buyer, integer itemPrice) {
    if (itemPrice == smallPrice) {
        llGiveInventory(buyer, small);
    } else if (itemPrice == mediumPrice) {
        llGiveInventory(buyer, medium);
    } else if (itemPrice == largePrice) {
        llGiveInventory(buyer, large);
    }
}
GiveChange(key buyer, integer paid, integer cost) {
    integer amountDue = paid - cost;
    if (amountDue > 0) {
        llGiveMoney(buyer, amountDue);
    }
}

default
{
    state_entry() {
        llRequestPermissions(llGetOwner(), PERMISSION_DEBIT);
        llSetPayPrice(PAY_HIDE, [smallPrice, mediumPrice, largePrice, PAY_HIDE]);
    }
    money( key buyer, integer amountPaid) {
        integer purchasedItem = WhichItem(amountPaid); 
        if (purchasedItem == 0) {
            llInstantMessage(buyer, "That's not enough money, sorry.");
            llGiveMoney(buyer, amountPaid);
        } else {
            GiveItem(buyer, purchasedItem);
            GiveChange(buyer, amountPaid, purchasedItem);
        }
    }
}