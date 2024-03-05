import path from 'node:path';

// 解析路径
function resolve(p) {
    const currentDirectory = process.cwd();
    return path.resolve(currentDirectory, p);
}

// 首字母大写

function capitalizeFirstLetter(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
}

// 替换文件的后缀
function replaceFileExtension(path, newExtension) {
    return path.replace(/\..+$/, newExtension);
}

// 将字符串改为 驼峰
function toCamelCase(input) {
    let words = input.split('_');
    let result = '';

    for (let i = 0; i < words.length; i++) {
        if (i === 0) {
            result += words[i];
        } else {
            result += words[i][0].toUpperCase() + words[i].substring(1);
        }
    }

    return result;
}

export default {
    resolve,
    capitalizeFirstLetter,
    replaceFileExtension,
    toCamelCase,
};

export { resolve, capitalizeFirstLetter, replaceFileExtension, toCamelCase };
