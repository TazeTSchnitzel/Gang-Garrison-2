#!/usr/bin/env node

var path = require('path');
var spawn = require('child_process').spawn;
require('shelljs/global');

// Let's get down to business

echo('Building GML parser...');

cd(__dirname);

// Create empty output directory
rm('-rf', 'out');
mkdir('out');

// Grab the path to Jison's command-line tool
var jisonBin = path.resolve(require.resolve('jison/package.json'), '..', require('jison/package.json').bin.jison);

// Build the parser
spawn(process.argv[0], [jisonBin, 'src/parser.jison', '-o', 'out/parser.js'], {stdio: ['ignore', 1, 2]}).on('exit', function(code, signal) {
    if(code) throw code;

    // Copy js source to output
    cp('src/*.js', 'out');

    echo('Done!');
});
