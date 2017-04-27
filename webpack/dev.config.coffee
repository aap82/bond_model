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
DEV_SERVER_URL = 'http://' + DEV_SERVER_HOST + ':' + DEV_SERVER_PORT



devConfig =
  entry:
    app: [
      "react-hot-loader/patch"
      "webpack-dev-server/client?#{DEV_SERVER_URL}"
      'webpack/hot/only-dev-server'
      "#{paths.entry.dev}"
    ]
    vendor: [
      'react'
      'react-dom'
      'mobx'
      'mobx-react'
      'teact'
    ]

  output:
    filename: '[name].js'
    path: paths.builds.dev
    publicPath: '/'

  devtool: 'inline-source-map'

  devServer:
    hot: yes
    host: "#{DEV_SERVER_HOST}"
    contentBase: paths.builds.dev
    port: DEV_SERVER_PORT
    inline: yes
    noInfo: no
    publicPath: '/'
    quiet: no
    filename: 'bundle.js'

  module:
    rules: [
      { test: /\.coffee$/, use: [ 'babel-loader', 'coffee-loader' ], exclude: /node_modules/ ,include: paths.src }
      { test: /\.(js|jsx)$/, loader: ['happypack/loader?id=js'], exclude: /node_modules/ , include: paths.src},
      { test: /\.(css|scss)$/, use: ['style-loader','css-loader', 'sass-loader'] }
    ]
  plugins: [
    new webpack.DefinePlugin({'process.env.NODE_ENV': JSON.stringify('development')})
    new CleanWebpackPlugin(['build'], {
      root: paths.root
      verbose: true,
      dry: false,
    })
    new HappyPack({
      id: 'js'
      loaders: [ 'babel-loader' ],
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