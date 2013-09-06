// Clear up existing sprite, if it exists
if (variable_global_exists('planetBackground'))
    sprite_delete(global.planetBackground)

// Save on function calls by caching these values
global.planetMapWidth = map_width();
global.planetMapHeight = map_height();

// This is essentially a constant
//global.planetCircleRadius = 600;
global.planetCircleRadius = global.planetMapHeight / 2;

var cacheFilename;
cacheFilename = working_directory + "\PlanetPrerenderCache\" + global.currentMap + "@" + global.currentMapMD5 + "@" + string(global.planetCircleRadius) + ".png";

// No cached version, pre-render it
if (!file_exists(cacheFilename))
{
    // Before pre-rendering, let's blank screen with a message to explain the wait
    draw_set_alpha(1);
    draw_set_color(c_black);
    draw_rectangle(0, 0, 800, 600, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(400, 300, "Pre-rendering planet...");
    screen_refresh();
    io_handle();
    
    // Create a drawing surface so we can pre-render the planet
    var surface, centreX, centreY;
    surface = surface_create(global.planetCircleRadius * 2, global.planetCircleRadius * 2);
    centreX = global.planetCircleRadius;
    centreY = global.planetCircleRadius;
    
    // Switch to surface drawing
    surface_set_target(surface);
    
    // Iterate over each pixel of surface
    var angle, radius, mapX, mapY, _x, _y;
    for (_x = 0; _x < global.planetCircleRadius * 2; _x += 1)
    {
        for (_y = 0; _y < global.planetCircleRadius * 2; _y += 1)
        {
            // Calculate angle/radius of point on planet from x and y
            angle = point_direction(global.planetCircleRadius, global.planetCircleRadius, _x, _y);
            radius = point_distance(global.planetCircleRadius, global.planetCircleRadius, _x, _y);
            // Figure out where that corresponds to on actual map
            mapX = floor(global.planetMapWidth - (angle / 360) * global.planetMapWidth) mod global.planetMapWidth;
            mapY = floor(global.planetMapHeight - (radius / global.planetCircleRadius) * global.planetMapHeight);
            if (mapY >= 0 and mapY <= global.planetMapHeight)
            {
                // Fill in pixel from actual map
                draw_background_part(background_index,
                    floor(mapX / 6),
                    floor(mapY / 6),
                    1,
                    1,
                    _x,
                    _y);
            }
        }
        io_handle();
    }
    
    // Switch back to normal drawing
    surface_reset_target();
    
    // Create a sprite from surface
    global.planetBackground = sprite_create_from_surface(
        surface,
        0,
        0, 
        global.planetCircleRadius * 2,
        global.planetCircleRadius * 2,
        false,
        false,
        global.planetCircleRadius,
        global.planetCircleRadius);
    
    // Clear up
    surface_free(surface);

    // Create cache dir if it doesn't exit
    if (!directory_exists(working_directory + "\PlanetPrerenderCache"))
        directory_create(working_directory + "\PlanetPrerenderCache");
    
    // Cache    
    sprite_save(global.planetBackground, 0, cacheFilename);
}
// Is cached
else
{
    // Load from file
    global.planetBackground = sprite_add(cacheFilename, 1, false, false, global.planetCircleRadius, global.planetCircleRadius);
}

// Make instance of object which will draw planet
instance_create(0, 0, PlanetDrawer);

// Hide background
background_visible = false;
