global.consoleLog = ds_list_create()
global.consoleOpen = 0
global.commandMap = ds_map_create();
global.documentationMap = ds_map_create();

Console_print("Welcome to GEM"+string(GAME_VERSION_STRING)+"!")
Console_print("If you need help on a specific command, just type 'help command'.")
Console_print("You can get a more general help and a list of most commands by typing just 'help'.")
Console_print("")
Console_print("Report any bugs or requests on the GEM thread in the GG2 Forums. Thank you.")
Console_print("")
Console_print("----------------------------------------------------------------------------------")
Console_print("")
