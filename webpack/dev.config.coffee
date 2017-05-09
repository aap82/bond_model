require('dotenv').config()
path = require 'path'
getenv = require('getenv')
webpack = require 'webpack'
merge = require 'webpack-merge'
paths = require '../config/paths.coffee'
baseConfig = require './base.config'
CleanWebpackPlugin = require('clean-webpack-plugin')
HappyPack = require('happypack')
HTMLWebpackPlugin = require 'html-webpack-plugin'
DEV_SERVER_HOST = getenv 'DEV_SERVER_HOST'
DEV_SERVER_PORT = getenv 'DEV_SERVER_PORT'

APP_SERVER_HOST = getenv 'SERVER_HOST'
APP_SERVER_PORT = getenv 'SERVER_PORT'
GRAPHQL_ENDPOINT = getenv 'GRAPHQL_ENDPOINT'

DEV_SERVER_URL = 'http://' + DEV_SERVER_HOST + ':' + DEV_SERVER_PORT
APP_SERVER_URL = 'http://' + '0.0.0.0'+ ':' + APP_SERVER_PORT + '/graphql'


devConfig =
  entry:
    app: [
      "react-hot-loader/patch"
      "webpack-dev-server/client?#{DEV_SERVER_URL}"
      'webpack/hot/only-dev-server'
      "#{paths.entry.js}"
    ]
    vendor: [
      'react'
      'react-dom'
      'teact'
    ]

  output:
    filename: '[name].js'
    path: paths.builds.dev.client
    publicPath: '/'

  devtool: 'inline-source-map'

  devServer:
    hot: yes
    host: "#{DEV_SERVER_HOST}"
    contentBase: paths.builds.dev.client
    port: DEV_SERVER_PORT
    inline: yes
    noInfo: no
    publicPath: '/'
    quiet: no
    filename: 'bundle.js'
    proxy:
      '/graphql':
        target: GRAPHQL_ENDPOINT
        changeOrigin: yes
        pathRewrite:
          '^/graphql': ''
    historyApiFallback: yes
  module:
    rules: [
      { test: /\.coffee$/, loader: ['happypack/loader?id=coffee'], exclude: /node_modules/ } # ,include: paths.src }
      { test: /\.(js|jsx)$/, loader: ['happypack/loader?id=js'], exclude: /node_modules/ } #, include: paths.src},
      { test: /\.(css|scss)$/, use: ['style-loader','css-loader', 'sass-loader'] }
    ]
  plugins: [
    new webpack.DefinePlugin({'process.env.NODE_ENV': JSON.stringify('development')})
    new CleanWebpackPlugin(['build/client'], {
      root: paths.root
      verbose: true,
      dry: false,
    })
    new HappyPack({
      id: 'js'
      loaders: [ 'babel-loader' ],
    })
    new HappyPack({
      id: 'coffee'
      loaders: [ 'babel-loader', 'coffee-loader'  ],
    })

    new webpack.HotModuleReplacementPlugin()
    new webpack.NamedModulesPlugin()
    new webpack.NoEmitOnErrorsPlugin()
    new webpack.optimize.OccurrenceOrderPlugin()
    new webpack.optimize.CommonsChunkPlugin({
      name: "vendor"
      filename: "vendors.js"
      minChunks: Infinity
    })
    new HTMLWebpackPlugin {
      template: paths.entry.html

    }

  ]

config = merge(devConfig, baseConfig)
module.exports = config