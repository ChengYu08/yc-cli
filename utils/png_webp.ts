import { $ } from 'execa'

async function pngToWebp() {
    console.log()
    await $`npx webp-batch-convert -I images -O images_webp`
    console.log()
}

export default {
    pngToWebp: pngToWebp
}
