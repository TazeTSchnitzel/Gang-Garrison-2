var verlist;
var i;
var pluginid, version, curversion, name;

verlist = SMOKE_http_string("smoke.ajf.me", "/api/plugincheck/"+SMOKE_parselist(global.SMOKE_pluginlist));
verlist = SMOKE_parsecsv(verlist);

for (i = 0; i < ds_list_size(global.SMOKE_pluginlist); i+=1) {
    pluginid = ds_list_find_value(global.SMOKE_pluginlist, i);
    version = real(ds_list_find_value(verlist, i));
    SMOKE_tempiniopen(global.SMOKE_plugindirpath+pluginid+"\metadata.ini");
    curversion = ini_read_real("plugin", "version", -1);
    name = ini_read_string("plugin", "name", "");
    ini_close();
    if (version > curversion) {
        if (show_message_ext("The plugin '" + name + "' (ID "+pluginid+") is currently at version "+string(curversion)+". The most recent version is "+string(version)+", do you want to update?", "Yes", "", "No") == 1) {
            SMOKE_downloadplugin(pluginid, true);
        }
    }
}
