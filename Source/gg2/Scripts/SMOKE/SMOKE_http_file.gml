// argument0 - host e.g. "smoke.ajf.me"
// argument1 - resource e.g. "/api/test"
// argument2 - filename e.g. "test.html"
// argument3 - show status while downloading

var buf, str;
buf = SMOKE_http(argument0, argument1, argument3);
if (buf != -1) {
    write_buffer_to_file(buf, argument2);
    buffer_destroy(buf);
    return true;
}else{
    return false;
}
