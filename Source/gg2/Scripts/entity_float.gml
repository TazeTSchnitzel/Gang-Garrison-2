// makes entity rise to surface, returns false if at surface

if (collision_point(x,y-3,WaterBox,false,false)) {
    vspeed = 0;
    y -= 3;
}else if (collision_point(x,y-2,WaterBox,false,false)) {
    vspeed = 0;
    y -= 2;
}else if (collision_point(x,y-1,WaterBox,false,false)) {
    vspeed = 0;
    y -= 1;
}else{
    return false;
}
return true;
