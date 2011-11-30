/*
All built-in console commands are defined here, big strings approaching.
*/


Console_addCommand("kick", "
var player;
player = ds_list_find_value(global.players, real(floor(input[1])));
if player != -1 and player != ds_list_find_value(global.players, 0)
{
    with player
    {
        socket_destroy_abortive(socket);
        socket = -1;
    }
    Console_print(player.name+' has been kicked successfully.');
}
else
{
    Console_print('Could not find a player with that ID.');
}", "
Console_print('Syntax: kick playerID')
Console_print('Use: Kicks the designed player from the game, disconnecting him but not banning him.')
Console_print('Warning: Attempting to kick the host will have no effect.')"
);



Console_addCommand("ban", "
var player, ip;
player = ds_list_find_value(global.players, real(floor(input[1])));
if player != -1 and player != ds_list_find_value(global.players, 0)
{
    with player
    {
        ip = socket_remote_ip(socket);
        ds_list_add(global.banlist, ip);
        socket_destroy_abortive(socket);
        socket = -1;
        Console_print(player.name+' has been banned successfully.');
    }
}
else
{
    Console_print('Could not find a player with that ID.');
}", "
Console_print('Syntax: ban playerID')
Console_print('Use: Bans the designed player from the game, disconnecting him and making it impossible for him to join later.')
Console_print('Warning: Attempting to ban the host will have no effect.')
Console_print('If you have not enabled persistent banning, all bans will be reset when gg2 is restarted.')
");



Console_addCommand("listPlayers", "
var redteam, blueteam, specteam, player;
redteam = ds_list_create();
blueteam = ds_list_create();
specteam = ds_list_create();

with Player
{
    if team == TEAM_RED
    {
        ds_list_add(redteam, id);
    }
    else if team == TEAM_BLUE
    {
        ds_list_add(blueteam, id);
    }
    else
    {
        ds_list_add(specteam, id);
    }
}

for (i=0; i<ds_list_size(redteam); i+=1)
{
    player = ds_list_find_value(redteam, i);
    Console_print('/:/r'+player.name+':    ID='+string(ds_list_find_index(global.players, player))+'; IP='+string(socket_remote_ip(player.socket)));
}
for (i=0; i<ds_list_size(blueteam); i+=1)
{
    player = ds_list_find_value(blueteam, i);
    Console_print('/:/b'+player.name+':    ID='+string(ds_list_find_index(global.players, player))+'; IP='+string(socket_remote_ip(player.socket)));
}
for (i=0; i<ds_list_size(specteam); i+=1)
{
    player = ds_list_find_value(specteam, i);
    Console_print('/:/g'+player.name+':    ID='+string(ds_list_find_index(global.players, player))+'; IP='+string(socket_remote_ip(player.socket)));
}", "
Console_print('Syntax: listPlayers')
Console_print('Use: Prints a color-coded list of the IDs of all the players in the game, as well as their IPs.')
Console_print('These IDs are necessary for anything requiring a specific player, like kicking.')");


Console_addCommand("help", "
if input[1] == ''
{
    var key;
    // User didn't ask any specific command, just give the general command list.
    Console_print('----------------------------------------------------------------------------------');
    Console_print('GEM'+string(GAME_VERSION_STRING)+' console;');
    Console_print('');
    Console_print('Usage: Type in the wanted command followed by its arguments in this syntax:');
    Console_print('command arg1 arg2 arg3')
    Console_print('');
    Console_print('Some commands require Player IDs, the command listPlayers can show them to you.')
    Console_print('');
    Console_print('The current command list:');
    key = ds_map_find_first(global.commandMap);
    Console_print(key);
    for (i=0; i<ds_map_size(global.commandMap)-2; i+=1)
    {
        key = ds_map_find_next(global.commandMap, key);
        Console_print(key);
    }
    Console_print('')
    Console_print('For more details on each command, enter |help commandName|.')
    Console_print('Additional questions or requests should go to the GEM thread.')
    Console_print('');
    Console_print('Made by AJF and Orpheon.');
    Console_print('----------------------------------------------------------------------------------');
}
else
{
    if ds_map_exists(global.documentationMap, input[1])
    {
        execute_string(ds_map_find_value(global.documentationMap, input[1]));
    }
    else
    {
        Console_print('No documentation could be found for that command.');
    }
}", "");


Console_addCommand("clearScreen", "
with Console
{
    clearScreenTimer = 36// Makes text zoom up instead of just disappearing
}
", "
Console_print('Syntax: clearScreen')
Console_print('Use: Clears the console')");


Console_addCommand("setClasslimit", "
var chosenClass, noClassChosen;
noClassChosen = 0
switch string_lower(input[1])
{
    case 'scout':
        chosenClass = CLASS_SCOUT;
        break;
        
    case 'runner':
        chosenClass = CLASS_SCOUT;
        break;

    case 'soldier':
        chosenClass = CLASS_SOLDIER;
        break;
        
    case 'rocketman':
        chosenClass = CLASS_SOLDIER;
        break;
        
    case 'pyro':
        chosenClass = CLASS_PYRO;
        break;
    
    case 'firebug':
        chosenClass = CLASS_PYRO;
        break;
        
    case 'heavy':
        chosenClass = CLASS_HEAVY;
        break;
        
    case 'overweight':
        chosenClass = CLASS_HEAVY;
        break;
        
    case 'demoman':
        chosenClass = CLASS_DEMOMAN;
        break;
    
    case 'detonator':
        chosenClass = CLASS_DEMOMAN;
        break;
        
    case 'medic':
        chosenClass = CLASS_MEDIC;
        break;
        
    case 'healer':
        chosenClass = CLASS_MEDIC;
        break;
        
    case 'engineer':
        chosenClass = CLASS_ENGINEER;
        break;
        
    case 'constructor':
        chosenClass = CLASS_ENGINEER;
        break;
        
    case 'spy':
        chosenClass = CLASS_SPY;
        break;
        
    case 'infiltrator':
        chosenClass = CLASS_SPY;
        break;
        
    case 'sniper':
        chosenClass = CLASS_SNIPER;
        break;
        
    case 'rifleman':
        chosenClass = CLASS_SNIPER;
        break;
        
    case 'quote':
        chosenClass = CLASS_QUOTE;
        break;
        
    case 'curly':
        chosenClass = CLASS_QUOTE;
        break;
        
    case '':
        noClassChosen = 1;
        break;
        
    default:
        Console_print('Could not find a class with that name.');
        exit;
}

if !noClassChosen
{
    if input[2] != 'off'
    {
        global.classlimits[chosenClass] = real(input[2])
    }
    else
    {
        global.classlimits[chosenClass] = global.playerLimit+15
    }

    var suggestedClass;

    with Player
    {
        if class == chosenClass
        {
            suggestedClass = getClasslimit(team, class);
            if suggestedClass != class// Class has been switched, send that to everyone
            {
                if(object != -1)
                {
                    with(object)
                    {
                        if (collision_point(x,y,SpawnRoom,0,0) < 0)
                        {
                            if (lastDamageDealer == -1 || lastDamageDealer == player)
                            {
                                sendEventPlayerDeath(player, player, noone, BID_FAREWELL);
                                doEventPlayerDeath(player, player, noone, BID_FAREWELL);
                            }
                            else
                            {
                                var assistant;
                                assistant = secondToLastDamageDealer;
                                if (lastDamageDealer.object != -1)
                                    if (lastDamageDealer.object.healer != -1)
                                        assistant = lastDamageDealer.object.healer;
                                sendEventPlayerDeath(player, lastDamageDealer, assistant, FINISHED_OFF);
                                doEventPlayerDeath(player, lastDamageDealer, assistant, FINISHED_OFF);
                            }
                        }
                        else 
                        instance_destroy(); 
                    }
                }
                else if(alarm[5]<=0)
                {
                    alarm[5] = 1;
                }
                    
                class = suggestedClass

                ServerPlayerChangeclass(ds_list_find_index(global.players, id), class, global.sendBuffer);
            }
        }
    }
}
Console_print('Current classlimits:')

if global.classlimits[CLASS_SCOUT] >= global.playerLimit Console_print(' Scout: Off');
else Console_print(' Scout: '+string(global.classlimits[CLASS_SCOUT]));

if global.classlimits[CLASS_PYRO] >= global.playerLimit Console_print(' Pyro: Off');
else Console_print(' Pyro: '+string(global.classlimits[CLASS_PYRO]));

if global.classlimits[CLASS_SOLDIER] >= global.playerLimit Console_print(' Soldier: Off');
else Console_print(' Soldier: '+string(global.classlimits[CLASS_SOLDIER]));

if global.classlimits[CLASS_HEAVY] >= global.playerLimit Console_print(' Heavy: Off');
else Console_print(' Heavy: '+string(global.classlimits[CLASS_HEAVY]));

if global.classlimits[CLASS_DEMOMAN] >= global.playerLimit Console_print(' Demoman: Off');
else Console_print(' Demoman: '+string(global.classlimits[CLASS_DEMOMAN]));

if global.classlimits[CLASS_MEDIC] >= global.playerLimit Console_print(' Medic: Off');
else Console_print(' Medic: '+string(global.classlimits[CLASS_MEDIC]));

if global.classlimits[CLASS_ENGINEER] >= global.playerLimit Console_print(' Engineer: Off');
else Console_print(' Engineer: '+string(global.classlimits[CLASS_ENGINEER]));

if global.classlimits[CLASS_SPY] >= global.playerLimit Console_print(' Spy: Off');
else Console_print(' Spy: '+string(global.classlimits[CLASS_SPY]));

if global.classlimits[CLASS_SNIPER] >= global.playerLimit Console_print(' Sniper: Off');
else Console_print(' Sniper: '+string(global.classlimits[CLASS_SNIPER]));

if global.classlimits[CLASS_QUOTE] >= global.playerLimit Console_print(' Quote: Off');
else Console_print(' Quote: '+string(global.classlimits[CLASS_QUOTE]));
","
Console_print('Syntax: setClasslimit className newClasslimit');
Console_print('className can be typed with the tf2 or the gg2 name, but only in singular.');
Console_print('Use: Change current classlimits of a class');");


Console_addCommand("startRecording", "
if global.recordingEnabled
{
    Console_print('You are already recording.');
    exit;
}
else
{
    global.recordingEnabled = 1;
    global.justEnabledRecording = 1;
    Console_print('Started recording...')
}", "
Console_print('Syntax: startRecording');
Console_print('Use: Begins to record the current game into a replay. To stop recording, call');
Console_print('stopRecording');
");


Console_addCommand("stopRecording", "
if !global.recordingEnabled
{
    Console_print('You are not recording.');
    exit;
}
else
{
    Console_print('Saving...')
    endRecording();
    Console_print('Replay saved successfully');
}
", "
Console_print('Syntax: stopRecording');
Console_print('Use: Stops any recording going on and saves the replay.');
");


Console_addCommand("endMap", "
if input[1] != ''
{
    // User entered a map
    global.suggestedMap = input[1]
    global.mapchanging = 0
}
global.winners = TEAM_SPECTATOR;
", "
Console_print('Syntax: endMap optionalMapName')
Console_print('Use: Ends the map with a stalemate, and if you have entered a map name will change to that map.')
Console_print('If you havent, it will simply go to the next map in the rotation.');
Console_print('Warning: Please be careful to enter a correct map name, entering a wrong one will crash the server!');
");


Console_addCommand("shuffleMaps", "
ds_list_shuffle(global.map_rotation);
Console_print('Shuffled map rotation');
", "
Console_print('Syntax: shuffleMaps');
Console_print('Use: Randomizes the map rotation');
");


Console_addCommand("changeNextMap", "
global.nextMap = input[1]
", "
Console_print('Syntax: changeNextMap mapName')
Console_print('Sets the designated map as the next map.');
Console_print('Warning: Please be careful to enter a correct map name, entering a wrong one will crash the server!');
");
