// Draws the planet background
var xoffset, yoffset, xsize, ysize;

xoffset = view_xview[0];
yoffset = view_yview[0];
xsize = view_wview[0];
ysize = view_hview[0];

var centreX, bottomY;

centreX = xoffset + xsize / 2;
bottomY = yoffset + ysize;

var actualXOffset;
// The xview but with the player at 0 relative to the screen
actualXOffset = xoffset + xsize / 2;

// Draw the planet, centred at the bottom of the screen, rotated to the xview
draw_sprite_ext(global.planetBackground, 0, centreX, bottomY, 1, 1, (actualXOffset / global.planetMapWidth) * 360 + 90, c_white, 1);
