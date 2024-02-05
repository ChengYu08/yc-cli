#!/usr/bin/env node

const { Command } = require('commander');
const program = new Command();

program
    .name('yc')
    .description('余成的个人cli 啦啦啦啦')
    .version('1.0.0')
    .action(()=>{
        console.log('欢迎使用余成的个人cli');
    });

program.command('split')
    .description('Split a string into substrings and display as an array')
    .argument('<string>', 'string to split')
    .option('--first', 'display just the first substring')
    .option('-s, --separator <char>', 'separator character', ',')
    .action((str, options) => {
        const limit = options.first ? 1 : undefined;
        console.log(str.split(options.separator, limit));
    });

program.parse();