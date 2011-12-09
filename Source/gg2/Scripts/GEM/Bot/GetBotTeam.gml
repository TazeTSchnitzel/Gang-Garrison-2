// argument0=the bot object

if 1//global.botMode == 0 or global.botMode == 3// Mixed vs Mixed
{
    if calculateTeamBalance() == TEAM_RED
    {
        team = TEAM_BLUE
    }
    else if calculateTeamBalance() == TEAM_BLUE
    {
        team = TEAM_RED
    }
    else
    {
        team = choose(TEAM_RED, TEAM_BLUE)
    }
}
else// Human vs Bots
{
    team = global.botChosenTeam
}

return team;
