/** @format */

import { $ } from 'execa';

async function pngToWebp() {
    console.log();
    await $`npx webp-batch-convert -I images -O images_webp`;
    console.log();
}

async function main() {
    pngToWebp();
}

export default {
    pngToWebp,
    main,
};
