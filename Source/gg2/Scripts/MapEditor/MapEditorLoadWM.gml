// argument0 - wm filename

if (global.MapEditorWallmask != -1)
    sprite_delete(global.MapEditorWallmask);

global.MapEditorWallmaskFilename = argument0;
global.MapEditorWallmask = sprite_add(argument0, 1, true, true, 0, 0);
VisibleWallmask.sprite_index = global.MapEditorWallmask;
