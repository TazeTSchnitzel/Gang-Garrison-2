// argument0 - host e.g. "smoke.ajf.me"
// argument1 - resource e.g. "/api/test"
// argument2 - show status while downloading

var buf, str;
buf = SMOKE_http(argument0, argument1, argument2);
if (buf != -1) {
    str = read_string(buf, buffer_size(buf));
    buffer_destroy(buf);
    return str;
}else{
    return "";
}
