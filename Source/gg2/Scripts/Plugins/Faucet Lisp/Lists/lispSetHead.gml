// real/string lispSetHead(real cell, real/string newHead)
// Set the head of a cons cell
// Warning, this function is destructive!

var cell, newHead;
cell = argument0;
newHead = argument1;

lispRemoveRef(lispHead(cell));
ds_list_replace(cell, 2, newHead);
