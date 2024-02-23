#!/usr/bin/env node

import { Command } from "commander";
import inquirer from "inquirer";
import transpile from "../lib/png_to_webp.js";
import lang from "../lib/lang.js";
import csdn from "../lib/csdn.js"


// const gradient = require('gradient-string');

import gradient from "gradient-string";

console.log(gradient([ 
    {color: '#42d392', pos: 0},
    {color: '#42d392', pos: 0.1},
    {color: '#647eff', pos: 1 }
])('yc cli - Individual Efficiency Scaffolding'));

const program = new Command();


// 版本
program.version("0.0.2", '-v, --version', '@calmer/terminal-cli 当前版本')



// import cliSpinners from "cli-spinners";

// 获取当前工作目录
// const currentDirectory = process.cwd();

// // 获取执行脚手架命令的目录
// const commandDirectory = path.dirname(process.argv[1]);
// console.log('脚手架命令的目录:', commandDirectory);

program
    .name('yucheng')
    .description('余成的个人cli 啦啦啦啦')
    .action(() => {
        console.log('欢迎使用余成的个人cli');
        inquirer.prompt([
            {
                type: 'rawlist', //type： input, number, confirm, list, checkbox ... 
                name: 'name', // key 名
                message: '请选择你要使用的功能', // 提示信息
                default: 'yucheng', // 默认值
                choices: [
                    {
                        "name": "创建前端项目",
                        "value": "create",
                        "short": "create",
                    },
                    {
                        "name": "刷博客访问量",
                        "value": "csdn",
                        "short": "csdn",
                    },
                    {
                        "name": "将当前目录下的png转成webp",
                        "value": "transpile",
                        "short": "transpile",
                    },
                    {
                        "name": "将excel转成json语言包",
                        "value": "lang",
                        "short": "lang",
                    },
                ],
            },
        ]).then(async answers => {
            // 打印互用输入结果
            console.log(answers)
            switch (answers.name) {
                case "create":
                    console.log("创建前端项目");
                    break;
                case "transpile":
                    console.log("将当前目录下的png转成webp");
                    transpile.pngToWebp();
                    break;
                case "lang":
                    console.log("将excel转成json语言包");
                    lang.exportLangToJson();
                    break;
                case "csdn":
                    const answer = await inquirer.prompt([
                        {
                            type: 'input',
                            name: 'name',
                            message: '输入csdn博客名字',
                            default: 'weixin_43575775',
                        },
                    ]);
                    console.log(`刷博客访问量 博客名字 ${answer.name}`);
                    csdn.reptile(answer.name);
                    break;
                default:
                    break;
            }
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