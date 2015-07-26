// void test_gsTokenise()
// GarrisonScript tokeniser unit test

test_unit_begin();

var queue;

queue = gsTokenise("
    # comments and whitespace are ignored
", "comment test");
test_assert_equals(true, ds_queue_empty(queue));
ds_queue_destroy(queue);

queue = gsTokenise("0x1a", "hexadecimal test");
test_assert_equals(1, ds_queue_size(queue));
test_assert_equals("#26", ds_queue_head(queue));
ds_queue_destroy(queue);

queue = gsTokenise("123", "decimal test 1");
test_assert_equals(1, ds_queue_size(queue));
test_assert_equals("#123", ds_queue_head(queue));
ds_queue_destroy(queue);

queue = gsTokenise("123.45", "decimal test 2");
test_assert_equals(1, ds_queue_size(queue));
test_assert_equals("#123.45", ds_queue_head(queue));
ds_queue_destroy(queue);

queue = gsTokenise('"\\ \"string\" \r\n \0 \t"', "string test 1");
test_assert_equals(1, ds_queue_size(queue));
test_assert_equals('$\ "string" ' + chr(13) + chr(10) + ' ' + chr(0) + ' ' + chr(9), ds_queue_head(queue));
ds_queue_destroy(queue);

queue = gsTokenise("'\\ \'string\' \r\n \0 \t'", "string test 2");
test_assert_equals(1, ds_queue_size(queue));
test_assert_equals("$\ 'string' " + chr(13) + chr(10) + ' ' + chr(0) + ' ' + chr(9), ds_queue_head(queue));
ds_queue_destroy(queue);

queue = gsTokenise("//<<>>&&||^^==!=<=>=:=+=-=*=/=", "two-character operator test");
test_assert_equals("^//", ds_queue_dequeue(queue));
test_assert_equals("^<<", ds_queue_dequeue(queue));
test_assert_equals("^>>", ds_queue_dequeue(queue));
test_assert_equals("^&&", ds_queue_dequeue(queue));
test_assert_equals("^||", ds_queue_dequeue(queue));
test_assert_equals("^^^", ds_queue_dequeue(queue));
test_assert_equals("^==", ds_queue_dequeue(queue));
test_assert_equals("^!=", ds_queue_dequeue(queue));
test_assert_equals("^<=", ds_queue_dequeue(queue));
test_assert_equals("^>=", ds_queue_dequeue(queue));
test_assert_equals("^:=", ds_queue_dequeue(queue));
test_assert_equals("^+=", ds_queue_dequeue(queue));
test_assert_equals("^-=", ds_queue_dequeue(queue));
test_assert_equals("^*=", ds_queue_dequeue(queue));
test_assert_equals("^/=", ds_queue_dequeue(queue));
test_assert_equals(true, ds_queue_empty(queue));
ds_queue_destroy(queue);

queue = gsTokenise("[]():+-*/%~&|^!<>{};=", "one-character operator test");
test_assert_equals("^[", ds_queue_dequeue(queue));
test_assert_equals("^]", ds_queue_dequeue(queue));
test_assert_equals("^(", ds_queue_dequeue(queue));
test_assert_equals("^)", ds_queue_dequeue(queue));
test_assert_equals("^:", ds_queue_dequeue(queue));
test_assert_equals("^+", ds_queue_dequeue(queue));
test_assert_equals("^-", ds_queue_dequeue(queue));
test_assert_equals("^*", ds_queue_dequeue(queue));
test_assert_equals("^/", ds_queue_dequeue(queue));
test_assert_equals("^%", ds_queue_dequeue(queue));
test_assert_equals("^~", ds_queue_dequeue(queue));
test_assert_equals("^&", ds_queue_dequeue(queue));
test_assert_equals("^|", ds_queue_dequeue(queue));
test_assert_equals("^^", ds_queue_dequeue(queue));
test_assert_equals("^!", ds_queue_dequeue(queue));
test_assert_equals("^<", ds_queue_dequeue(queue));
test_assert_equals("^>", ds_queue_dequeue(queue));
test_assert_equals("^{", ds_queue_dequeue(queue));
test_assert_equals("^}", ds_queue_dequeue(queue));
test_assert_equals("^;", ds_queue_dequeue(queue));
test_assert_equals("^=", ds_queue_dequeue(queue));
test_assert_equals(true, ds_queue_empty(queue));
ds_queue_destroy(queue);

queue = gsTokenise("true false import let var function if for while do with match case return notAKeyWord", "keyword test");
test_assert_equals("@true", ds_queue_dequeue(queue));
test_assert_equals("@false", ds_queue_dequeue(queue));
test_assert_equals("@import", ds_queue_dequeue(queue));
test_assert_equals("@let", ds_queue_dequeue(queue));
test_assert_equals("@var", ds_queue_dequeue(queue));
test_assert_equals("@function", ds_queue_dequeue(queue));
test_assert_equals("@if", ds_queue_dequeue(queue));
test_assert_equals("@for", ds_queue_dequeue(queue));
test_assert_equals("@while", ds_queue_dequeue(queue));
test_assert_equals("@do", ds_queue_dequeue(queue));
test_assert_equals("@with", ds_queue_dequeue(queue));
test_assert_equals("@match", ds_queue_dequeue(queue));
test_assert_equals("@case", ds_queue_dequeue(queue));
test_assert_equals("@return", ds_queue_dequeue(queue));
test_assert_equals(".notAKeyWord", ds_queue_dequeue(queue));
test_assert_equals(true, ds_queue_empty(queue));
ds_queue_destroy(queue);

queue = gsTokenise("_ Ab 0123a a0123 A_123 test", "identifier test");
test_assert_equals("._", ds_queue_dequeue(queue));
test_assert_equals(".Ab", ds_queue_dequeue(queue));
test_assert_equals("#123", ds_queue_dequeue(queue));
test_assert_equals(".a", ds_queue_dequeue(queue));
test_assert_equals(".a0123", ds_queue_dequeue(queue));
test_assert_equals(".A_123", ds_queue_dequeue(queue));
test_assert_equals(".test", ds_queue_dequeue(queue));
test_assert_equals(true, ds_queue_empty(queue));
ds_queue_destroy(queue);

queue = gsTokenise('
# non-recursive
function factorial(real n): real
{
    var product: real = 1;
    while (n > 1)
    {
        product *= n;
        n -= 1;
    }

    return product;
}
', "factorial");
test_assert_equals("@function", ds_queue_dequeue(queue));
test_assert_equals(".factorial", ds_queue_dequeue(queue));
test_assert_equals("^(", ds_queue_dequeue(queue));
test_assert_equals(".real", ds_queue_dequeue(queue));
test_assert_equals(".n", ds_queue_dequeue(queue));
test_assert_equals("^)", ds_queue_dequeue(queue));
test_assert_equals("^:", ds_queue_dequeue(queue));
test_assert_equals(".real", ds_queue_dequeue(queue));
test_assert_equals("^{", ds_queue_dequeue(queue));
test_assert_equals("@var", ds_queue_dequeue(queue));
test_assert_equals(".product", ds_queue_dequeue(queue));
test_assert_equals("^:", ds_queue_dequeue(queue));
test_assert_equals(".real", ds_queue_dequeue(queue));
test_assert_equals("^=", ds_queue_dequeue(queue));
test_assert_equals("#1", ds_queue_dequeue(queue));
test_assert_equals("^;", ds_queue_dequeue(queue));
test_assert_equals("@while", ds_queue_dequeue(queue));
test_assert_equals("^(", ds_queue_dequeue(queue));
test_assert_equals(".n", ds_queue_dequeue(queue));
test_assert_equals("^>", ds_queue_dequeue(queue));
test_assert_equals("#1", ds_queue_dequeue(queue));
test_assert_equals("^)", ds_queue_dequeue(queue));
test_assert_equals("^{", ds_queue_dequeue(queue));
test_assert_equals(".product", ds_queue_dequeue(queue));
test_assert_equals("^*=", ds_queue_dequeue(queue));
test_assert_equals(".n", ds_queue_dequeue(queue));
test_assert_equals("^;", ds_queue_dequeue(queue));
test_assert_equals(".n", ds_queue_dequeue(queue));
test_assert_equals("^-=", ds_queue_dequeue(queue));
test_assert_equals("#1", ds_queue_dequeue(queue));
test_assert_equals("^;", ds_queue_dequeue(queue));
test_assert_equals("^}", ds_queue_dequeue(queue));
test_assert_equals("@return", ds_queue_dequeue(queue));
test_assert_equals(".product", ds_queue_dequeue(queue));
test_assert_equals("^;", ds_queue_dequeue(queue));
test_assert_equals("^}", ds_queue_dequeue(queue));
test_assert_equals(true, ds_queue_empty(queue));
ds_queue_destroy(queue);

test_unit_end();
