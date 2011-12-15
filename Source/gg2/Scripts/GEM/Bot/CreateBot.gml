bot = instance_create(0, 0, BotPlayer)
ds_list_add(global.players, bot)
        
with bot
{
    BotInit()
}

if global.userCreatedBot[0]// User wants a specific bot. Creating it anywhere gives errors for clients. God knows why.
{
    bot.team = global.userCreatedBot[1];
    bot.class = global.userCreatedBot[2];
    global.userCreatedBot[0] = 0
}
else
{
    bot.team = GetBotTeam(bot)
    bot.class = GetBotClass(bot)
}
        
if global.botNamePrefix == ""
{
    bot.name = "Tempest Bot "+string(global.botNameCounter)
}
else
{
    bot.name = global.botNamePrefix+string(global.botNameCounter)
}
global.botNameCounter += 1

bot.alarm[5] = 1

ServerPlayerJoin(bot, global.sendBuffer)
ServerPlayerChangeteam(ds_list_size(global.players)-1, bot.team, global.sendBuffer)
ServerPlayerChangeclass(ds_list_size(global.players)-1, bot.class, global.sendBuffer)

write_ubyte(global.sendBuffer, PLAYER_CHANGENAME);
write_ubyte(global.sendBuffer, ds_list_size(global.players)-1);
write_ubyte(global.sendBuffer, string_length(bot.name));
write_string(global.sendBuffer, bot.name);
