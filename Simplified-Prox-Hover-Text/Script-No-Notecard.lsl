vector white = <1.0, 1.0, 1.0>;
float solid = 1.0;
float transparent = 0.0;
string hoverText = "Touch any poster for more information.";

default {
    state_entry() {
        float rangeMeters = 9.0;
        float updateRate = 1.0;
        llSensorRepeat("","", AGENT, rangeMeters, PI, updateRate); 
    }
    sensor (integer agentsDetected){
        llSetText(hoverText, white, solid);
    }
    no_sensor () {
        llSetText("", white, transparent);
    }
}