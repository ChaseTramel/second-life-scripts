key ownerOfVent;
key ownerOfController;
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
    llParticleSystem([
        PSYS_PART_FLAGS,            PSYS_PART_INTERP_COLOR_MASK | PSYS_PART_INTERP_SCALE_MASK | PSYS_PART_EMISSIVE_MASK | PSYS_PART_WIND_MASK,
        PSYS_SRC_PATTERN,           PSYS_SRC_PATTERN_ANGLE,
        PSYS_PART_START_COLOR,      <1.0, 1.0, 1.0>,
        PSYS_PART_END_COLOR,        <1.0, 1.0, 1.0>,
        PSYS_PART_START_ALPHA,      1.00,
        PSYS_PART_END_ALPHA,        0.05,
        PSYS_PART_START_SCALE,      <0.1, 0.1, 0.0>,
        PSYS_PART_END_SCALE,        <10, 10, 0.0>,
        PSYS_PART_MAX_AGE,          0.75,
        PSYS_SRC_ACCEL,             <0.0, 0.0, 0.0>,
        PSYS_SRC_ANGLE_BEGIN,       0.0,
        PSYS_SRC_ANGLE_END,         0.0,
        PSYS_SRC_BURST_PART_COUNT,  1,
        PSYS_SRC_BURST_RADIUS,      0.0,
        PSYS_SRC_OMEGA,             <0.0, 0.0, 0.0>
        ]);
 }

default
{
    state_entry()
    {
        ownerOfVent = llGetOwner();
        listener = llListen(channel, "", NULL_KEY, "");
    }
    listen(integer channel, string name, key id, string message)
    {
        ownerOfController = llGetOwnerKey(id);
        if (message == "heatOn" && ownerOfVent == ownerOfController)
        {
            llStopSound( );
            heaterOn = TRUE;
            coolOn =  FALSE;
            makeHeaterNoise();
        }
        else if (message == "heatOff" && ownerOfVent == ownerOfController)
        {
            heaterOn = FALSE;
            llStopSound( );
        }
        else if (message == "coolOn" && ownerOfVent == ownerOfController)
        {
            llStopSound();
            coolOn = TRUE;
            heaterOn = FALSE;
            makeCoolNoise();
        }
        else if (message == "coolOff" && ownerOfVent == ownerOfController)
        {
            coolOn = FALSE;
            llStopSound( );
        }
        else if (message == "mistOn" && ownerOfVent == ownerOfController)
        {
            mistOn = TRUE;
            makeMistParticles();
        }
        else if (message == "mistOff" && ownerOfVent == ownerOfController)
        {
            mistOn = FALSE;
            llParticleSystem([]);
        }
        else if (message == "stop")
        {
            heaterOn = FALSE;
            coolOn = FALSE;
            mistOn = FALSE;
            llStopSound( );
            llParticleSystem([]);
        }
    }
    changed(integer change)
    {
        if (change & CHANGED_OWNER)
            llResetScript();
    }
}