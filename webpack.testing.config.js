var path = require('path')
var glob = require('glob')
var tsconfigFile = 'testing.tsconfig.json'
module.exports = {
  entry: glob.sync('./src/**/*.spec.ts'),
  output: {
    path: __dirname + '/test',
    filename: 'test.js'
  },
  resolve: {
    extensions: ['', '.webpack.js', '.web.js', '.ts', '.js'],
    root: [
      path.resolve('./src')
    ]
  },
  module: {
    loaders: [
      {
        test: /\.ts$/,
        loader: 'ts?configFileName=' + tsconfigFile
      }
    ]
  },
  devtool: 'source-map'
}
