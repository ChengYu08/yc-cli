import prompts from 'prompts';

import fs from 'fs-extra';
import { capitalizeFirstLetter, replaceFileExtension } from './utils/index.ts';
import { resolve } from './utils/index.ts';
import path from 'node:path';
import handlebars from 'handlebars';
import { successLog } from './utils/log.ts';

async function renderTemplate(src, dest, renderConst) {
    const stats = fs.statSync(src);

    if (stats.isDirectory()) {
        // if it's a directory, render its subdirectories and files recursively
        fs.mkdirSync(dest, { recursive: true });
        for (const file of fs.readdirSync(src)) {
            renderTemplate(path.resolve(src, file), path.resolve(dest, file), renderConst);
        }
        return;
    }

    const existing = fs.readFileSync(src, 'utf8');
    const template = handlebars.compile(existing);

    const result = template(renderConst);
    const outPath = replaceFileExtension(dest, '.dart');
    fs.writeFileSync(outPath, result, 'utf8');
    successLog(`${renderConst['name']} 页面 ${path.basename(outPath)} 创建成功 ${outPath}`);
    return result;
}

async function main() {
    const pageSrc = resolve('./lib/pages');
    const { pageName } = await prompts({
        type: 'text',
        name: 'pageName',
        message: '请输入页面的名字',
        description: 'Please enter the name of the page',
        validate: (ipt) => (ipt.trim().length == 0 ? '页面的名字不为空' : true),
    });
    if (!fs.existsSync(pageSrc)) {
        fs.ensureDirSync(pageSrc);
    }
    renderTemplate(
        path.resolve(__dirname, './template/dart_page_template'),
        resolve(`${pageSrc}/${pageName.toLocaleLowerCase()}`),
        {
            name: capitalizeFirstLetter(pageName),
        },
    );
}

export default {
    main,
};
