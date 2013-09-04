// draw_sprite_ext_planet(sprite,subimg,x,y,xscale,yscale,rot,color,alpha)
// The same as draw_sprite_ext, but it draws it scaled, positioned and rotated correctly for the planet

var _sprite, _subimg, _x, _y, _xscale, _yscale, _rot, _color, _alpha;
_sprite = argument0;
_subimg = argument1;
_x = argument2;
_y = argument3;
_xscale = argument4;
_yscale = argument5;
_rot = argument6;
_color = argument7;
_alpha = argument8;

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

// Angle of sprite and radius on planet
angle = -(((_x - actualXOffset) / global.planetMapWidth) * 360 - 90);
radius = ((global.planetMapHeight - _y) / global.planetMapHeight) * global.planetCircleRadius;

// Scaling for planet
scaleX = (pi * radius * 2) / global.planetMapWidth;
scaleY = global.planetCircleRadius / global.planetMapHeight;

draw_sprite_ext(_sprite,
    _subimg,
    centreX + lengthdir_x(radius, angle),
    bottomY + lengthdir_y(radius, angle),
    _xscale * scaleX,
    _yscale * scaleY,
    angle - 90 + _rot,
    _color,
    _alpha);
