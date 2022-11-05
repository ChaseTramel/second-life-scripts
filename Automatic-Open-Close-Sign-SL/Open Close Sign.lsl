string open = "682c41fb-bfa4-9e2e-baf4-50ce596a75cf"; /// UUID for Open Sign
string closed = "9747d088-6fce-28da-1d7e-f6078191b64a";  ///UUID for Closed sign
integer back = 3;  
integer front = 2;


default
{
    state_entry()
    {
        llSetTimerEvent(15);  ///updates every 15 seconds
    }

    timer()
    {
        list parcel = llGetAgentList(AGENT_LIST_PARCEL,[]);
        key owner = llGetOwner();
        if(llListFindList(parcel, [owner]) != -1){ ///owner on parcel
            llSetTexture(open, front);
            llSetTexture(closed, back);
        }
        else { ///owner off parcel
            llSetTexture(closed, front);
            llSetTexture(open, back);
        }
    }
}