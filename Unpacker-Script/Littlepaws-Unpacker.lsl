default {
    touch_start(integer touchersDetected) {
        string scriptName = llGetScriptName();
        list inventoryItems;
        integer numberOfItems = llGetInventoryNumber(INVENTORY_ALL);
        integer index = 0;
        for (numberOfItems != 0; index < numberOfItems; ++index) {
            string itemName = llGetInventoryName(INVENTORY_ALL, index);
            if (itemName != scriptName ) {
                if (llGetInventoryPermMask(itemName, MASK_OWNER) & PERM_COPY) {
                    inventoryItems += itemName;
                }
            }
        }
        if (inventoryItems == []) {
            llOwnerSay("No copiable items found, weird.");
        } else {
            llGiveInventoryList(llDetectedKey(0), llGetObjectName(), inventoryItems);
        }
    }
}