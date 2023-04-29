state("Watch_Dogs")
{
    // unknown/default version
}

state("Watch_Dogs" , "v1.04.497") 
{
	int XP: "Disrupt_b64.dll", 0x396E038, 0x768, 0x0, 0x60, 0x8, 0xB8, 0x20;

	int act1mainmissions: "Disrupt_b64.dll", 0x3950830, 0xA8, 0x18, 0xC8, 0x18, 0x180, 0x98, 0xC24;

	int act2mainmissions: "Disrupt_b64.dll", 0x3950830, 0x10, 0x48, 0x38, 0x98, 0x2C4;

	int act3mainmissions: "Disrupt_b64.dll", 0x3950830, 0x18, 0x10, 0x50, 0x30, 0x68, 0x654;
	
	int act4mainmissions: "Disrupt_b64.dll", 0x3950830,  0x58, 0x78, 0x98, 0x954;

	int lineid: "Disrupt_b64.dll", 0x3940438, 0x20;
	
	int ending: "Disrupt_b64.dll", 0x393EB78;
	
	int loading: "Disrupt_b64.dll", 0x39562CC;	

	int lineIdIdx0: "Disrupt_b64.dll", 0x3940438, 0x8, 0x30;

	int lineIdIdx1: "Disrupt_b64.dll", 0x3940438, 0x8, 0x70;
}

state("Watch_Dogs" , "v1.06.329 Steam Latest")
{
	int XP: "Disrupt_b64.dll", 0x3BDB920, 0x90, 0x18, 0xAA8;
	
	int act1mainmissions: "Disrupt_b64.dll", 0x3B70098, 0x10, 0x78, 0x98, 0xEC4;
	
	int act2mainmissions: "Disrupt_b64.dll", 0x3B70098, 0x40, 0x48, 0x168, 0x3B4;

	int act3mainmissions: "Disrupt_b64.dll", 0x3B70098, 0x40, 0x48, 0x1A0, 0x7D4;

	int act4mainmissions: "Disrupt_b64.dll", 0x3B70098, 0x10, 0x48, 0x98, 0xB64;
	
	int lineid: "Disrupt_b64.dll", 0x3B5CAB8, 0x20;
	
	int ending: "Disrupt_b64.dll", 0x3B5B078;
	
	int loading: "Disrupt_b64.dll", 0x3B7BAFC;
	
	int lineIdIdx0: "Disrupt_b64.dll", 0x3B5CAB8, 0x8, 0x30;

	int lineIdIdx1: "Disrupt_b64.dll", 0x3B5CAB8, 0x8, 0x70;
}

state("Watch_Dogs" , "v1.06.329 Uplay Latest")
{
	int XP: "Disrupt_b64.dll", 0x3B59050, 0x40, 0x98, 0x248, 0xA8;

	int act1mainmissions: "Disrupt_b64.dll", 0x3B91918, 0xE0, 0x1E8, 0x98, 0xEC4;

	int act2mainmissions: "Disrupt_b64.dll", 0x3B91918, 0x110, 0x1F8, 0x168, 0x3B4;
	
	int act3mainmissions: "Disrupt_b64.dll", 0x3B91918, 0xE0, 0xC8, 0x18, 0x180, 0x98, 0x7D4;
	
	int act4mainmissions: "Disrupt_b64.dll", 0x3B91918, 0xE0, 0x1E8, 0x98, 0xB64;
	
	int lineid: "Disrupt_b64.dll", 0x3B784F8, 0x20;
	
	int ending: "Disrupt_b64.dll", 0x3B76B28;
	
	int loading: "Disrupt_b64.dll", 0x3B94ACC;

	int lineIdIdx0: "Disrupt_b64.dll", 0x3B784F8, 0x8, 0x30;

	int lineIdIdx1: "Disrupt_b64.dll", 0x3B784F8, 0x8, 0x70;
}


