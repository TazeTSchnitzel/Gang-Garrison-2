// real/string lispSetTail(real cell, real/string newTail)
// Set the tail of a cons cell
// Warning, this function is destructive!

var cell, newTail;
cell = argument0;
newTail = argument1;

lispRemoveRef(lispTail(cell));
ds_list_replace(cell, 3, newTail);
