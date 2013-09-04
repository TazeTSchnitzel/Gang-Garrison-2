// planetMapPosToPlanetPos(x, y)
// Takes x and y for map pos and finds x and y for pos on planet
// Sets global.planetPosX and global.planetPosY to calculated values

var _x, _y;
_x = argument0;
_y = argument1;

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

var angle, radius, _x, _y, scaleX, scaleY;

// Angle and radius on planet
angle = -(((_x - actualXOffset) / global.planetMapWidth) * 360 - 90);
radius = ((global.planetMapHeight - _y) / global.planetMapHeight) * global.planetCircleRadius;

// Scaling for planet
scaleX = (pi * radius * 2) / global.planetMapWidth;
scaleY = global.planetCircleRadius / global.planetMapHeight;

global.planetPosX = centreX + lengthdir_x(radius, angle);
global.planetPosY = bottomY + lengthdir_y(radius, angle);
