// draw_text_transformed_planet(x,y,string,xscale,yscale,angle)
// The same as draw_text_transformed, but it draws it scaled, positioned and rotated correctly for the planet

var _x, _y, _string, _xscale, _yscale, _angle;
_x = argument0;
_y = argument1;
_string = argument2;
_xscale = argument3;
_yscale = argument4;
_angle = argument5;

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

// Angle of text and radius on planet
angle = -(((_x - actualXOffset) / global.planetMapWidth) * 360 - 90);
radius = ((global.planetMapHeight - _y) / global.planetMapHeight) * global.planetCircleRadius;

// Scaling for planet
scaleX = (pi * radius * 2) / global.planetMapWidth;
scaleY = global.planetCircleRadius / global.planetMapHeight;

draw_text_transformed(centreX + lengthdir_x(radius, angle),
    bottomY + lengthdir_y(radius, angle),
    _string,
    _xscale * scaleX,
    _yscale * scaleY,
    angle - 90 + _angle);;
