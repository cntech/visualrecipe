var path = require('path')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var typescriptDeclarationInjectingLoader = require.resolve('./loaders/typescript-declaration-injecting-loader')
var htmlRepairLoader = require.resolve('./loaders/html-repair-loader')
var sourcePaths = [
  '',
  'lib/',
  'lib/database/implemented/browser/'
]
var riotTypescriptOptions = encodeURIComponent(JSON.stringify({
  strictNullChecks: true,
  baseUrl: './src',
  paths: {
    '*': sourcePaths.map(function(sourcePath) { return sourcePath + '*' })
  }
}))
module.exports = {
  entry: './src/riot-app.js',
  output: {
    path: __dirname + '/public',
    filename: 'bundle.js'
  },
  resolve: {
    extensions: ['', '.webpack.js', '.web.js', '.ts', '.js', '.tag'],
    root: sourcePaths.map(function(sourcePath) { return path.resolve('./src/' + sourcePath) })
  },
  module: {
    loaders: [
      {
        test: /\.tag$/,
        loader: htmlRepairLoader + '!html!riotjs?typescript='+riotTypescriptOptions+'!' + typescriptDeclarationInjectingLoader + '?src=src/app.d.ts'
      },
      {
        test: /\.ts$/,
        loader: 'ts'
      },
      {
        test: /\.svg$/,
        loader: 'url?mimetype=image/svg+xml&limit=1'
      },
      {
        test: /\.less$/,
        loader: ExtractTextPlugin.extract('style-loader', 'css-loader!less-loader')
      }
    ]
  },
  plugins: [
    new ExtractTextPlugin('bundle.css')
  ],
  devtool: 'source-map',
  devServer: {
    contentBase: './public',
    historyApiFallback: true
  }
}
