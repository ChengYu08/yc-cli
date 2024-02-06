#!/usr/bin/env node

const { Command } = require('commander');
const program = new Command();
const inquirer = require('inquirer')

program
    .name('yucheng')
    .description('余成的个人cli 啦啦啦啦')
    .version('0.0.1')
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
                        // "checked": true,
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
        ]).then(answers => {
            // 打印互用输入结果
            console.log(answers)
            console.log(__dirname);
            switch (answers.name) {
                case "create":
                    console.log("创建前端项目");
                    break;
                case "transpile":
                    console.log("将当前目录下的png转成webp");
                    break;
                case "lang":
                    console.log("将excel转成json语言包");
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