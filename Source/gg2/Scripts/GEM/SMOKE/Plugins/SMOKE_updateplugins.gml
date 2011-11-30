var verlist;
var i;
var pluginId, version, curversion, name;

verlist = SMOKE_http_string(SMOKE_DOMAIN, "/api/plugincheck/"+SMOKE_listToCsv(global.SMOKE_pluginList));
verlist = SMOKE_csvToList(verlist);

for (i = 0; i < ds_list_size(global.SMOKE_pluginList); i+=1)
{
    pluginId = ds_list_find_value(global.SMOKE_pluginList, i);
    version = real(ds_list_find_value(verlist, i));
    ini_open(global.SMOKE_pluginPath+pluginId+"\metadata.ini");
    curversion = ini_read_real("plugin", "version", -1);
    name = ini_read_string("plugin", "name", "");
    ini_close();
    if (version > curversion)
    {
        var answeredYes;
        answeredYes = show_message_ext("The plugin '" + name + "' (ID "+pluginid+") is currently at version "+string(curversion)+". The most recent version is "+string(version)+", do you want to update?", "Yes", "", "No")
        if (answeredYes) {
            SMOKE_downloadplugin(pluginId, true);
        }
    }
}
