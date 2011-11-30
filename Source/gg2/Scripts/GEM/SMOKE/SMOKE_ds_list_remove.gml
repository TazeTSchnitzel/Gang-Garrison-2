// argument0 - list
// argument1 - item

if (ds_list_find_index(argument0, argument1) != -1) {
    ds_list_delete(argument0,
        ds_list_find_index(argument0, argument1));
    return true;
}else{
    return false;
}
