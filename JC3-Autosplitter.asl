state("JustCause3")
{
    bool loading : 0x2F38848, 0x94;
    bool csLoading : 0x2F38848, 0xB0, 0x88, 0x3D0, 0xD8, 0x80;
    bool player : 0x2F2EFF0, 0x558;
    bool autosplit : 0x2F38820, 0xA0, 0x7E8, 0x30, 0x6B0, 0xB8;
}

startup {
    vars.ver = "1.0";
    vars.restart = false;
    vars.split = 0;
    vars.newSplit = 0;
    vars.splitting = 0;

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
    vars.DebugOutput("initialized script, but what do you care you snoopy snooper D:");
}

start{
    vars.split = 0;
}

split{
    if (current.autosplit == true){
        if (vars.splitting == 0){
            vars.split = (vars.split + 1);
            vars.splitting = 1;
            if ((vars.split == 2) | (vars.split == 4) | (vars.split == 6) | (vars.split == 12) | (vars.split == 13) | (vars.split == 15)  | (vars.split == 16)  | (vars.split == 17)  | (vars.split == 18)  | (vars.split == 22)  | (vars.split == 23)  | (vars.split == 24)  | (vars.split == 33)  | (vars.split == 34)  | (vars.split == 35)  | (vars.split == 36)  | (vars.split == 37)  | (vars.split == 38)  | (vars.split == 39)  | (vars.split == 41)  | (vars.split == 42)  | (vars.split == 43)  | (vars.split == 44)){
                return false;
                vars.DebugOutput("Cards screen number " + vars.split + ". This is a designated skipped cards screen in Any%");
            }
            else{
                return true;
            }
        }
        else{
            return false;
        }
    }
    else{
        vars.splitting = 0;
    }
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