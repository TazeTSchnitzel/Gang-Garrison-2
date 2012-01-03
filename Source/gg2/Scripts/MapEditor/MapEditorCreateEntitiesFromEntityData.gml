// creates map editor objects per the list in the entity data

// argument0: entity data

{
    var currentPos, entityType, entityX, entityY, wordLength, DIVIDER, DIVREPLACEMENT;
    DIVIDER = chr(10);
    DIVREPLACEMENT = " ";
    
    argument0+=DIVIDER;
    
    currentPos = 1;
    
    while(string_pos(DIVIDER, argument0) != 0) { // continue until there are no more entities left
        // grab the entity type
        wordLength = string_pos(DIVIDER, argument0) - currentPos;
        entityType = string_copy(argument0, currentPos, wordLength);
        argument0 = string_replace(argument0, DIVIDER, DIVREPLACEMENT);
        currentPos += wordLength + string_length(DIVREPLACEMENT);
        // grab the x coordinate
        wordLength = string_pos(DIVIDER, argument0) - currentPos;
        entityX = real(string_copy(argument0, currentPos, wordLength));
        argument0 = string_replace(argument0, DIVIDER, DIVREPLACEMENT);
        currentPos += wordLength + string_length(DIVREPLACEMENT);
        // grab the y coordinate
        wordLength = string_pos(DIVIDER, argument0) - currentPos;
        entityY = real(string_copy(argument0, currentPos, wordLength));
        argument0 = string_replace(argument0, DIVIDER, DIVREPLACEMENT);
        currentPos += wordLength + string_length(DIVREPLACEMENT);
               
        var ent;
        
        ent = instance_create(entityX, entityY, MapEditorEntity);
        ent.type = entityType;
    }
}
