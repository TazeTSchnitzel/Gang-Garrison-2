// argument0 - filename

if (file_exists("temp.ini")) {
    file_delete("temp.ini");
}
file_copy(argument0, "temp.ini");
ini_open("temp.ini");
