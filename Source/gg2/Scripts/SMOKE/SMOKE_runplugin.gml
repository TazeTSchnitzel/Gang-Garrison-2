// argument0 - plugin ID
// argument1 - just updated

if (directory_exists(global.SMOKE_plugindirpath+argument0)){
    if (SMOKE_versioncheck(argument0) == false) exit;
    global.SMOKE_pluginupdated = argument1;
    global.SMOKE_plugindatapath = global.SMOKE_plugindirpath+argument0+"\data\";
    execute_file(global.SMOKE_plugindirpath+argument0+"\plugin.gml");
}else{
    show_message("Error! Cannot find Plugin with ID "+argument0);
}   
