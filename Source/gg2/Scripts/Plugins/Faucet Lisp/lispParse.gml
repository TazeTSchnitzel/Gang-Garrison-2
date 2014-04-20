// real lispParse(string input)
// Parses a Faucet Lisp s-expression string (input) and returns result as a ds_list

var input;
input = argument0;

var tokens;
tokens = lispTokenise(input);

var result;
result = lispParseTokens(tokens);

ds_list_destroy(tokens);

show_message(input + "##became:##" + lispUnparse(result));
lispDestroy(result);
