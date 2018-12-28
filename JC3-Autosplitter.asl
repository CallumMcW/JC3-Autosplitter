state("JustCause3")
{
    bool loading : 0x2F38848, 0x94;
    bool csLoading : 0x2F38848, 0xB0, 0x88, 0x3D0, 0xD8, 0x80;
    bool player : 0x2F2EFF0, 0x558;
}

startup {
    vars.ver = "0.0.1";
    vars.restart = false;

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
    vars.DebugOutput("initialized script");
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