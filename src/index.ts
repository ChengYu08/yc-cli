#!/usr/bin/env node
/** @format */

import prompts from 'prompts';
import { log } from './utils/log.ts';
import * as banners from './utils/banners.ts';

import transpile from './png_webp.ts';
import lang from './lang.ts';
import csdn from './csdn.ts';
import images from './images.ts';

enum selectType {
    create,
    csdn,
    transpile,
    lang,
    images,
}

// 选项配置
const config = [
    {
        title: '图片压缩',
        description: 'Image Compression',
        value: selectType.images,
    },
    {
        title: '创建前端项目',
        description: 'Creating a front-end project',
        value: selectType.create,
    },
    {
        title: '刷csdn博客访问量',
        description: 'Brush csdn blog visits',
        value: selectType.csdn,
    },
    {
        title: '将当前目录下的png转成webp',
        description: 'Convert png in current directory to webp',
        value: selectType.transpile,
    },
    {
        title: '将excel转成json语言包',
        description: 'Convert excel to json language package',
        value: selectType.lang,
    },
];

// 选择功能类型
async function chooseType() {
    const { type } = await prompts([
        {
            type: 'select',
            name: 'type',
            message: '请选择你要使用的功能',
            description: 'Please select the function you want to use',
            choices: config,
            initial: 0,
        },
    ]);
    return type;
}

async function init() {
    // 打印log
    console.log();
    console.log(
        process.stdout.isTTY && process.stdout.getColorDepth() > 8
            ? banners.gradientBanner
            : banners.defaultBanner,
    );
    console.log();

    // 当前node的目录
    const cwd = process.cwd();

    log(`Current working directory: ${cwd}`);

    const args = process.argv.slice(2);

    try {
        const type = await chooseType();
        switch (type) {
            case selectType.create:
                break;
            case selectType.csdn:
                csdn.main();
                break;
            case selectType.lang:
                lang.main();
                break;
            case selectType.transpile:
                transpile.main();
                break;
            case selectType.images:
                images.main();
                break;
        }
        // console.log('type', type); // => { value: 24 }
    } catch (cancelled) {
        console.log(cancelled.message);
        process.exit(1);
    }
}

init();
