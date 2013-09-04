// Notify the server about the current keystate and aim direction
// Argument 0: Buffer or socket to write to
// Argument 1: the current keybyte

var playerX, playerY;

// Find position of player on planet
planetMapPosToPlanetPos(global.myself.object.x, global.myself.object.y);
playerX = global.planetPosX;
playerY = global.planetPosY;

write_ubyte(argument0, INPUTSTATE);
write_ubyte(argument0, argument1);
write_ushort(argument0, point_direction(playerX, playerY, mouse_x, mouse_y)*65536/360);
