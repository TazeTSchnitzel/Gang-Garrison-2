ini_open("smoke.ini");
global.SMOKE_pluginlist = SMOKE_parsecsv(ini_read_string("plugins", "plugins", ""));
global.SMOKE_enabledpluginlist = SMOKE_parsecsv(ini_read_string("plugins", "enabled", ""));
ini_close();
