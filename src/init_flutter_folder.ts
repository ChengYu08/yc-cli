import path from 'node:path';
import fs from 'fs-extra';
import { resolve } from './utils/index.ts';

// 直接将模板复制进项目
function copyFile(createUrl, name) {
    fs.copy(
        path.resolve(__dirname, `./template/common/${name}`),
        path.resolve(createUrl, `./${name}`),
        (err) => {
            if (err) return console.error(err);
            console.log(`${name} create success!`);
        },
    );
}

function main() {
    const pageSrc = resolve('./lib');

    if (!fs.existsSync(pageSrc)) {
        fs.ensureDirSync(pageSrc);
    }
    fs.readdirSync(path.resolve(__dirname, `./template/common`)).forEach((file) => {
        copyFile(pageSrc, `${file}`);
    });

    fs.copy(path.resolve(__dirname, `./template/shell`), path.resolve(`./shell`), (err) => {
        if (err) return console.error(err);
        console.log(`shell create success!`);
    });
}

export default {
    main,
};
