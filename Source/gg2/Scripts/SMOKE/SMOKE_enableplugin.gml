// argument0 - plugin ID

var restart;

if (ds_list_find_index(global.SMOKE_enabledpluginlist, argument0) == -1) {
    ds_list_add(global.SMOKE_enabledpluginlist, argument0);
    SMOKE_saveconfig();
}
SMOKE_tempiniopen(global.SMOKE_plugindirpath+argument0+"\metadata.ini");
restart = ini_read_real("plugin", "restart", 1);
ini_close();
if (restart==1) {
    if (show_message_ext("This plugin requires restarting GG2 to run it. Do you want to restart GG2 now?", "Yes", "", "No") == 1) {
        execute_program(parameter_string(0), "", false);
        game_end();
    }
}else{
    SMOKE_runplugin(argument0, true);
}
