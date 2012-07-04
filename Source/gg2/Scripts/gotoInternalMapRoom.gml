// switches to the internal map named in argument0
// returns 0 in success, -1 if the name isn't recognized

{
    switch(argument0) {
        case "ctf_truefort":
            room_goto_fix(Truefort);
            break;
        case "ctf_conflict":
            room_goto_fix(Conflict);
            break;
        case "ctf_classicwell":
            room_goto_fix(ClassicWell);
            break;
        case "ctf_waterway":
            room_goto_fix(Waterway);
            break;
        case "ctf_orange":
            room_goto_fix(Orange);
            break;
        case "ctf_2dfort[0]":
        case "ctf_2dfort1":
        case "ctf_oldfort":
            room_goto_fix(Oldfort);
            break;
        case "ctf_2dfort":
        case "ctf_2dfort2":
        case "ctf_2dfortremix":
            room_goto_fix(TwodFortTwoRemix);
            break;
        default:
            return -1;
            exit;
    }
    return 0;
}
