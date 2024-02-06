import {execa} from 'execa';



async function pngToWebp()  {
    const currentDirectory = process.cwd();
        await execa('npx', ['webp-batch-convert','-I','images','-O','images_webp']);
    console.log()
    console.log(
        chalk.red(
            'The script specified as BROWSER environment variable failed.'
        )
    )
}


export default  {
    'pngToWebp': pngToWebp,
}