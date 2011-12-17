ini_open("gg2.ini");

global.permBan = ini_read_real("Server", "Permanent Ban enabled", 0);
global.classlimits[CLASS_SCOUT] = ini_read_real("Classlimits", "Scout", 9999);
global.classlimits[CLASS_PYRO] = ini_read_real("Classlimits", "Pyro", 9999);
global.classlimits[CLASS_SOLDIER] = ini_read_real("Classlimits", "Soldier", 9999);
global.classlimits[CLASS_HEAVY] = ini_read_real("Classlimits", "Heavy", 9999);
global.classlimits[CLASS_DEMOMAN] = ini_read_real("Classlimits", "Demoman", 9999);
global.classlimits[CLASS_MEDIC] = ini_read_real("Classlimits", "Medic", 9999);
global.classlimits[CLASS_ENGINEER] = ini_read_real("Classlimits", "Engineer", 9999);
global.classlimits[CLASS_SPY] = ini_read_real("Classlimits", "Spy", 9999);
global.classlimits[CLASS_SNIPER] = ini_read_real("Classlimits", "Sniper", 9999);
global.classlimits[CLASS_QUOTE] = ini_read_real("Classlimits", "Quote", 9999);

ini_write_real("Server", "Permanent Ban enabled", global.permBan);
ini_write_real("Classlimits", "Scout", global.classlimits[CLASS_SCOUT]);
ini_write_real("Classlimits", "Pyro", global.classlimits[CLASS_PYRO]);
ini_write_real("Classlimits", "Soldier", global.classlimits[CLASS_SOLDIER]);
ini_write_real("Classlimits", "Heavy", global.classlimits[CLASS_HEAVY]);
ini_write_real("Classlimits", "Demoman", global.classlimits[CLASS_DEMOMAN]);
ini_write_real("Classlimits", "Medic", global.classlimits[CLASS_MEDIC]);
ini_write_real("Classlimits", "Engineer", global.classlimits[CLASS_ENGINEER]);
ini_write_real("Classlimits", "Spy", global.classlimits[CLASS_SPY]);
ini_write_real("Classlimits", "Sniper", global.classlimits[CLASS_SNIPER]);
ini_write_real("Classlimits", "Quote", global.classlimits[CLASS_QUOTE]);


// Bots
global.botNumber = ini_read_real("Bots", "Number (in total)", 0)
global.botMode = ini_read_real("Bots", "Fight mode", 0)
global.botNamePrefix = ini_read_string("Bots", "Bot Name Prefix", "")
global.botLearningMode = ini_read_real("Bots", "Bot learning", 1)
global.botClasses[CLASS_SCOUT] = ini_read_real("Bots", "Runners enabled", 1)
global.botClasses[CLASS_PYRO] = ini_read_real("Bots", "Firebugs enabled", 1)
global.botClasses[CLASS_SOLDIER] = ini_read_real("Bots", "Rocketmen enabled", 1)
global.botClasses[CLASS_HEAVY] = ini_read_real("Bots", "Overweights enabled", 1)
global.botClasses[CLASS_MEDIC] = ini_read_real("Bots", "Healers enabled", 1)
global.botClasses[CLASS_ENGINEER] = ini_read_real("Bots", "Constructors enabled", 1)
global.botClasses[CLASS_SNIPER] = ini_read_real("Bots", "Riflemen enabled", 1)   
global.botDebugMode = ini_read_real("Bots", "Debug Mode enabled", 0)

ini_write_real("Bots", "Number (in total)", global.botNumber)
ini_write_real("Bots", "Fight mode", global.botMode)
ini_write_real("Bots", "Bot Learning", global.botLearningMode)
ini_write_string("Bots", "Bot Name Prefix", global.botNamePrefix)
ini_write_real("Bots", "Runners enabled", global.botClasses[CLASS_SCOUT])
ini_write_real("Bots", "Firebugs enabled", global.botClasses[CLASS_PYRO])
ini_write_real("Bots", "Rocketmen enabled", global.botClasses[CLASS_SOLDIER])
ini_write_real("Bots", "Overweights enabled", global.botClasses[CLASS_HEAVY])
ini_write_real("Bots", "Healers enabled", global.botClasses[CLASS_MEDIC])
ini_write_real("Bots", "Constructors enabled", global.botClasses[CLASS_ENGINEER])
ini_write_real("Bots", "Riflemen enabled", global.botClasses[CLASS_SNIPER])
ini_write_real("Bots", "Debug Mode enabled", global.botDebugMode)

ini_close();

global.botNameCounter = 1// This makes the number in the bot's name increase by one each time
global.changedNodeMap = 0// Indicates whether an improvement to the nodemap was done, so that if yes it can save the new one.
global.botClassCounter = 0// These two are for wished class compositions:
global.botClassList = ds_list_create()
global.userCreatedBot[0] = 0// This is for people wishing for a specific bot

global.botNameSocketMap = ds_map_create();

// Example of wished class composition (can only be hard-coded atm):
/*ds_list_add(global.botClassList, CLASS_SCOUT)// Red
ds_list_add(global.botClassList, CLASS_SCOUT)// Blue
ds_list_add(global.botClassList, CLASS_SOLDIER)// Red
ds_list_add(global.botClassList, CLASS_SOLDIER)// Blue etc...
ds_list_add(global.botClassList, CLASS_PYRO)
ds_list_add(global.botClassList, CLASS_PYRO)
ds_list_add(global.botClassList, CLASS_MEDIC)
ds_list_add(global.botClassList, CLASS_MEDIC)
ds_list_add(global.botClassList, CLASS_HEAVY)
ds_list_add(global.botClassList, CLASS_HEAVY)
ds_list_add(global.botClassList, CLASS_ENGINEER)
ds_list_add(global.botClassList, CLASS_ENGINEER)
ds_list_add(global.botClassList, CLASS_SNIPER)
ds_list_add(global.botClassList, CLASS_SNIPER)*/


global.banlist = ds_list_create()
global.banlistNames = ds_list_create()
global.suggestedMap = ""
global.replayBuffer = buffer_create();// Used by the server to save the replay and by the client to load it.
global.isPlayingReplay = 0;
global.replaySpeed = 1;
global.justEnabledRecording = 0;// Used to know if the recording just began, to save the first bytes.

// Load the banlist if persistent banning was enabled.
if global.permBan
{
    var text;
        
    if !file_exists("Banlist.txt")
    {
        text = file_text_open_write("Banlist.txt")
        file_text_close(text)
    }
    else
    {
        var ip, name;
            
        text = file_text_open_read("Banlist.txt")
        while !file_text_eof(text)
        {
            ip = file_text_read_string(text)
            file_text_readln(text)// Next line
                
            if string_count("#", ip) > 0
            {
                name = string_copy(ip, string_pos("#", ip)+2, string_length(ip))
                ip = string_copy(ip, 0, string_pos("#", ip)-1)// Remove the name which is preceded with that "#".
                ds_list_add(global.banlistNames, name)
            }
            else
            {
                ds_list_add(global.banlistNames, "")
            }

            ds_list_add(global.banlist, ip)
        }
            
        file_text_close(text)
    }
}
consoleInit()
defineConsoleCommands()

SMOKE_init();
