vector startVector = <0.0,312.0,90.0>;
vector inVector = <0.0,303.0,90.0>;
rotation startRotation;
rotation inRotation;

vector startPosition = <0.045,0.0,-0.029>;
vector inPosition = <0.043,0.0,-0.029>;

integer slow = FALSE;

float slowTimer = 2;
float slowSleep = 1;
float fastTimer = 1;
float fastSleep = 0.5;

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
        llSetTimerEvent(fastTimer);
    }

    timer()
    {
        llSetRot(inRotation);
        llSetPos(inPosition);
        llSleep(fastSleep);
        llSetRot(startRotation);
        llSetPos(startPosition);
    }
}
