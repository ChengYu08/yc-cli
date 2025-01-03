import * as esbuild from 'esbuild';

await esbuild.build({
    entryPoints: ['src/index.ts'],
    bundle: true,
    outfile: 'out.cjs',
    format: 'cjs',
    platform: 'node',
    target: 'node14',
});
