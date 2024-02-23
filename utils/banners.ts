const defaultBanner = 'Yu Cheng Cli - Individual Efficiency Scaffolding'

import gradient from 'gradient-string'
const gradientBanner = gradient([
    { color: '#42d392', pos: 0 },
    { color: '#42d392', pos: 0.1 },
    { color: '#647eff', pos: 1 }
])(defaultBanner)

export { defaultBanner, gradientBanner }
