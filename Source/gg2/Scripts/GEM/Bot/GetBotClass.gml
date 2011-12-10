var classList, foundClass, class;

if !ds_list_empty(global.botClassList)
{
    // Someone wants a very precise class composition
    class = ds_list_find_value(global.botClassList, global.botClassCounter)
    global.botClassCounter = (global.botClassCounter+1) mod (ds_list_size(global.botClassList)*2)
    return class
}

classList = ds_list_create()

if global.botClasses[CLASS_SCOUT]
{
    ds_list_add(classList, CLASS_SCOUT)
}
if global.botClasses[CLASS_PYRO]
{
    ds_list_add(classList, CLASS_PYRO)
}
if global.botClasses[CLASS_SOLDIER]
{
    ds_list_add(classList, CLASS_SOLDIER)
}
if global.botClasses[CLASS_HEAVY]
{
    ds_list_add(classList, CLASS_HEAVY)
}
if global.botClasses[CLASS_ENGINEER]
{
    ds_list_add(classList, CLASS_ENGINEER)
}
if global.botClasses[CLASS_SNIPER]
{
    ds_list_add(classList, CLASS_SNIPER)
}
if global.botClasses[CLASS_MEDIC]
{
    ds_list_add(classList, CLASS_MEDIC)
}

if ds_list_empty(classList)
{
    class = choose(CLASS_SCOUT, CLASS_PYRO, CLASS_SOLDIER, CLASS_HEAVY, CLASS_ENGINEER, CLASS_SNIPER, CLASS_MEDIC)
    if global.botNameCounter == 1 show_message("No Class Free.#Choosing randomly.")
    return class
}

return ds_list_find_value(classList, random_range(0, ds_list_size(classList)))
