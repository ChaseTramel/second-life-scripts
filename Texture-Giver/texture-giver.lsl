default
{
    touch_start(integer touchers)
    {
        key toucher = llDetectedKey(0);
        string folder = "Coloring Pages";
        list inventory = ["Leaves", "Turkey", "Apples"];
        llGiveInventoryList(toucher, folder, inventory);
    }
}