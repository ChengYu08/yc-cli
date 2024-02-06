#!/usr/bin/env node

const { Command } = require('commander');
const program = new Command();
const inquirer = require('inquirer')

program
    .name('yc')
    .description('余成的个人cli 啦啦啦啦')
    .version('1.0.0')
    .action(() => {
        console.log('欢迎使用余成的个人cli');
        inquirer.prompt([
            {
                type: 'list', //type： input, number, confirm, list, checkbox ... 
                name: 'name', // key 名
                message: '第一步', // 提示信息
                default: 'yc-cli', // 默认值
                choices: ["a", "b"],
            },
        ]).then(answers => {
            // 打印互用输入结果
            console.log(answers)

            inquirer.prompt([
                {
                    type: 'list', //type： input, number, confirm, list, checkbox ... 
                    name: 'name', // key 名
                    message: '第二步', // 提示信息
                    default: 'yc-cli', // 默认值
                    choices: ["a", "b"],
                },
            ]).then(answers => {
                // 打印互用输入结果
                console.log(answers)
            })
        })
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