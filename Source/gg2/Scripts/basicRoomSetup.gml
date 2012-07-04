room_caption = global.currentMap;

global.startedGame = true;

global.totalMapAreas = 1+instance_number(NextAreaO);

if global.totalMapAreas > 1 {
    global.area[1] = 0;
    
    for(i=2;i<=global.totalMapAreas;i+=1) {
        global.area[i] = instance_find(NextAreaO,i-2).y;
    }

    if global.currentMapArea == 1 {
        with all if y > global.area[2] instance_destroy();
    }
    else if global.currentMapArea < global.totalMapAreas {
        with all if (y > global.area[global.currentMapArea+1] || y < global.area[global.currentMapArea]) && y > 0 instance_destroy();
    }
    else if global.currentMapArea == global.totalMapAreas {
        with all if y < global.area[global.currentMapArea] && y > 0 instance_destroy();
    }
}

offloadSpawnPoints();
with(Player) {
    canSpawn = 1;
    humiliated = 0;
}

if instance_exists(IntelligenceBaseBlue) || instance_exists(IntelligenceBaseRed) || instance_exists(IntelligenceRed) || instance_exists(IntelligenceBlue) instance_create(0,0,ScorePanel);

instance_create(0,0,TeamSelectController);
if !instance_exists(KillLog) instance_create(0,0,KillLog);

sound_stop_all();

if(global.ingameMusic) {
    AudioControlPlaySong(global.IngameMusic, true);
}
instance_create(map_width()/2,map_height()/2,Spectator);

global.redCaps = 0;
global.blueCaps = 0;
global.winners = -1;

if(instance_exists(GameServer))
{
    if(!GameServer.hostSeenMOTD and !global.dedicatedMode and global.welcomeMessage != "")
    {
        with(NoticeO)
            instance_destroy();
        with(instance_create(0, 0, NoticeO))
        {
            notice = NOTICE_CUSTOM;
            message = global.welcomeMessage;
        }
        GameServer.hostSeenMOTD = true;
    }
}
