#!/usr/bin/env node

import prompts from 'prompts'
import { log } from './utils/log.js'
import * as banners from './utils/banners'

import transpile from './utils/png_webp.js'
import lang from './utils/lang.js'
import csdn from './utils/csdn.js'

enum selectType {
    create,
    csdn,
    transpile,
    lang
}

// 选择功能类型
async function chooseType() {
    const { type } = await prompts([
        {
            type: 'select',
            name: 'type',
            message: '请选择你要使用的功能',
            description: 'Please select the function you want to use',
            choices: [
                {
                    title: '创建前端项目',
                    description: 'Creating a front-end project',
                    value: selectType.create
                },
                {
                    title: '刷csdn博客访问量',
                    description: 'Brush csdn blog visits',
                    value: selectType.csdn
                },
                {
                    title: '将当前目录下的png转成webp',
                    description: 'Convert png in current directory to webp',
                    value: selectType.transpile
                },
                {
                    title: '将excel转成json语言包',
                    description: 'Convert excel to json language package',
                    value: selectType.lang
                }
            ],
            initial: 0
        }
    ])
    return type
}

async function init() {
    // 打印log
    console.log()
    console.log(
        process.stdout.isTTY && process.stdout.getColorDepth() > 8
            ? banners.gradientBanner
            : banners.defaultBanner
    )
    console.log()

    // 当前node的目录
    const cwd = process.cwd()

    log(`Current working directory: ${cwd}`)

    const args = process.argv.slice(2)

    try {
        const type = await chooseType()
        switch (type) {
            case selectType.create:
                break
            case selectType.csdn:
                const { name } = await prompts({
                    type: 'text',
                    name: 'name',
                    message: '请输入csdn博客名字',
                    description: 'Please enter csdn blog name',
                    initial: 'weixin_43575775'
                })
                csdn.reptile(name)
                break
            case selectType.lang:
                lang.exportLangToJson()
                break
            case selectType.transpile:
                transpile.pngToWebp()
                break
        }

        console.log('type', type) // => { value: 24 }
    } catch (cancelled) {
        console.log(cancelled.message)
        process.exit(1)
    }
}

init()
