integer heaterOn = FALSE;
integer coolOn = FALSE;
integer mistOn = FALSE;
integer channel = -4123456;
key heatSound = "82fcece7-14dd-d079-5c67-6eec86d5adf5";
key coolSound = "cacb6d23-c71d-02d8-a0ee-dda96ceb72bd";
float volume = .3;
integer listener;

makeHeaterNoise() {
    llLoopSound(heatSound, volume);
}

makeCoolNoise() {
    llLoopSound(coolSound, volume);
}

makeMistParticles() {
    llParticleSystem([  PSYS_PART_MAX_AGE, 10.5,
        PSYS_PART_FLAGS, PSYS_PART_EMISSIVE_MASK | PSYS_PART_INTERP_SCALE_MASK | PSYS_PART_INTERP_COLOR_MASK,
        PSYS_PART_START_COLOR, <1, 1, 1>,
        PSYS_PART_END_COLOR, <1, 1, 1>,
        PSYS_PART_START_SCALE, <0.18,0.18,0.18>,
        PSYS_PART_END_SCALE, <0,0,0>, 
        PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_EXPLODE,
        PSYS_SRC_BURST_RATE, 0.0,
        PSYS_SRC_ACCEL, <0,0,0>,
        PSYS_SRC_BURST_PART_COUNT, 250,
        PSYS_SRC_BURST_SPEED_MIN, 0.05,
        PSYS_SRC_BURST_SPEED_MAX, 0.10,
        PSYS_PART_START_ALPHA, 1.0,
        PSYS_PART_MAX_AGE, 1.0,
        PSYS_PART_START_GLOW, 0.10,
        PSYS_PART_END_GLOW, 0.05
        ]);
}

default
{
    state_entry()
    {
        llListen(channel, "AC Controller", NULL_KEY, "");
    }
    listen(integer channel, string name, key id, string message)
    {
        if (message == "heatOn")
        {
            llStopSound( );
            heaterOn = TRUE;
            coolOn =  FALSE;
            llOwnerSay("The heater kicked on.");
            makeHeaterNoise();
        }
        else if (message == "heatOff")
        {
            heaterOn = FALSE;
            llOwnerSay("The heater stopped.");
            llStopSound( );
        }
        else if (message == "coolOn")
        {
            llStopSound();
            coolOn = TRUE;
            heaterOn = FALSE;
            llOwnerSay("The AC kicked on.");
            makeCoolNoise();
        }
        else if (message == "coolOff")
        {
            coolOn = FALSE;
            llOwnerSay("The AC stopped.");
            llStopSound( );
        }
        else if (message == "mistOn")
        {
            mistOn = TRUE;
            llOwnerSay("The mist started spaying.");
            makeMistParticles();
        }
        else if (message == "mistOff")
        {
            mistOn = FALSE;
            llOwnerSay("The mist stopped spaying.");
            llParticleSystem([]);
        }
        else if (message == "stop")
        {
            heaterOn = FALSE;
            coolOn = FALSE;
            mistOn = FALSE;
            llOwnerSay("Everything stopped.");
            llStopSound( );
            llParticleSystem([]);
        }
    }
}