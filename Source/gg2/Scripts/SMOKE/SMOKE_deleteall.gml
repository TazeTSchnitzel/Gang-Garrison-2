// argument0 - mask

var file;

file_find_first(argument0, 0);
while (1) {
    file = file_find_next();
    if (file != "") {
        file_delete(file);
    }else{
        break;
    }
}
