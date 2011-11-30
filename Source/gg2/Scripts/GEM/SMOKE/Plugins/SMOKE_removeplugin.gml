// argument0 - plugin id

io_handle()

SMOKE_deleteAllFiles(global.SMOKE_pluginPath+argument0, 0);
SMOKE_deleteAllFiles(global.SMOKE_pluginPath+argument0+"\data", 0);

ds_list_delete(global.SMOKE_pluginList, ds_list_find_index(global.SMOKE_pluginList, argument0))

ds_list_delete(global.SMOKE_enabledPluginList, ds_list_find_index(global.SMOKE_enabledPluginList, argument0))

ini_open("smoke.ini");
ini_write_string("plugins", "plugins", SMOKE_listToCsv(global.SMOKE_pluginList));
ini_write_string("plugins", "enabled", SMOKE_listToCsv(global.SMOKE_enabledPluginList));
ini_close();
