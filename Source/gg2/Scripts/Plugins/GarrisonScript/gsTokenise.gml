// ds_queue gsTokenise(string text, string filename)
// Tokenises a GarrisonScript source file
// Return value is a ds_queue of token strings
// Tokens prefixed based on type:
// "#" - number
// "$" - string
// "!" - boolean
// "@" - keyword
// "." - identifier
// "^" - operator
// Prefix followed by content, e.g. "0x10" tokenises to "#16"

var content, filename;
text = argument0;
filename = argument1;

var i, len, line, lineStart, HT, CR, LF, tokens;
i = 1;
len = string_length(text);
line = 1;
lineStart = 1;
column = 1;
HT = chr(9); // aka "tab"
CR = chr(13);
LF = chr(10);
tokens = ds_queue_create();

while (i <= len)
{
    var char;
    char = string_char_at(text, i);
    
    switch (char) {
        // comment (skipped)
        case '#':
            while (i <= len)
            {
                char = string_lower(string_char_at(text, i));
                if (char == LF)
                    break;
                i += 1;
            }
        // whitespace (skipped)
        case LF:
            line += 1;
            i += 1;
            lineStart = i;
            continue;
        case ' ':
        case CR:
        case HT:
            i += 1;
            continue;
        
        // numbers
        case '0':
            // "0x" prefix - hexadecimal
            if (i + 1 <= len and string_char_at(text, i + 1) == 'x')
            {
                i += 2;
                if (i > len)
                    gsError(filename, line, 1 + (i - lineStart), "Unexpected end of file in hex literal");
                var digits;
                digits = '';
                while (i <= len)
                {
                    char = string_lower(string_char_at(text, i));
                    if (('0' <= char and char <= '9') or ('a' <= char and char <= 'f'))
                    {
                        digits += char;
                        i += 1;
                    }
                    else
                        break;
                }
                // TODO: Would it be quicker to use string_execute("return $" + digits) here?
                var value, j;
                value = 0;
                for (j = 1; j <= string_length(digits); j += 1)
                {
                    value *= 16;
                    value += string_pos(string_char_at(digits, j), "0123456789abcdef") - 1;
                }
                ds_queue_enqueue(tokens, "#" + string(value));
                continue;
            }
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
            // no prefix: decimal
            var digits;
            digits = char;
            i += 1;
            while (i <= len)
            {
                char = string_char_at(text, i);
                // digits before decimal point
                if (('0' <= char and char <= '9'))
                {
                    digits += char;
                    i += 1;
                }
                else if (char == '.')
                {
                    digits += char;
                    i += 1;
                    // digits after decimal point
                    while (i <= len)
                    {
                        char = string_char_at(text, i);
                        if (('0' <= char and char <= '9'))
                        {
                            digits += char;
                            i += 1;
                        }
                        else
                            break;
                    }
                    break;
                }
                else
                    break;
            }
            ds_queue_enqueue(tokens, "#" + string(real(digits)));
            continue;
        
        // strings
        case '"':
        case "'":
            var delimeter, chars;
            delimeter = char;
            chars = '';
            i += 1;
            
            if (i > len)
                gsError(filename, line, 1 + (i - lineStart), "Unexpected end of file in string literal");
                
            while (i <= len)
            {
                char = string_char_at(text, i);
                if (char == delimeter)
                    break;
                // escape sequence
                else if (char == '\')
                {
                    i += 1;
                    if (i > len)
                        gsError(filename, line, 1 + (i - lineStart), "Unexpected end of file in string literal");
                    char = string_char_at(text, i);
                    switch (char)
                    {
                        case '\':
                        case delimeter:
                            chars += char;
                            break;
                        // newline
                        case 'n':
                            chars += LF;
                            break;
                        // carriage return
                        case 'r':
                            chars += CR;
                            break;
                        // tab
                        case 't':
                            chars += HT;
                            break;
                        // null byte
                        case '0':
                            chars += chr(0);
                            break;
                        default:
                            gsError(filename, line, 1 + (i - lineStart), "Unknown escape sequence: '\" + char + "'");
                    }
                    i += 1;
                    continue;
                }
                else
                {
                    chars += char;
                    i += 1;
                    if (char == LF)
                    {
                        line += 1;
                        lineStart = i;
                    }
                    continue;
                }
            }
            if (i > len and char != delimeter)
                gsError(filename, line, 1 + (i - lineStart), "Unexpected end of file in string literal");
            
            i += 1;
            ds_queue_enqueue(tokens, "$" + chars);
            continue;
        
        default:
            // two-character operators
            // we must detect them before one-character ones
            // otherwise they would be incorrectly tokenised
            if (i + 1 <= len)
            {
                var charPair;
                charPair = string_copy(text, i, 2);
                switch (charPair)
                {
                    case '//':
                    case '<<':
                    case '>>':
                    case '&&':
                    case '||':
                    case '^^':
                    case '==':
                    case '!=':
                    case '<=':
                    case '>=':
                    case ':=':
                    case '+=':
                    case '-=':
                    case '*=':
                    case '/=':
                        i += 2;
                        ds_queue_enqueue(tokens, "^" + charPair);
                        continue;
                }
            }
            
            // one-character operators
            switch (char)
            {
                case '[':
                case ']':
                case '(':
                case ')':
                case ':':
                case '+':
                case '-':
                case '*':
                case '/':
                case '%':
                case '~':
                case '&':
                case '|':
                case '^':
                case '!':
                case '<':
                case '>':
                case '{':
                case '}':
                case ';':
                case '=':
                    i += 1;
                    ds_queue_enqueue(tokens, "^" + char);
                    continue;
            }
            
            // identifiers and keywords
            // starting character can be [a-zA-Z_]
            if (('a' <= char and char <= 'z') or ('A' <= char and char <= 'Z') or char == '_')
            {
                var chars;
                chars = char;
                i += 1;
                while (i <= len)
                {
                    char = string_char_at(text, i);
                    // later characters can be [a-zA-Z0-9_]
                    if (('a' <= char and char <= 'z') or ('A' <= char and char <= 'Z')
                        or ('0' <= char and char <= '9') or char == '_')
                    {
                        chars += char;
                        i += 1;
                    }
                    else
                        break;
                }
                
                // keywords
                switch (chars)
                {
                    case 'true':
                    case 'false':
                    case 'import':
                    case 'let':
                    case 'var':
                    case 'function':
                    case 'if':
                    case 'for':
                    case 'while':
                    case 'do':
                    case 'with':
                    case 'match':
                    case 'case':
                    case 'return':
                        i += 1;
                        ds_queue_enqueue(tokens, "@" + chars);
                        continue;
                }
                
                ds_queue_enqueue(tokens, "." + chars);
                continue;
            }
            
            gsError(filename, line, 1 + (i - lineStart), "Unexpected character: '" + char + "'");
    }
}

return tokens;
