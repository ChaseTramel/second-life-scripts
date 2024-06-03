string animation;
integer link = 2;
float transPee = 0.25;
integer counter;

default
{
    state_entry()
    {
        // set sit target, otherwise this will not work 
        llSitTarget(<-0.05, 0.0, -0.008>, ZERO_ROTATION);
    }
 
    changed(integer change)
    {
        if (change & CHANGED_LINK)
        {
            key av = llAvatarOnSitTarget();
            if (av) //evaluated as true if not NULL_KEY or invalid
                llRequestPermissions(av, PERMISSION_TRIGGER_ANIMATION);
            else // avatar is standing up
            {
                if (animation)
                    llStopAnimation(animation);
                    llSetTimerEvent(1);
                    counter = 0;
            }
        }
    }

    timer()
    {
        counter++;
        if (counter > 30) // 30 seconds
        {
            llSetTimerEvent(0);
            llSetLinkAlpha(link, 0.0, ALL_SIDES);
            llResetScript(); // release the avatar animation permissions
        }
    }
    
    run_time_permissions(integer perm)
    {
        if (perm & PERMISSION_TRIGGER_ANIMATION)
        {
            animation = llGetInventoryName(INVENTORY_ANIMATION,0); // get the first animation from inventory
            if (animation)
            {
                llStopAnimation("sit"); 
                llStartAnimation(animation);
                llSetLinkAlpha(link, transPee, ALL_SIDES);
            }
        }
    }
}