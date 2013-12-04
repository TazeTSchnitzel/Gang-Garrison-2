Gang Garrison 2 GML Interpreter
===

Code originally based off of [angl](https://github.com/gg2-angl/angl).

Introduction
------------

This is a GML (Game Maker Language) interpreter intended to run in the browser and written in JavaScript. It requires `node.js` to compile the parser.

The dialect of GML as understood by this interpreter is mostly based on the help file, except where the actual Game Maker 8.0 runtime's behaviour is different. For example, while semicolons at the ends of statements are said to be required by the GM 8.0 manual, they are not in the dialect of GML understood by this interpreter, as they are not actually required by the Game Maker 8.0 runtime.

It uses Jison for parsing and it's written in TypeScript.

Setup
---

1. Install node.js

2. Run `npm install` to install the dependencies for compiling the parser.

3. Run `npm install -g jison` (prefixing with `sudo` if necessitated by your system) to install Jison globally (also needed to compile parser)

4. Run `npm install -g typescript` (prefixing with `sudo` if necessitated by your system) to install TypeScript globally (needed to compile interpeter)

5. Run `build.js` in the `parser` directory to compile the parser.

6. Run `ts main.ts` in the `interpreter` directory to compile the interpreter.
