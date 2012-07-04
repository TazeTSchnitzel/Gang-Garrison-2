if (!global.mapchanging)
{
    TeamSelectController.done = true;
    if !instance_exists(ClassSelectController)
        instance_create(0,0,ClassSelectController);
    else
        ClassSelectController.done = true;
}
else
    ClassSelectController.done = true;

