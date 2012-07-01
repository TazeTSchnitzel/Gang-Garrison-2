// Processes scaling and parallax layers, as well as bg, of map

// argument0: filename

var filename, basename, layercount, scale, part, pos, sectionwidth, i;

// get rid of extension
filename = argument0;
basename = filename_change_ext(filename, '');

/* RANT TIME
   WHY ON EARTH DOES THIS USE ONE-INDEXED STRINGS
   SERIOUSLY
   _WHY_
   IT IS A COMPLETE PITA
 */


// does it contain a marker?
pos = string_pos('!!', basename);
if (pos != -1) {
    // split it up
    part = string_copy(basename, pos + 2, string_length(basename) - pos - 1);
    show_message(part);
    // check for divider
    pos = string_pos('-', part);
    if (pos == 2) {
        // OK, so it's definitely a map name of format:
        // `mapname` "!!" `layer count` "-" `scale`
        // where layer count and scale are both single digits
        layercount = real(string_char_at(part, 1));
        scale = real(string_char_at(part, 3));
    } else {
        show_message("Invalid map layer and scaling specification. Using defaults instead.");
        layercount = 1;
        scale = 6;
    }
} else {
    // defaults
    layercount = 1;
    scale = 6;
}

global.CustomMapScale = scale;
global.CustomMapLayers = layercount;

sectionwidth = (background_get_width(CustomMapB) * scale) / layercount;
room_set_width(CustomMapRoom, sectionwidth);
room_set_width(CustomMapRoom, background_get_height(CustomMapB) * scale);

background_replace(CustomMapB, argument0, false, false);
background_xscale[0] = scale;
background_yscale[0] = scale;
for (i = 0; i < 8; i += 1) {
    background_visible[i] = false;
}
for (i = 0; i < layercount; i += 1) {
    background_visible[i] = true;
    background_index[i] = CustomMapB;
    background_x[i] = -i*sectionwidth;
}
