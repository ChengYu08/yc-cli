/** @format */

import { bold, green, lightBlue } from 'kolorist';

// 日志打印的默认样式
function successLog(str: string) {
    console.log(`  ${bold(green(str))}`);
}

function log(str: string) {
    console.log(`  ${bold(lightBlue(str))}`);
}

export { log, successLog };
