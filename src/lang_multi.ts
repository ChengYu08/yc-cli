/** @format */

import XLSX from 'xlsx';
import path from 'path';
import fs from 'fs-extra';

function exportLangToJson() {
    const currentDirectory = process.cwd();

    var files = fs.readdirSync(currentDirectory);
    const excelFiles = files.filter(
        (file) => path.extname(file).toLowerCase() === '.xlsx' && !file.includes('~'),
    );
    console.log('当前文件夹下的.xlsx文件:', excelFiles);
    if (excelFiles.length == 0) {
        console.log('没有找到.xlsx文件');
        return;
    }

    excelFiles.forEach((str, idx) => {
        // 默认取第一个
        var data = XLSX.readFile(excelFiles[idx]);
        const Sheet = data.Sheets[Object.keys(data.Sheets)[0]];
        const exportJsonMap = {};
        const keyNumMap = {};
        const langNumMap = {};
        const name = str.split('.')[0];
        Object.keys(Sheet).forEach((key) => {
            if (key.indexOf('!') != -1) {
                return;
            }
            // 是主键 需要创建一个Map
            const value = Sheet[key];
            // 字母
            const s = key.slice(0, 1);
            const v = parseInt(key.slice(1, key.length)) * 1;
            if (s == 'A') {
                keyNumMap[v] = value.w.trim();
            } else {
                if (v == 1) {
                    exportJsonMap[value.w] = {};
                    langNumMap[s] = value.w.trim();
                } else {
                    const lang = langNumMap[s];
                    if (keyNumMap[v]) {
                        exportJsonMap[lang][keyNumMap[v]] = value.w.trim();
                    }
                }
            }
        });
        fs.removeSync(`${currentDirectory}/langs`);
        fs.mkdirSync(`${currentDirectory}/langs`);
        Object.keys(exportJsonMap).forEach((key) => {
            fs.writeFile(`./langs/${key}.arb`, JSON.stringify(exportJsonMap[key], null, 4));
            console.log('文件已经生成', '==>', `./langs/${key}.arb`);
        });
    });
}

async function main() {
    exportLangToJson();
}

export default {
    exportLangToJson,
    main,
};
