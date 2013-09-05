// planetMapOrigin()
// Gives x and y position of the planet's origin, and the x offset not centred on player
// Return value is a list:
// 0 - originX - X position of planet origin
// 1 - originY - Y position of planet origin
// 2 - offsetX - X offset of camera, but not centred on player

var xoffset, yoffset, xsize, ysize;

xoffset = view_xview[0];
yoffset = view_yview[0];
xsize = view_wview[0];
ysize = view_hview[0];

var originX, originY, offsetX;

originX = xoffset + xsize / 2;
originY = yoffset + ysize;
// The xview but with the player at 0 relative to the screen
offsetX = xoffset + xsize / 2;

var returnValue;
returnValue = ds_list_create();
ds_list_add(returnValue, originX);
ds_list_add(returnValue, originY);
ds_list_add(returnValue, offsetX);
return returnValue;
