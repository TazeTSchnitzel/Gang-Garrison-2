var num;
var pluginid;
var kill;

kill = false;
num = clipboard_get_text();

if (string_copy(num, 0, 6) == "plugin") {
    splash_show_web("about:blank", 1);
    pluginid = string_copy(num, 10, string_length(num)-9);
    if (string_copy(num, 7, 3) == "en_") {
        if (SMOKE_enableplugin(pluginid)) show_message("Enabled plugin");
    }else if (string_copy(num, 7, 3) == "ds_") {
        SMOKE_disableplugin(pluginid);
        show_message("Disabled plugin");
    }else if (string_copy(num, 7, 3) == "dl_") {
        if (show_message_ext("Are you sure you want to download the Plugin with the ID " + pluginid + "?", "Yes", "", "No") == 1) {
            SMOKE_downloadplugin(pluginid, false);
        }
    }else if (string_copy(num, 7, 3) == "rm_") {
        SMOKE_removeplugin(pluginid);
        show_message("Removed plugin");
    }
    kill = true;
}else if (string_copy(num, 0, 12) == "close_manage") {
    splash_show_web("about:blank", 1);
    kill = true;
}else if (num != "do_nothing") {
    splash_show_web("about:blank", 1);
    show_message("Error: Unrecognised management command");
    kill = true;
}

if (kill) with (SMOKE_ClippyChecker) {
    instance_destroy();
}
