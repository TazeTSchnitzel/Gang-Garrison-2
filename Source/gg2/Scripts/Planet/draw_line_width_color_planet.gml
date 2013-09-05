// draw_line_width_color_planet(x1,y1,x2,y2,w,col1,col2);
// The same as draw_line_width_color, but it draws it scaled and positioned correctly for the planet
var _x1, _y1, _x2, _y2, _w, _col1, _col2;
_x1 = argument0;
_y1 = argument1;
_x2 = argument2;
_y2 = argument3;
_w = argument4;
_col1 = argument5;
_col2 = argument6;

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

var angle1, radius1, scaleX1, scaleY1;

// Angle of sprite and radius on planet
angle1 = -(((_x1 - actualXOffset) / global.planetMapWidth) * 360 - 90);
radius1 = ((global.planetMapHeight - _y1) / global.planetMapHeight) * global.planetCircleRadius;

// Scaling for planet
scaleX1 = (pi * radius1 * 2) / global.planetMapWidth;
scaleY1 = global.planetCircleRadius / global.planetMapHeight;

var angle2, radius2, scaleX2, scaleY2;

// Angle of sprite and radius on planet
angle2 = -(((_x2 - actualXOffset) / global.planetMapWidth) * 360 - 90);
radius2 = ((global.planetMapHeight - _y2) / global.planetMapHeight) * global.planetCircleRadius;

// Scaling for planet
scaleX2 = (pi * radius2 * 2) / global.planetMapWidth;
scaleY2 = global.planetCircleRadius / global.planetMapHeight;

var x1, y1, x2, y2;
x1 = centreX + lengthdir_x(radius1, angle1);
y1 = bottomY + lengthdir_y(radius1, angle1);
x2 = centreX + lengthdir_x(radius2, angle2);
y2 = bottomY + lengthdir_y(radius2, angle2);

var scale;
scale = (scaleX1 + scaleY1 + scaleX2 + scaleY2) / 4;

draw_line_width_color(x1, y1, x2, y2, _w * scale, _col1, _col2);
