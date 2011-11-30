// argument0 - dir

var file;

file_find_first(argument0+"\*.*", 0|fa_readonly|fa_hidden|fa_sysfile|fa_archive);
while (1) {
    file = file_find_next();
    if (file != "") {
        file_delete(argument0+"\"+file);
    }else{
        file_find_close();
        break;
    }
}
