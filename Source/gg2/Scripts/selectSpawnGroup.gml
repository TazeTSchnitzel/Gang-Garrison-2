{
    //argument0: The team which spawn group is seeked

    var team, group;
    team = argument0;
    
    group = 0; 
    while (group != -1 )
    {
        if team == TEAM_RED {
            if ds_list_empty(global.spawnPointsRed[0,group])
                group -=1;
            else break;
        }
        else if team == TEAM_BLUE {
            if ds_list_empty(global.spawnPointsBlue[0,group])
                group -=1;
            else break;
        }
    }
    return group;
}
