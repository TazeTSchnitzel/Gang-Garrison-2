// string gsCompile(string filename)
// Compiles a GarrisonScript file to GML
// Return value is GML code

var filename;
filename = argument0;

var content, fp;
content = '';
fp = file_text_open_read(filename);

while (!file_text_eof(fp))
{
    content += file_text_read_string(fp);
    content += chr(13) + chr(10); // CRLF
    file_text_readln(fp); // despite the name, this just advances to next line
}

var tokens;
tokens = gsTokenise(content, filename);

// TODO: Implement parsing
show_error("Parsing not implemented yet.", true);
