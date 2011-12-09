{
    if global.botMode == 3 and argument0.object_index == Player// Mixed VS Mixed: Fill Server
    {
        // Create a bot to replace the leaving player.
        CreateBot();
    }

    with(argument0) {
        instance_destroy();
    }
    
    ds_list_delete(global.players, ds_list_find_index(global.players, argument0));
}
