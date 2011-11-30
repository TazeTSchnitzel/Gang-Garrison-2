// argument0 - plugin id

if (SMOKE_ds_list_remove(global.SMOKE_enabledpluginlist, argument0)) {
    SMOKE_saveconfig();
}
