if (!global.mapchanging)
{
    ClassSelectController.done = true;
    if !instance_exists(TeamSelectController)
        instance_create(0,0,TeamSelectController);
    else
        TeamSelectController.done = true;
}
else
    TeamSelectController.done = true;
