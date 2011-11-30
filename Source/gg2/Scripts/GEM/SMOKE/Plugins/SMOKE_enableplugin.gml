// argument0 - plugin ID

var restart;

ini_open(global.SMOKE_plugindirpath+argument0+"\metadata.ini");
restart = ini_read_real("plugin", "restart", 1);
ini_close();

if !SMOKE_versioncheck(argument0) return false;

if (ds_list_find_index(global.SMOKE_enabledPluginList, argument0) <= -1)
{
    ds_list_add(global.SMOKE_enabledPluginList, argument0);

    ini_open("smoke.ini");
    ini_write_string("plugins", "plugins", SMOKE_listToCsv(global.SMOKE_pluginList));
    ini_write_string("plugins", "enabled", SMOKE_listToCsv(global.SMOKE_enabledPluginList));
    ini_close();
}

if restart 
{
    if show_message_ext("This plugin requires restarting GG2 to run it. Do you want to restart GG2 now?", "Yes", "", "No")
    {
        execute_program(parameter_string(0), "", false);
        game_end();
    }
}
else
{
    SMOKE_runplugin(argument0, true);
}

return true;
