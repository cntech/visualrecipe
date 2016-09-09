var path = require('path')
var typescriptDeclarationInjectingLoader = require.resolve('./loaders/typescript-declaration-injecting-loader')
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
        loader: htmlRepairLoader + '!html!riotjs?type=typescript!' + typescriptDeclarationInjectingLoader + '?src=src/app.d.ts'
      },
      {
        test: /\.ts$/,
        loader: 'ts'
      },
      {
        test: /\.svg$/,
        loader: 'url?mimetype=image/svg+xml&limit=1'
      }
    ]
  },
  devtool: 'source-map',
  devServer: {
    contentBase: './public'
  }
}
