var i;

ini_open("smoke.ini");
global.SMOKE_pluginList = SMOKE_csvToList(ini_read_string("plugins", "plugins", ""));
global.SMOKE_enabledPluginList = SMOKE_csvToList(ini_read_string("plugins", "enabled", ""));

ini_write_string("plugins", "plugins", SMOKE_listToCsv(global.SMOKE_pluginList));
ini_write_string("plugins", "enabled", SMOKE_listToCsv(global.SMOKE_enabledPluginList));
ini_close();

global.SMOKE_localdebug = false;

global.SMOKE_pluginPath = working_directory + "\Plugins\";
if (!directory_exists(global.SMOKE_pluginPath)) {
    directory_create(global.SMOKE_pluginPath);
}

SMOKE_updateplugins();
for (i = 0; i < ds_list_size(global.SMOKE_enabledPluginList); i+=1)
{
    SMOKE_runplugin(ds_list_find_value(global.SMOKE_enabledPluginList, i), false);
}
