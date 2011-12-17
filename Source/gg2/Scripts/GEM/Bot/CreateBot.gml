// Creates a bot by sending a registration to the server;
// argument0=team, argument1=class;


var name, socket, team, class;

name = "TB "+string(irandom(99999999))
socket = tcp_connect('localhost', global.hostingPort)

ds_map_add(global.botNameSocketMap, name, socket)

write_ubyte(socket, HELLO);
write_buffer(socket, global.protocolUuid);

write_ubyte(socket, PLAYER_JOIN);
name = string_copy(name, 0, min(string_length(name), MAX_PLAYERNAME_LENGTH));
write_ubyte(socket, string_length(name));
write_string(socket, name);

team = argument0
write_ubyte(socket, PLAYER_CHANGETEAM);
write_ubyte(socket, team);

class = argument1
write_ubyte(socket, PLAYER_CHANGECLASS);
write_ubyte(socket, class);

socket_send(socket)
