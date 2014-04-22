// real lispCons(real/string head, real/string tail)
// Constructs a cons cell from a head and a tail
// Will have a reference count of 1

var head, tail;
head = argument0;
tail = argument1;

var cell;
cell = ds_list_create();
ds_list_add(cell, LISP_CELL);   // Type descriptor
ds_list_add(cell, 1);           // Reference count
ds_list_add(cell, head);
ds_list_add(cell, tail);

return cell;
