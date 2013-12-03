window.interpreter = (function (exports) {
    'use strict';

    // constructor for scopes
    function Scope(constants) {
        // Constants (including resources)
        this.constants = constants || {};
        // "global." vars
        this.globals = {};
        // "self" in this scope
        this.instance = {};
        // "var" variables
        this.locals = {};
        // "globalvar" variables (used as a set, globals used for actual lookup)
        this.localGlobals = {}
    }
    
    // constructor for functions
    function GMLFunction(name) {
        this.name = name;
        return;
    }
    GMLFunction.prototype.call = function (scope, args) {
        console.log("LOL NOT IMPLEMENTED; FUNCTION CALL FOR " + this.name);
        return 0;
    };

    // inherits from GMLFunction; non-user-defined function
    function GMLEngineFunction(name, implementation) {
        var obj = Object.create(new GMLFunction(name));
        obj.constructor = GMLEngineFunction;
        obj.call = implementation;
        return obj;
    }

    // functions
    function functionCall(statement, scope) {
        var func;
        func = evaluate(statement.expr, scope);
        if (!(func instanceof GMLFunction)) {
            throw new Error("Tried to call non-function as function");
        }
        return func.call(scope, statement.args.map(function (arg) {
            return evaluate(arg, scope);
        }));
    }

    function resolveIdentifier(expression, scope) {
        if (scope.constants.hasOwnProperty(expression.name)) {
            return scope.constants[expression.name];
        } else if (scope.localGlobals.hasOwnProperty(expression.name)) {
            return scope.globals[expression.name];
        } else if (scope.locals.hasOwnProperty(expression.name)) {
            return scope.locals[expression.name];
        } else if (scope.instance && scope.instance.hasOwnProperty(expression.name)) {
            return scope.instance[expression.name];
        } else {
            throw new Error("No such variable in current scope: " + expression.name);
        }
    }

    function resolveGlobalIdentifier(expression, scope) {
        if (scope.globals.hasOwnProperty(expression.name)) {
            return scope.globals[expression.name];
        } else {
            throw new Error("No such global variable in current scope: " + expression.name);
        }
    }

    function evaluate(expression, scope) {
        switch (expression.type) {
            case 'number':
                return expression.val;
            break;
            case 'identifier':
                return resolveIdentifier(expression, scope);
            break;
            case 'global_identifier':
                return resolveGlobalIdentifier(expression, scope);
            break;
            case 'funccall':
                return functionCall(expression, scope);
            break;
            default:
                throw new Error("Unsupported expression type: " + expression.type);
            break;
        }
    }

    function interpret(statement, scope) {
        switch (statement.type) {
            case 'statements':
                statement.list.forEach(function (statement) {
                    interpret(statement, scope);
                });
            break;
            case 'statement':
                try {
                    interpret(statement.statement, scope);
                } catch (e) {
                    throw new Error("Error in line " + statement.location.first_line + ": " + e);
                }
            break;
            case 'funccall':
                functionCall(statement, scope);
            break;
            case 'var':
                statement.list.forEach(function (variable) {
                    if (variable.type !== 'var_item') {
                        throw new Error("Non-var_item inside var statement");
                    }
                    if (variable.hasOwnProperty('expr')) {
                        scope.locals[variable.name] = evaluate(variable.expr, scope);
                    } else {
                        scope.locals[variable.name] = undefined;
                    }
                });
            break;
            default:
                throw new Error("Unsupported statement type: " + statement.type);
            break;
        }
    }

    exports.run = function (code) {
        var parsed;
        parsed = parser.parse(code);

        console.log(JSON.stringify(parsed, undefined, 4));

        interpret(parsed, new Scope({
            string: new GMLEngineFunction("string", function (scope, args) {
                if (args.length !== 1) {
                    throw new Error("string() takes 1 argument");
                }
                return args[0].toString();
            }),
            show_message: new GMLEngineFunction("show_message", function (scope, args) {
                if (args.length !== 1) {
                    throw new Error("show_message() takes 1 argument");
                }
                if (typeof args[0] !== 'string') {
                    throw new Error("show_message() takes a string argument");
                }
                alert(args[0]);
                return 0;
            })
        }));
    };

    return exports;
}(window.interpreter || {}));
