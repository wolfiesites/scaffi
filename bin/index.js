#! /usr/bin/env node

// add scaffi to command
const shell = require('shelljs');
const args = process.argv.slice(2);
const command = __dirname+'/../scaffi.sh ' + args + ' 2> /dev/null'
shell.exec(command)