startup{

    vars.stopwatch = new Stopwatch();
    vars.line0Stopwatch = new Stopwatch();
    vars.line1Stopwatch = new Stopwatch();
    
    settings.Add ("CTOS Control Centers", false, "CTOS Control Centers");
    settings.SetToolTip("CTOS Control Centers", "Splits after completing a ctOS control center.");

    settings.CurrentDefaultParent = "CTOS Control Centers";
    settings.Add("Brandon Docks", false, "Brandon Docks");
    settings.Add("The Wards", false, "The Wards");
    settings.Add("Mad Mile", false, "Mad Mile");
    settings.Add("Pawnee", false, "Pawnee");
    
    settings.CurrentDefaultParent = null;
    settings.Add("Hacking Contract", false, "Hacking Contract");
    settings.SetToolTip("Hacking Contract", "Splits after completing the hacking invasion mission in Act 1 with 2XTheTap and accessing the online contracts app");
    
    settings.Add("Remember", false, "Remember");
    settings.SetToolTip("Remember", "Splits after the cemetery cutscene in Act 1");

    settings.Add("Log Dialog", false, "Log Dialog");
    settings.SetToolTip("Log Dialog", "Log line IDs and their duration in milliseconds as they occurred in the run to LineLog.txt next to your LiveSplit.exe");
   
    
    Action<string> logDebug = (text) => {
        print("[Watch_Dogs Autosplitter | DEBUG] "+ text);
    };
    vars.logDebug = logDebug;

    Func<ProcessModuleWow64Safe, string> calcModuleHash = (module) => {
        vars.logDebug("Calcuating hash of " + module.FileName);
        byte[] exeHashBytes = new byte[0];
        using (System.Security.Cryptography.MD5 sha = System.Security.Cryptography.MD5.Create())
        {
            using (FileStream s = File.Open(module.FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
            {
                exeHashBytes = sha.ComputeHash(s);
            }
        }
        string hash = exeHashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
        vars.logDebug("Hash: " + hash);
        return hash;
    };
    vars.calcModuleHash = calcModuleHash;

	vars.lastSplitTime = null;
	Func<bool> isNotDoubleSplit = () => {
		bool isDoubleSplit = false;
		if (vars.lastSplitTime != null) {
			System.TimeSpan ts = System.DateTime.Now - vars.lastSplitTime;
			if (ts.TotalSeconds < 20) {
				isDoubleSplit = true;
				vars.logDebug("Double split detected!");
			}
		}
		vars.lastSplitTime = System.DateTime.Now;
		return !isDoubleSplit;
	};
	vars.isNotDoubleSplit = isNotDoubleSplit;

	Action<string> logLine = (text) => {
		vars.logDebug("Writing line: " + text);
		if (vars.lineLogFile == null) {
			vars.lineLogFile = File.Open("LineLog.txt", FileMode.Append, FileAccess.Write, FileShare.ReadWrite);
		}
		byte[] line = new UTF8Encoding(true).GetBytes(text + "\r\n");
		vars.lineLogFile.Write(line, 0, line.Length);
	};
	vars.lineLogFile = null;
	vars.logLine = logLine;

	Action<int, int, Stopwatch> detectLineChange = (oldLineId, newLineId, stopwatch) => {
		// if (oldLineId != newLineId) {
		// 	vars.logDebug("oldLineId:" + oldLineId + " newLineId:" + newLineId);
		// }

		if (oldLineId <= 0 && newLineId > 0) {
			// no dialog -> dialog
			stopwatch.Restart();
		} else if (oldLineId > 0 && newLineId == -1) {
			// dialog -> no dialog
			vars.logLine(oldLineId + "\t" + stopwatch.ElapsedMilliseconds);
		} else if (oldLineId != newLineId && oldLineId > 0 && newLineId > 0) {
			// Dialog -> different dialog
			vars.logLine(oldLineId + "\t" + stopwatch.ElapsedMilliseconds);
			stopwatch.Restart();
		}	
	};
	vars.detectLineChange = detectLineChange;
}

shutdown
{
	if (vars.lineLogFile != null) {
		vars.lineLogFile.Close();
	}
}

init{

    // vars.logDebug("modules: " + String.Join(", ", modules.Select(m=> m.ModuleName + " : " + m.BaseAddress.ToString() + " : " + m.EntryPointAddress.ToString())));
    ProcessModuleWow64Safe module = modules.Single(x => String.Equals(x.ModuleName, "Disrupt_b64.dll", StringComparison.OrdinalIgnoreCase));
    string hash = vars.calcModuleHash(module);
    switch (hash)
    {
        case "C3B1AD89FCCC74FE9C5BC5050A233308":
            version = "v1.04.497";
            break;
	case "1837A42D913BB7DAF94FEF3163BA615A":
            version = "v1.06.329 Steam Latest";
            break;    
        case "77D09E2A3DAAABBFEE4F3466F52A5794":
            version = "v1.06.329 Uplay Latest"; 
            break;
        default:
            throw new NotImplementedException("Unrecognized hash: " + hash);
            break;
    }
}


isLoading
{
    	if (version != "")
	    return current.loading > 0;
}


update{

        if (vars.stopwatch.ElapsedMilliseconds > 10000) {
	    	vars.stopwatch.Reset();
		}

		if (settings["Log Dialog"]) {
			vars.detectLineChange(old.lineIdIdx0, current.lineIdIdx0, vars.line0Stopwatch);
			vars.detectLineChange(old.lineIdIdx1, current.lineIdIdx1, vars.line1Stopwatch);
		}
		
}


start{

	if (vars.stopwatch.ElapsedMilliseconds > 2000) {
	    vars.stopwatch.Reset();
	}

	if (current.lineid == 46209) {
		vars.stopwatch.Start();
		if(vars.stopwatch.ElapsedMilliseconds > 300) {  //Aiden Story Start
			if(settings["Log Dialog"]) {
				vars.logLine("### Starting new run ###");
			}
			return true;
		}
	}
		
	if (current.lineid == 10004649) { //Bad Blood Start
		if(settings["Log Dialog"]) {
			vars.logLine("### Starting new run ###");
		}
		return true;
	}
}


split{ 
	if(current.act1mainmissions == old.act1mainmissions + 1)  //Aiden Story
		return vars.isNotDoubleSplit();	

	if(current.act2mainmissions == old.act2mainmissions + 1)  //Aiden Story
		return vars.isNotDoubleSplit();	
	
	if(current.act3mainmissions == old.act3mainmissions + 1)   //Aiden Story
		return vars.isNotDoubleSplit();	
	
	if(current.act4mainmissions == old.act4mainmissions + 1)   //Aiden Story
		return vars.isNotDoubleSplit();
		
	if(current.lineid == 194143 && old.ending == 0 && current.ending == 1)    //Aiden Story Ending
        	return vars.isNotDoubleSplit();
	
	if(settings["Hacking Contract"] && current.lineid == 217543)
    	{
        	vars.stopwatch.Start();
        	if(vars.stopwatch.ElapsedMilliseconds > 6033)	  //Act 1 Fake Online Hacking Mission
            		return vars.isNotDoubleSplit();
   	}
	
	if(settings["Remember"] && current.lineid == 204646)      //Act 1 Graveyard Visit
    	{
		vars.stopwatch.Start();
        	if(vars.stopwatch.ElapsedMilliseconds > 7300)
            		return vars.isNotDoubleSplit();
    	}	
		
	if(settings["Brandon Docks"] && current.lineid == 208307)  //Brandon Docks ctOS Control Center
		return vars.isNotDoubleSplit(); 

    	if(settings["The Wards"] && (current.act2mainmissions == 5) && current.XP == old.XP+500)   //The Wards ctOS Control Center
		return vars.isNotDoubleSplit(); 

    	if(settings["Mad Mile"] && current.lineid == 209437)    //Mad Mile ctOS Control Center
		return vars.isNotDoubleSplit(); 

    	if(settings["Pawnee"] && current.lineid == 219093)      //Pawnee ctOS Control Center
		return vars.isNotDoubleSplit(); 
		
	if(current.XP == old.XP + 250 && current.act1mainmissions < 1)   //BB A1M1 & BB A1M2
		return vars.isNotDoubleSplit();								
	
	if(current.XP == old.XP + 500 && current.act1mainmissions < 1)   //BB A1M3
		return vars.isNotDoubleSplit(); 

	if(current.XP == old.XP + 600)               //BB A2M1
		return vars.isNotDoubleSplit();

	if(current.XP == old.XP + 650)               //BB A2M2
		return vars.isNotDoubleSplit();
	
	if(current.XP == old.XP + 800)               //BB A2M3 & BB A2M4
		return vars.isNotDoubleSplit();
	
	if(current.XP == old.XP + 1000)              //BB A3M1
		return vars.isNotDoubleSplit();

	if(current.XP == old.XP + 1500)              //BB A3M2
		return vars.isNotDoubleSplit();
}

reset{

  	if(current.lineid == 46208)
		return true; 
}
