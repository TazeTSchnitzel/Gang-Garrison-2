// real lispRemoveRef(real thing)
// Decrements the reference counter of a reference-counted thing

var thing;
thing = argument0;

// Strings aren't reference-counted
if (is_string(thing))
    exit;

var refcount;
// First element of ds_list is type descriptor, second is reference count
refcount = ds_list_find_value(thing, 1) - 1;
ds_list_replace(thing, 1, refcount);

if (refcount <= 0)
{
    var type;
    type = ds_list_find_value(thing, 0);
    if (type == LISP_CELL)
        lispDestroyCell(thing);
}
