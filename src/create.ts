import prompts from 'prompts';

import fs from 'fs-extra';
import { capitalizeFirstLetter, replaceFileExtension, toCamelCase } from './utils/index.ts';
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
    const targetFileName = path.basename(outPath);
    const outComPath =
        targetFileName.indexOf('index') == -1
            ? outPath.replace(targetFileName, `${renderConst['pageName']}_${targetFileName}`)
            : outPath;
    fs.writeFileSync(outComPath, result, 'utf8');
    successLog(`${renderConst['name']}页面 ${path.basename(outComPath)} 创建成功 ${outComPath}`);
    return result;
}

async function main() {
    try {
        const pageSrc = resolve('./lib/pages');
        const { pageName } = await prompts({
            type: 'text',
            name: 'pageName',
            message: '请输入页面的名字(下划线 首字母字母小写 如 management_tasks)',
            description: 'Please enter the name of the page',
            validate: (ipt) => (ipt.trim().length == 0 ? '页面的名字不为空' : true),
        });
        if (!fs.existsSync(pageSrc)) {
            fs.ensureDirSync(pageSrc);
        }
        const cameName = toCamelCase(pageName);
        const fileName = capitalizeFirstLetter(cameName);
        const name = capitalizeFirstLetter(pageName);
        renderTemplate(
            path.resolve(__dirname, './template/dart_page_template'),
            resolve(`${pageSrc}/${pageName.toLocaleLowerCase()}`),
            {
                name,
                pageName,
                fileName,
            },
        );
        fs.writeFileSync(
            resolve(`${pageSrc}/index.text`),
            `export './${pageName}/index.dart';`,
            'utf8',
        );

        // 路由生成
        fs.writeFileSync(
            resolve(`./lib/router/name.text`),
            `static const ${cameName} = '/${pageName}';`,
            'utf8',
        );

        fs.writeFileSync(
            resolve(`./lib/router/pages.text`),
            `
         CustomRoute(
          path: "/${cameName}Page",
          page: ${fileName}Page.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        ),
        `,
            'utf8',
        );

        // fs.writeFileSync(
        //     resolve(`./lib/routers/navigator.text`),
        //     `
        // static void toGo${fileName}() {
        //     Get.toNamed(RouteNames.${cameName});
        // }
        // `,
        //     'utf8',
        // );
    } catch (error) {}
}

export default {
    main,
};
