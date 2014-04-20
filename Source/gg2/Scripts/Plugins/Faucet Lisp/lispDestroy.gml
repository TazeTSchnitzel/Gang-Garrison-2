// real lispDestroy(real list)
// Recursively destroys a Faucet Lisp list

var list;
list = argument0;

var head;
while (!ds_list_empty(list))
{
    head = ds_list_find_value(list, 0);
    if (is_real(head))
        lispDestroy(head);
    ds_list_delete(list, 0);
}
ds_list_destroy(list);
