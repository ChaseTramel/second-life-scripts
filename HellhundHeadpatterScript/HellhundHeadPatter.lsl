key particle = "20bf0490-490d-0286-5b0d-1e9fb6d6eb64";  //heart particle effects, replace with different UUID for different effect
key sound = "5bf74a5d-26a2-a8f2-059b-926247edb26f";  //dog pant sound, replace with different UUID for different sound
string doggo = "Stella";  //change for different dog name
string bodyOne = "head";  //change for different body part, e.g. belly
//string bodyTwo = "belly"; //change for different body part, e.g. belly  //not implemented
/* Do not change anything below this unless you know what you're doing!
Seriously!*/
key self;
key toucher;
//integer touchedPrim;  //not implemented
integer pets = 0;  //for counter
integer waiter = 0;
integer active = FALSE;
integer spam = FALSE;
integer status = FALSE;
WhisperAlias(string alias, string message) {   //this function is so the object can whisper under an alias
    string orignialName = llGetObjectName();  //save orignal name in a variable
    llSetObjectName(alias);  //set object name to alias
    llWhisper(0,message);  // whisper the message input
    llSetObjectName(orignialName);  //set object name back to original name
} SetStatus() {  //set the hover text
    string text; 
    if (toucher == self) {  //if touching self
        text = "Silly "+(string)doggo+", you can't pet yourself.";
    } else if (spam == TRUE) {  //if spamming
        text = "Let's give "+(string)doggo+" a break.";
    } else if (active == TRUE) {  //if not spamming and active
        text = "Thank you for petting "+(string)doggo+"!";
    } else {  //if not spamming and not active
        text = "Pet "+(string)doggo+"'s "+(string)bodyOne+"!\n";  // default text
        if(pets>0) text += (string)doggo+"'s "+(string)bodyOne+" has been pet "+(string)pets+" times.";  //if any pets, add this counter
    } llSetText(text,<1.0, 1.0, 1.0>,.9);
    status = TRUE;
} FadeStatus() {
    llSetText("",<1.0, 1.0, 1.0>,.9);  //fade the text
    status = FALSE;
} SpamPrevention(){
    // llWhisper(0, "SpamPrevention() running\nActive: "+(string)active+" Spam: "+(string)spam);  //debug message
    spam = TRUE;
    active = TRUE;
    SetStatus();  //set hover text to spam message
    if (toucher != self) WhisperAlias(doggo,"You're petting too quickly, please calm down.");  //if toucher isn't self, whisper anti spam message
    if (toucher == self) WhisperAlias(doggo,"Stop trying to pet yourself, silly "+(string)doggo+".");  //if toucher is self, whisper differnt message
    //llWhisper(0,"Sleeping for five seconds in SpamPrevention."); //debug message
    llSleep(5.0);  //wait five seconds. **Cannot recieve further touch!**
    // llWhisper(0,"Awake in SpamPrevention");  //debug message
    spam = FALSE;
    waiter = 0;
    llSetTimerEvent(3.0);
} SelfTouch(){  // response to owner's attempt to touch patter.
    if (active == TRUE) {  //if considered active, run spam prevention
        SpamPrevention();
    } else {  //if not active, set hover text to self touch dialogue
        active = TRUE;  //set to active for spam prevention
        // llWhisper(0, "SelfTouch() running\nActive: "+(string)active+" Spam: "+(string)spam); //debug message
        SetStatus();  //set hover text
        waiter = 0;
        llSetTimerEvent(3.0);  //run timer() every three seconds
    }
} PlaySound() {
    llTriggerSound(sound,0.3);  // sound at 30% volume
} Response() {  //do the things test
    active = TRUE;  //set to active for spam prevention
    SetStatus();  //set hover text
    ++pets;  //increase pets counter by one
    llRequestPermissions(llDetectedOwner(0), PERMISSION_TRIGGER_ANIMATION);  //load anim. permissions from object owner
    if (llGetPermissions() & PERMISSION_TRIGGER_ANIMATION) {  // if permissions granted, play animations
        llStartAnimation("Tail_Wag_High");
        llStartAnimation("TonguePanting");
        llStartAnimation("Jaw3");
    } PlaySound();  
    llParticleSystem( [  //emit particles. This long block is just particle properties.
        PSYS_PART_FLAGS, 0       
        | PSYS_PART_WIND_MASK 
        | PSYS_PART_EMISSIVE_MASK 
        | PSYS_PART_FOLLOW_SRC_MASK 
        | PSYS_PART_INTERP_COLOR_MASK,
        PSYS_SRC_PATTERN, PSYS_SRC_PATTERN_EXPLODE, 
        PSYS_PART_START_COLOR, <1.0, 1.0, 1.0>,
        PSYS_PART_START_SCALE, <0.3, 0.3, 0.3>,
        PSYS_PART_START_ALPHA, 1.0,  //start completely opaque
        PSYS_PART_END_ALPHA, 0.01,  //end nearly transparent
        PSYS_SRC_BURST_RATE,6.0,
        PSYS_SRC_BURST_PART_COUNT,10,  //spawn ten hearts
        PSYS_PART_END_COLOR, <1.0, 1.0, 1.0>,
        PSYS_PART_MAX_AGE, 5.0,  //last 5 seconds
        PSYS_PART_START_GLOW, 0.01,  //start lightly glowing
        PSYS_PART_END_GLOW, 0.0,  //end with no glow
        PSYS_SRC_TEXTURE, particle
    ] );
    waiter = 0;
    llSetTimerEvent(3.0);  //run timer() every 3 seconds
} StopEverything() {  //remove toucher data, stop particle effects, stop animations.
    toucher = NULL_KEY;  //remove toucher info. Cannot set this to 0 due to type error
    llParticleSystem([]);
    if (pets>0) {  //if more than zero pets, stop animations. when this isn't in there, it give an error bc it tries to stop animations that don't have permissions yet
        llStopAnimation("Tail_Wag_High");
        llStopAnimation("TonguePanting");
        llStopAnimation("Jaw3");
    } active = FALSE;
} default {
    state_entry() {  //when the script starts, grab owner UUID, set the particle system up, and begin timer()
        llParticleSystem([]);
        llSetTimerEvent(3.0);  //this is just to fade the starting hover text
        self = llGetOwner(); //grab the UUID of object owner
    } touch_start(integer toucherQuant) { //upon touch, grab the amount of people touching, usually one
        // llWhisper(0, "touch_start\nActive: "+(string)active+" Spam: "+(string)spam);  //debug message
        if(toucherQuant == 1) { // if only one person is touching, grab their UUID
            toucher = llDetectedKey(0); 
            //llWhisper(0, (string)toucher+" is touching "+(string)self);  //debug message
            if(toucher != self) {  //if the toucher isn't the owner
                string toucherName = llGetDisplayName(llDetectedKey(0));  //grab the name of whoever touched the patter
                if(active == FALSE) {  // if Response() is not going and someone other than the owner touches it, run Response()
                    WhisperAlias(doggo,(string)toucherName+" pets "+(string)doggo+" the dog's "+(string)bodyOne+".");                        
                    Response();  //do sound and particles
                    } else if (active == TRUE) {  //if Response() is running and someone touches it, begin spam prevention
                        SpamPrevention();
                    }
            } else {  //if the owner has touched while Response was not running, run SelfTouch()
                SelfTouch();
            }
        } else {  // if there are multiple touchers, begin spam prevention
            SpamPrevention();
        }
    }  timer() {  //stop everything, reset the hover text, and intiate a counter
        StopEverything();
        SetStatus();
        ++waiter;
        // llWhisper(0,(string)waiter+" in timer.");  //debug message
        if (status == TRUE && waiter > 4) {  // if there's hover text (which there should be) and the counter is over four, fade the hover text and end the timer
            FadeStatus();
            llSetTimerEvent(0.0);  //end the timer
        }
    }   changed(integer change) {  //if the owner of the object changes, reset the script
            WhisperAlias("Headpatter", "Object owner has changed.");  //debug message
            if(change & CHANGED_OWNER) llResetScript();
    }
}

