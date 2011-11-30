// argument0 - Plugin ID
// argument1 - Update (as opposed to fresh download)

var pluginid;
var plugininfo;
var restart;
pluginid = string(argument0);

if (string_copy(SMOKE_http_string(SMOKE_DOMAIN, "/api/plugin/"+pluginid+"/getexists"), 0, 4)=="true")
{
    if (!directory_exists(global.SMOKE_pluginPath+pluginid))
    {
        directory_create(global.SMOKE_pluginPath+pluginid);
    }

    SMOKE_http_file(SMOKE_DOMAIN, "/api/plugin/"+pluginid+"/getmetadata", global.SMOKE_pluginPath+pluginid+"\metadata.ini", true);
    SMOKE_http_file(SMOKE_DOMAIN, "/api/plugin/"+pluginid+"/getcontent", global.SMOKE_pluginPath+pluginid+"\plugin.zip", true);
    SMOKE_extractzip(global.SMOKE_pluginPath+pluginid+"\plugin.zip", global.SMOKE_pluginPath+pluginid+"\", true);
    if (ds_list_find_index(global.SMOKE_pluginList, pluginid) == -1)
    {
        ds_list_add(global.SMOKE_pluginList, pluginid);
        
        ini_open("smoke.ini");
        ini_write_string("plugins", "plugins", SMOKE_listToCsv(global.SMOKE_pluginList));
        ini_write_string("plugins", "enabled", SMOKE_listToCsv(global.SMOKE_enabledPluginList));
        ini_close();
    }

    if (argument1)
    {
        show_message("Plugin updated");
    }else
    {
        show_message("Plugin downloaded");
    }

    if (argument1==false)
    {
        SMOKE_enableplugin(pluginid);
    }
}
else
{
    show_message("Error: Plugin with ID "+pluginid+" does not exist");
    exit;
}
