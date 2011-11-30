// argument0 - plugin id

ds_list_delete(global.Smoke_enabledPluginList, ds_list_find_index(global.enabledPluginList, argument0));

ini_open("smoke.ini");
ini_write_string("plugins", "plugins", SMOKE_listToCsv(global.SMOKE_pluginList));
ini_write_string("plugins", "enabled", SMOKE_listToCsv(global.SMOKE_enabledPluginList));
ini_close();
