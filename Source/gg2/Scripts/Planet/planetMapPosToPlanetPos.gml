// planetMapPosToPlanetPos(x, y)
// Takes opsition on map, finds angle/radius on planet plus position, scale and rotation projected on planet
// Return value is a list:
// 0 - angle - on planet
// 1 - radius - distance from planet centre
// 2 - drawX - projected X position of point on planet
// 3 - drawY - projected Y position of point on planet
// 4 - scaleX - horizontal scaling factor for drawing onto planet
// 5 - scaleY - vertical scaling factor for drawing onto planet
// 6 - drawAngle - rotation of entity, for drawing onto planet

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

var angle, radius;

// Find angle and radius on planet
angle = -(((_x - actualXOffset) / global.planetMapWidth) * 360 - 90);
radius = ((global.planetMapHeight - _y) / global.planetMapHeight) * global.planetCircleRadius;

// Projection
var drawX, drawY, scaleX, scaleY, drawAngle;
drawX = centreX + lengthdir_x(radius, angle);
drawY = bottomY + lengthdir_y(radius, angle);
scaleX = (pi * radius * 2) / global.planetMapWidth;
scaleY = global.planetCircleRadius / global.planetMapHeight;
drawAngle = angle - 90;

var returnValue;
returnValue = ds_list_create();
ds_list_add(returnValue, angle);
ds_list_add(returnValue, radius);
ds_list_add(returnValue, drawX);
ds_list_add(returnValue, drawY);
ds_list_add(returnValue, scaleX);
ds_list_add(returnValue, scaleY);
ds_list_add(returnValue, drawAngle);
return returnValue;
