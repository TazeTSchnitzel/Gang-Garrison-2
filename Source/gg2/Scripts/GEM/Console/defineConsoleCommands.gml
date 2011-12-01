/*
Defines the built-in commands.
Since I replaced everything except the help command, there isn't much here anymore.
*/


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
