// void gsError(string filename, real line, real column, string message)
// Show error message

var filename, column, line, message;
filename = argument0;
line = argument1;
column = argument2;
message = argument3;

show_error("Error when compiling " + filename
    + " on line " + string(line) + " at position " + string(column) + ":"
    + chr(13) + chr(10) + message, true);
