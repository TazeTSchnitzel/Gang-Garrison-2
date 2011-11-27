var i;

SMOKE_loadconfig();
SMOKE_saveconfig();
global.SMOKE_domain = "smoke.ajf.me";
global.SMOKE_localdebug = false;
global.SMOKE_plugindirpath = working_directory + "\Plugins\";
if (!directory_exists(global.SMOKE_plugindirpath)) {
    directory_create(global.SMOKE_plugindirpath);
}
SMOKE_updateplugins();
for (i = 0; i < ds_list_size(global.SMOKE_enabledpluginlist); i+=1) {
    SMOKE_runplugin(ds_list_find_value(global.SMOKE_enabledpluginlist, i), false);
}
