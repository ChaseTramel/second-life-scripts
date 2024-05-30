// shoe face numbers: 
integer sides = 1;
integer front = 7;
integer back = 0;
integer laces = 3;
integer bottom = 6;
integer middle = 5;
integer insides = 4;


// pattern index
integer prehistoricAdventures = 0;
integer explorersRoar = 1;
integer princessaurus = 2;
integer spiderSwing = 3;
integer outbackBlue = 4;
integer dreamyLilac = 5;
integer clearSkies = 6;
integer sunnyDays = 7;
integer rainbowDelight = 8;

// pattern UUIDs
key paSides = "ea39e12e-7d94-4bc2-c373-77a0510228eb";
key paBottom = "16257f28-8d98-e38e-21e4-73b36f2e66e2";
key erSides = "cbc66826-dd4e-d48f-8e1c-06699be53770";
key erBottom = "02082f0a-0ebf-45f1-798b-f8cdb10c589c";
key psSides = "ea4cc255-5d37-93a3-31e6-368462880a05";
key psBottom = "a647fb31-2ae1-f299-0881-2809a28e14dc";
key ssSides = "a94711a9-8ee9-68b3-c029-2d32a6c48a3a";
key ssBottom = "85d908d6-e87a-f35f-8a55-417d0a9aed8e";
key obSides ="7a74b513-114f-195c-b364-8789598f2d54";
key obBottom = "91defdc3-697e-8cc2-d3b0-e3dd1144519d";
key dlSides = "05294cc8-c7bb-6956-c17a-bb74c8808a5c";
key dlBottom = "1fa9469d-120f-4ab2-76a6-21ce440713cd";
key csSides = "2c9a9922-0ed7-181e-33ef-8902dadf34d8";
key csBottom = "6df54cf2-3616-fa22-80e6-ea8f1e37d367";
key sdSides = "bd7f1354-5c84-803f-eca7-352211bb0615";
key sdBottom = "073aa45c-5fe0-7c53-a765-f6e3cea76ca7";
key rdSides = "9aa8355b-fa63-7907-3c4b-d51bf09f38ba";
key rdBottom = "b69d64cc-4661-05af-0323-c6d7261054bc";

integer listener;
integer talkChannel = -456789;

default
{
    on_rez( integer param) {
        llResetScript();
    }
    state_entry()
    {
        listener = llListen(talkChannel, "Light Up Toddler Shoes HUD", "", "");
    }
    listen(integer channel, string name, key id, string message)
    {
        if (message == "prehistoricAdventures")
        {
            llSetTexture(paSides, sides);
            llSetTexture(paBottom, bottom);
            llSetColor(<0.56, 0.93, 0.56>, 7); //front
            llSetColor(<0.56, 0.93, 0.56>, 0); //back
            llSetColor(<1.0, 0.65, 0.0>, 3); //laces
            llSetColor(<0.18, 0.55, 0.91>, 4); //insides
            llSetColor(<1.0, 1.0, 1.0>, 5); //middle
        }
        else if (message == "explorersRoar")
        {
            llSetTexture(erSides, sides);
            llSetTexture(erBottom, bottom);
            llSetColor(<0.33, 0.42, 0.18>, 7); //front
            llSetColor(<0.33, 0.42, 0.18>, 0); //back
            llSetColor(<0.33, 0.42, 0.18>, 3); //laces
            llSetColor(<0.42, 0.28, 0.23>, 4); //insides
            llSetColor(<0.42, 0.28, 0.23>, 5); //middle
        }
        else if (message == "princessaurus")
        {
            llSetTexture(psSides, sides);
            llSetTexture(psBottom, bottom);
            llSetColor(<0.85, 0.75, 0.85>, 7); //front
            llSetColor(<0.85, 0.75, 0.85>, 0); //back
            llSetColor(<1.0, 0.41, 0.71>, 3); //laces
            llSetColor(<1.0, 0.71, 0.76>, 4); //insides
            llSetColor(<1.0, 1.0, 1.0>, 5); //middle
        }
        else if (message == "spiderSwing")
        {
            llSetTexture(ssSides, sides);
            llSetTexture(ssBottom, bottom);
            llSetColor(<1.0, 0.0, 0.0>, 7); //front
            llSetColor(<1.0, 0.0, 0.0>, 0); //back
            llSetColor(<0.0, 0.0, 0.0>, 3); //laces
            llSetColor(<0.0, 0.0, 0.0>, 4); //insides
            llSetColor(<1.0, 0.0, 0.0>, 5); //middle
        }
        else if (message == "outbackBlue")
        {
            llSetTexture(obSides, sides);
            llSetTexture(obBottom, bottom);
            llSetColor(<0.24, 0.24, 0.39>, 7); //front
            llSetColor(<0.24, 0.24, 0.39>, 0); //back
            llSetColor(<0.24, 0.24, 0.39>, 3); //laces
            llSetColor(<0.68, 0.85, 0.9>, 4); //insides
            llSetColor(<1.0, 1.0, 1.0>, 5); //middle
        }
        else if (message == "dreamyLilac")
        {
            llSetTexture(dlSides, sides);
            llSetTexture(dlBottom, bottom);
            llSetColor(<1.0, 0.82, 0.86>, 7); //front
            llSetColor(<1.0, 0.82, 0.86>, 0); //back
            llSetColor(<0.68, 0.78, 0.81>, 3); //laces
            llSetColor(<0.78, 0.63, 0.78>, 4); //insides
            llSetColor(<0.68, 0.78, 0.81>, 5); //middle
        }
        else if (message == "clearSkies")
        {
            llSetTexture(csSides, sides);
            llSetTexture(csBottom, bottom);
            llSetColor(<0.90, 0.90, 0.90>, 7); //front
            llSetColor(<0.90, 0.90, 0.90>, 0); //back
            llSetColor(<0.90, 0.90, 0.90>, 3); //laces
            llSetColor(<0.68, 0.85, 0.9>, 4); //insides
            llSetColor(<1.0, 0.84, 0.53>, 5); //middle
        }
        else if (message == "sunnyDays")
        {
            llSetTexture(sdSides, sides);
            llSetTexture(sdBottom, bottom);
            llSetColor(<0.68, 0.85, 0.9>, 7); //front
            llSetColor(<0.68, 0.85, 0.9>, 0); //back
            llSetColor(<1.0, 0.51, 0.18>, 3); //laces
            llSetColor(<0.99, 0.84, 0.25>, 4); //insides
            llSetColor(<1.0, 0.51, 0.18>, 5); //middle
        }
        else if (message == "rainbowDelight")
        {
            llSetTexture(rdSides, sides);
            llSetTexture(rdBottom, bottom);
            llSetColor(<1.0, 0.7, 0.73>, 7); //front
            llSetColor(<1.0, 0.7, 0.73>, 0); //back
            llSetColor(<0.88, 0.73, 0.89>, 3); //laces
            llSetColor(<1.0, 0.7, 0.73>, 4); //insides
            llSetColor(<0.88, 0.73, 0.89>, 5); //middle
        }
    }
}