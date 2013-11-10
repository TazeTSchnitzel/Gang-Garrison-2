var parser = require('./parser').parser,
    fs = require('fs');
parser.yy = {
    // makes number literal structure from decimal token
    makeNumVal: function (yytext) {
        return {
            type: 'number',
            val: Number(yytext)
        };
    },
    // makes number literal structure from hex token
    makeHexVal: function (yytext) {
        // strip leading $
        yytext = yytext.substr(1);
        return {
            type: 'number',
            val: parseInt(yytext, 16) // hexadecimal
        };
    },
    // makes string literal structure from string token
    makeStringVal: function (yytext) {
        // strip leading and trailing quote marks
        yytext = yytext.substr(1, yytext.length - 2);
        return {
            type: 'string',
            val: yytext
        };
    },
    // makes identifier structure
    makeIdentifier: function (yytext) {
        return {
            type: 'identifier',
            name: yytext
        };
    },
    // makes script literal structure
    makeScriptVal: function (args, stmts) {
        return {
            type: 'script',
            args: args,
            stmts: stmts
        };
    },
    // makes script definition structure
    makeScriptStmt: function (name, args, stmts) {
        return {
            type: 'scriptdef',
            name: name,
            args: args,
            stmts: stmts
        };
    },
    // makes const definition structure
    makeConstStmt: function (name, expr) {
        return {
            type: 'const',
            name: name,
            expr: expr
        };
    },
    // makes object statement structure
    makeObjectStmt: function (name, stmts, parent) {
        if (parent) {
            return {
                type: 'object',
                name: name,
                parent: parent,
                stmts: stmts
            };
        } else {
            return {
                type: 'object',
                name: name,
                stmts: stmts
            };
        }
    },
    // makes create script definition structure
    makeCreateStmt: function (args, stmts) {
        return {
            type: 'createdef',
            args: args,
            stmts: stmts
        };
    },
    // makes destroy script definition structure
    makeDestroyStmt: function (stmts) {
        return {
            type: 'destroydef',
            stmts: stmts
        };
    },
    // makes property definition structure
    makePropertyStmt: function (name, expr) {
        return {
            type: 'property',
            name: name,
            expr: expr
        };
    },
    // make binary operator structure
    makeBinaryOp: function (op, expr1, expr2) {
        return {
            type: 'binop',
            op: op,
            expr1: expr1,
            expr2: expr2
        };
    },
    // make unary operator structure
    makeUnaryOp: function (op, expr) {
        return {
            type: 'unop',
            op: op,
            expr: expr
        };
    },
    // make index (a[1,2,3...]) structure
    makeIndex: function (expr, indexes) {
        return {
            type: 'index',
            expr: expr,
            indexes: indexes
        };
    },
    // make function call structure
    makeFunctionCall: function (expr, args) {
        return {
            type: 'funccall',
            expr: expr,
            args: args
        };  
    },
    // make super call structure
    makeSuperCall: function (args) {
        return {
            type: 'super',
            args: args
        };  
    },
    // make statement list structure
    makeStmtList: function (list) {
        return {
            type: 'statements',
            list: list
        };
    },
    // make assignment statment structure
    makeAssignStmt: function (lval, rval) {
        return {
            type: 'assign',
            lval: lval,
            rval: rval
        };
    },
    // make compound assignment statment structure
    makeCmpAssignStmt: function (op, lval, rval) {
        return {
            type: 'cmpassign',
            lval: lval,
            rval: rval,
            op: op
        };
    },
    // makes var statement structure
    makeVarStmt: function (list) {
        return {
            type: 'var',
            list: list
        };
    },
    // makes var statement item structure
    makeVarStmtItem: function (yytext, expr) {
        if (expr) {
            return {
                type: 'var_item',
                name: yytext,
                expr: expr
            };
        } else {
            return {
                type: 'var_item',
                name: yytext
            };
        }
    },
    // makes NOP statement structure (freestanding semicolon)
    makeNopStmt: function () {
        return {
            type: 'nop'
        };
    },
    // makes break statement structure
    makeBreakStmt: function () {
        return {
            type: 'break'
        };
    },
    // makes continue statement structure
    makeContinueStmt: function () {
        return {
            type: 'continue'
        };
    },
    // makes exit statement structure
    makeExitStmt: function () {
        return {
            type: 'exit'
        };
    },
    // makes return statement structure
    makeReturnStmt: function (expr) {
        return {
            type: 'return',
            expr: expr
        };
    },
    // makes if statement structure
    makeIfStmt: function (expr, stmt) {
        return {
            type: 'if',
            expr: expr,
            stmt: stmt
        };
    },
    // makes if-else statement structure
    makeIfElseStmt: function (expr, stmt1, stmt2) {
        return {
            type: 'ifelse',
            expr: expr,
            stmt1: stmt1,
            stmt2: stmt2
        };
    },
    // makes repeat statement structure
    makeRepeatStmt: function (expr, stmt) {
        return {
            type: 'repeat',
            expr: expr,
            stmt: stmt
        };
    },
    // makes while statement structure
    makeWhileStmt: function (expr, stmt) {
        return {
            type: 'while',
            expr: expr,
            stmt: stmt
        };
    },
    // makes do-until statement structure
    makeDoUntilStmt: function (stmt, expr) {
        return {
            type: 'dountil',
            expr: expr,
            stmt: stmt
        };
    },
    // makes for statement structure
    makeForStmt: function (initstmt, contexpr, stepstmt, stmt) {
        return {
            type: 'for',
            initstmt: initstmt,
            contexpr: contexpr,
            stepstmt: stepstmt,
            stmt: stmt
        };
    },
    // makes switch statement structure
    makeSwitchStmt: function (expr, cases) {
        return {
            type: 'switch',
            expr: expr,
            cases: cases
        };
    },
    // makes switch case structure
    makeCase: function (expr, stmts) {
        return {
            type: 'case',
            expr: expr,
            stmts: stmts
        };
    },
    // makes switch default case structure
    makeDefaultCase: function (stmts) {
        return {
            type: 'defaultcase',
            stmts: stmts
        };
    },
    // makes with statement structure
    makeWithStmt: function (expr, stmt) {
        return {
            type: 'with',
            expr: expr,
            stmt: stmt
        };
    }
};

exports.parse = function (input) {
    return parser.parse(input);
};

exports.printAST = function (input) {
    console.log(JSON.stringify(parser.parse(input), null, '  '));
};

// command line
if (require.main === module) {
    if (process.argv.hasOwnProperty('2') && process.argv[2] !== '--help') {
        exports.printAST(fs.readFileSync(process.argv[2]).toString());
    } else {
        console.log('Usage:');
        console.log('   node angl.js FILENAME');
    }
}
