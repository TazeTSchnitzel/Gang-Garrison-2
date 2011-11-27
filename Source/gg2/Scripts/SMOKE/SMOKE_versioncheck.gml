// argument0 - plugin ID

var gg2version;

SMOKE_tempiniopen(global.SMOKE_plugindirpath+argument0+"\metadata.ini");
gg2version = ini_read_real("plugin", "gg2version", 1);
ini_close();

if (VERSION < gg2version) {
    show_message("You are using GG2 version " + string(VERSION) + ", but this plugin requires version " + string(gg2version) + ". Update GG2 before using this plugin.");
    return false;
}else{
    return true;
}   
