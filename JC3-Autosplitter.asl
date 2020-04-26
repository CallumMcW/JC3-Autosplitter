state("JustCause3")
{
    bool loading : 0x2F38848, 0x94;
    bool csLoading : 0x2F38848, 0xB0, 0x88, 0x3D0, 0xD8, 0x80;
    bool player : 0x2F2EFF0, 0x558;
<<<<<<< HEAD
    bool cardsScreen : 0x2F38820, 0xA0, 0x7E8, 0x30, 0x6B0, 0xB8;
    bool mission : 0x2F38820, 0x80, 0x658, 0x468, 0x668, 0x304;
=======
>>>>>>> parent of 31f49a6... Added Any% Autosplitting
}

startup {
    vars.ver = "1.0";
    vars.restart = false;
<<<<<<< HEAD
    vars.missionEnd = 0;
=======
>>>>>>> parent of 31f49a6... Added Any% Autosplitting

    // Log Output switch for DebugView (enables/disables debug messages)
    var DebugEnabled = true;
    Action<string> DebugOutput = (text) => {
        if (DebugEnabled)
        {
            print(" «[JC3 - v" + vars.ver + "]» " + text);
        }
    };
    vars.DebugOutput = DebugOutput;
}

init {
<<<<<<< HEAD
    vars.DebugOutput("initialized script, but what do you care you snoopy snooper D:");
}

start{
    vars.missionEnd = 0;
    vars.restart = false;
}

split{
    if((vars.missionEnd == 1) && (current.cardsScreen == false) && (old.cardsScreen != current.cardsScreen)){
        vars.DebugOutput("SPLITTING!!");
        return true;
        vars.missionEnd = 0;
    }
=======
    vars.DebugOutput("initialized script");
>>>>>>> parent of 31f49a6... Added Any% Autosplitting
}

update {
    if(current.loading != old.loading) {
        // the value changed, write it to our debug output
        vars.DebugOutput("normal loading state changed from " + old.loading + " to " + current.loading);
    }
    if(current.csLoading != old.csLoading) {
        // the value changed, write it to our debug output
        vars.DebugOutput("cutscene loading state changed from " + old.csLoading + " to " + current.csLoading);
    }
    if ((vars.restart == true) && (current.player == true)){
        vars.restart = false;
    }
    if((current.mission != old.mission) && (current.mission == false)){
        // a mission just ended!
        vars.DebugOutput("mission state changed from " + old.mission + " to " + current.mission);
        vars.missionEnd = 1;
    }
}

isLoading
{
    if (vars.restart == true){
        return true;
    }
    else{
        if (current.loading == true){
            return true;
        }
        else{
            if (current.csLoading == true){
                return true;
            }
            else{
                return false;
            }
        }
    }
}

exit
{
    timer.IsGameTimePaused = true;
    vars.restart = true;
}