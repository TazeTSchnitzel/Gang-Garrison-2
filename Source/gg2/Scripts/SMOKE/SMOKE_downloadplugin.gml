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
    SMOKE_http_file("smoke.ajf.me", "/api/plugin/"+pluginid+"/getmetadata", global.SMOKE_plugindirpath+pluginid+"\metadata.ini");
    show_message("Plugin Metadata downloaded");
    SMOKE_http_file("smoke.ajf.me", "/api/plugin/"+pluginid+"/getcontent", global.SMOKE_plugindirpath+pluginid+"\plugin.gml");
    show_message("Plugin GML downloaded");
    if (ds_list_find_index(global.SMOKE_pluginlist, pluginid) == -1) {
        ds_list_add(global.SMOKE_pluginlist, pluginid);
        SMOKE_saveconfig();
    }
    if (argument1==false) {
        SMOKE_enableplugin(pluginid);
    }
}else{
    show_message("Error: Plugin with ID "+pluginid+" does not exist");
    exit;
}
