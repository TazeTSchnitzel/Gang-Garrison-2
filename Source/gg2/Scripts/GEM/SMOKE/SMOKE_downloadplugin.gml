// argument0 - Plugin ID
// argument1 - Update (as opposed to fresh download)

var pluginid;
var plugininfo;
var restart;
pluginid = string(argument0);

if (string_copy(SMOKE_http_string("smoke.ajf.me", "/api/plugin/"+pluginid+"/getexists"), 0, 4)=="true") {
    if (!directory_exists(global.SMOKE_plugindirpath+pluginid)){
        directory_create(global.SMOKE_plugindirpath+pluginid);
    }
    SMOKE_http_file("smoke.ajf.me", "/api/plugin/"+pluginid+"/getmetadata", global.SMOKE_plugindirpath+pluginid+"\metadata.ini", true);
    SMOKE_http_file("smoke.ajf.me", "/api/plugin/"+pluginid+"/getcontent", global.SMOKE_plugindirpath+pluginid+"\plugin.zip", true);
    SMOKE_extractzip(global.SMOKE_plugindirpath+pluginid+"\plugin.zip", global.SMOKE_plugindirpath+pluginid+"\", true);
    if (ds_list_find_index(global.SMOKE_pluginlist, pluginid) == -1) {
        ds_list_add(global.SMOKE_pluginlist, pluginid);
        SMOKE_saveconfig();
    }
    if (argument1){
        show_message("Plugin updated");
    }else{
        show_message("Plugin downloaded");
    }
    if (argument1==false) {
        SMOKE_enableplugin(pluginid);
    }
}else{
    show_message("Error: Plugin with ID "+pluginid+" does not exist");
    exit;
}
