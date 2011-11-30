ini_open("smoke.ini");
ini_write_string("plugins", "plugins", SMOKE_parselist(global.SMOKE_pluginlist));
ini_write_string("plugins", "enabled", SMOKE_parselist(global.SMOKE_enabledpluginlist));
ini_close();
