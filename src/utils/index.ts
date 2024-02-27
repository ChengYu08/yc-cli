import path from 'node:path';

// 解析路径
function resolve(p) {
    const currentDirectory = process.cwd();
    return path.resolve(currentDirectory, p);
}

export default {
    resolve,
};

export { resolve };
