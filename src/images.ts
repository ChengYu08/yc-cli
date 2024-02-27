import sharp from 'sharp';
import fs from 'fs-extra';
import prompts from 'prompts';
import { resolve } from './utils/index.ts';
import { successLog } from './utils/log.ts';

enum ImageType {
    JPEG = 'jpeg',
    PNG = 'png',
    WebP = 'webp',
    GIF = 'gif',
    AVIF = 'avif',
    TIFF = 'tiff',
}

// 转换一张图片
/**
 * inputPath  输入图片路径
 * outputPath 输出图片路径
 * format 转换后的格式
 * quality 压缩质量
 */
function transformOneImage(inputPath, outputPath, format) {
    // 创建Sharp实例并指定输入图片路径
    const image = sharp(inputPath);
    // 设置压缩参数（这里将图像质量降低到70%）
    const compressOptions = { quality: 100 };
    // 调用resize()函数进行尺寸调整或者其他操作
    image[format](compressOptions).toFile(outputPath, (err, info) => {
        if (err) throw err;
        successLog(`成功压缩图片！新图片保存为 ${outputPath}`);
    });
}

async function main() {
    // const currentDirectory = process.cwd();
    // const files = fs.readdirSync(currentDirectory);

    const { inputDir } = await prompts({
        type: 'text',
        name: 'inputDir',
        message: '请输入需要转换的文件名字',
        description: 'Please Enter The Name Of The File To Be Converted',
        initial: 'images',
    });

    const { outputDir } = await prompts({
        type: 'text',
        name: 'outputDir',
        message: '请输入需要转换后文件夹',
        description: 'Please Enter The Folder To Be Converted',
        initial: 'outImages',
    });

    // 该模块支持读取 JPEG、PNG、WebP、GIF、AVIF、TIFF 和 SVG 图像。
    // 输出图像可以是 JPEG、PNG、WebP、GIF、AVIF 和 TIFF 格式以及未压缩的原始像素数据。
    const { toFormat } = await prompts({
        type: 'select',
        name: 'toFormat',
        message: '请输入需要转换后格式',
        description: 'Please enter the format to be converted',
        initial: 0,
        choices: [
            {
                title: ImageType.JPEG,
                value: ImageType.JPEG,
                description:
                    'The module supports reading JPEG, PNG, WebP, GIF, AVIF, TIFF and SVG images.',
            },
            {
                title: ImageType.PNG,
                value: ImageType.PNG,
                description:
                    'The module supports reading JPEG, PNG, WebP, GIF, AVIF, TIFF and SVG images.',
            },
            {
                title: ImageType.GIF,
                value: ImageType.GIF,
                description:
                    'The module supports reading JPEG, PNG, WebP, GIF, AVIF, TIFF and SVG images.',
            },
            {
                title: ImageType.WebP,
                value: ImageType.WebP,
                description:
                    'The module supports reading JPEG, PNG, WebP, GIF, AVIF, TIFF and SVG images.',
            },
            {
                title: ImageType.AVIF,
                value: ImageType.AVIF,
                description:
                    'The module supports reading JPEG, PNG, WebP, GIF, AVIF, TIFF and SVG images.',
            },
            {
                title: ImageType.TIFF,
                value: ImageType.TIFF,
                description:
                    'The module supports reading JPEG, PNG, WebP, GIF, AVIF, TIFF and SVG images.',
            },
        ],
    });
    const targetDirectory = resolve(inputDir);
    const targetOutDirectory = resolve(outputDir);
    // 判断输入的名字 是否是真是的文件夹
    if (!fs.existsSync(targetDirectory)) {
        console.log('文件夹不存在');
        process.exit(1);
    }
    // 如果不存在就创建文件夹
    if (!fs.existsSync(targetOutDirectory)) {
        fs.mkdirSync(targetOutDirectory);
    }

    const inputImages = fs.readdirSync(targetDirectory);
    inputImages.forEach((file) => {
        const [name, ext] = file.split('.');
        transformOneImage(
            resolve(`${inputDir}/${file}`),
            `${targetOutDirectory}/${name}.${toFormat}`,
            toFormat,
        );
    });
}

export default {
    main,
};
