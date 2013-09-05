// Notify the server about the current keystate and aim direction
// Argument 0: Buffer or socket to write to
// Argument 1: the current keybyte

// Find position of player projected onto planet
var list, playerX, playerY;
list = planetMapPosToPlanetPos(global.myself.object.x, global.myself.object.y);
playerX = ds_list_find_value(list, 2);
playerY = ds_list_find_value(list, 3);
ds_list_destroy(list);

write_ubyte(argument0, INPUTSTATE);
write_ubyte(argument0, argument1);
write_ushort(argument0, point_direction(playerX, playerY, mouse_x, mouse_y)*65536/360);
