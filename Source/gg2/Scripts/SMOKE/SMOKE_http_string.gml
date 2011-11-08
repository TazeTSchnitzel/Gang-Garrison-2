// argument0 - host e.g. "smoke.ajf.me"
// argument1 - resource e.g. "/api/test"
// argument2 - show status while downloading

var sock, file, buf, crlf;
crlf = chr(13)+chr(10);
sock = tcp_connect(argument0, 80);
//sock = tcp_connect("localhost", 5000);

if (socket_connecting(sock) == false) {
    return false;
}

write_string(sock, "GET http://" + argument0 + argument1 + crlf + crlf);
//write_string(sock, "GET " + argument1 + crlf + crlf);
socket_send(sock);

buf = buffer_create()
while (!tcp_eof(sock)) {
    //tcp_receive(sock,1);
    tcp_receive_available(sock);
    write_buffer(buf,sock);
    if (argument2) {
        io_handle();
        draw_set_color(c_black);
        draw_rectangle(view_xview[0], view_hview[0]/2-15, view_wview[0], view_hview[0]/2+15, false);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text(view_wview[0]/2, view_hview[0]/2, "Downloading - " + string(buffer_size(buf)) + "B");
        screen_refresh();
    }
}
return read_string(buf, buffer_size(buf));
