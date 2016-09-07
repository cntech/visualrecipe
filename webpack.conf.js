var path = require('path')
var htmlRepairLoader = require.resolve('./loaders/html-repair-loader')
module.exports = {
  entry: './src/riot-app.js',
  output: {
    path: __dirname + '/public',
    filename: 'bundle.js'
  },
  resolve: {
    extensions: ['', '.webpack.js', '.web.js', '.ts', '.js', '.tag'],
    root: [
      path.resolve('./src')
    ]
  },
  module: {
    loaders: [
      {
        test: /\.tag$/,
        loader: htmlRepairLoader + '!html!riotjs?type=typescript'
      },
      {
        test: /\.ts$/,
        loader: 'ts'
      },
      {
        test: /\.svg$/,
        loader: 'url?mimetype=image/svg+xml'
      }
    ]
  },
  devServer: {
    contentBase: './public'
  }
}
