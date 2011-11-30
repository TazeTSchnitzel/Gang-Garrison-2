// argument0 - plugin id
io_handle() 
SMOKE_deleteall(global.SMOKE_plugindirpath+argument0, 0);
SMOKE_deleteall(global.SMOKE_plugindirpath+argument0+"\data", 0);
if (SMOKE_ds_list_remove(global.SMOKE_pluginlist, argument0)) {
    SMOKE_saveconfig();
}
if (SMOKE_ds_list_remove(global.SMOKE_enabledpluginlist, argument0)) {
    SMOKE_saveconfig();
}
