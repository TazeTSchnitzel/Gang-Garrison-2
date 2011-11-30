clipboard_set_text("do_nothing");

splash_set_main(false);
splash_set_border(false);
splash_set_interrupt(false);
splash_set_close_button(false);
if (global.SMOKE_localdebug)
    splash_show_web("http://localhost:5000/pluginsetmodcookie?installed="+SMOKE_listToCsv(global.SMOKE_pluginList)+"&enabled="+SMOKE_listToCsv(global.SMOKE_enabledPluginList), 0);
else
    splash_show_web("http://smoke.ajf.me/pluginsetmodcookie?installed="+SMOKE_listToCsv(global.SMOKE_pluginList)+"&enabled="+SMOKE_listToCsv(global.SMOKE_enabledPluginList), 0);
    
instance_create(0, 0, SMOKE_ClippyChecker);
