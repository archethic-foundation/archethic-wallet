const path = require('path')

const _resolve = {
    extensions: ['.js'],
    modules: [
        path.resolve(__dirname, 'node_modules'),
        'node_modules'
    ]
}


module.exports = [
    {
        devtool: 'source-map',
        entry: [
            path.resolve(__dirname, 'src', 'content', 'inpage.js'),
            path.resolve(__dirname, 'src', 'content', 'content.js')
        ],
        output: {
            // build to the extension src vendor directory
            path: path.resolve(__dirname, 'build'),
            filename: path.join('content', 'content.js')
        },
        resolve: _resolve
    }
]
