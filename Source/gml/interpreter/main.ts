module interpreter {
    declare var parser: any;
    
    export class Scope {
        constants;
        // "global." vars
        globals = {};
        // "self" in this scope
        instance = null;
        // "var" variables
        locals = {};
        // "globalvar" variables (used as a set, globals used for actual lookup)
        localGlobals = {};

        constructor(constants) {
            // Constants (including resources)
            this.constants = constants || {};
        }

        resolveIdentifier(expression) {
            if (this.constants.hasOwnProperty(expression.name)) {
                return this.constants[expression.name];
            } else if (this.localGlobals.hasOwnProperty(expression.name)) {
                return this.globals[expression.name];
            } else if (this.locals.hasOwnProperty(expression.name)) {
                return this.locals[expression.name];
            } else if (this.instance && this.instance.hasOwnProperty(expression.name)) {
                return this.instance[expression.name];
            } else {
                throw new Error("No such variable in current scope: " + expression.name);
            }
        }

        resolveGlobalIdentifier(expression) {
            if (this.globals.hasOwnProperty(expression.name)) {
                return this.globals[expression.name];
            } else {
                throw new Error("No such global variable in current scope: " + expression.name);
            }
        }
    }
    
    // functions
    export class GMLFunction {
        name: string;
        constructor(name: string) {
            this.name = name;
        }
        call(scope, args) {
            console.log("LOL NOT IMPLEMENTED; FUNCTION CALL FOR " + this.name);
            return 0;
        }
    }

    // inherits from GMLFunction; non-user-defined function
    export class GMLEngineFunction extends GMLFunction {
        constructor(name: string, implementation: (Scope, Array) => any) {
            super(name);
            this.call = implementation;
        }
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

    function evaluate(expression, scope) {
        switch (expression.type) {
            case 'number':
                return expression.val;
            break;
            case 'identifier':
                return scope.resolveIdentifier(expression);
            break;
            case 'global_identifier':
                return scope.resolveGlobalIdentifier(expression);
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

    export function run(code) {
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
    }
}
