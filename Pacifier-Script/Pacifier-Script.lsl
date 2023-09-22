vector startVector = <0.0,309.0,90.0>;
vector inVector = <0.0,303.0,90.0>;
rotation startRotation;
rotation inRotation;

rotation setUp (vector initial) {
        vector radians = initial*DEG_TO_RAD; // Change to Radians
        return llEuler2Rot(radians); // Change to a Rotation
}

default
{
    state_entry()
    {
        startRotation = setUp(startVector);
        inRotation = setUp(inVector);
        llSetTimerEvent(2);
    }

    timer()
    {
        llSetRot(inRotation);
        llSleep(2);
        llSetRot(startRotation);
    }
}
