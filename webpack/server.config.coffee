require('dotenv').config()
path = require 'path'
getenv = require('getenv')
webpack = require 'webpack'
merge = require 'webpack-merge'
paths = require '../config/paths.coffee'
baseConfig = require './base.config'
devConfig =
  target: 'node'
  entry: "#{paths.entry.server}"
  output:
    libraryTarget:  'commonjs2'
    filename: 'server.js'
    path: paths.builds.dev.server

  devtool: 'none'
  module:
    rules: [
      { test: /\.coffee$/, use: ['babel-loader', 'coffee-loader'], exclude: /node_modules/ } # ,include: paths.src }
      { test: /\.(js|jsx)$/, use: ['babel-loader'], exclude: /node_modules/ } #, include: paths.src},
#      { test: /\.(css|scss)$/, use: ['style-loader','css-loader', 'sass-loader'] }
    ]
  plugins: [
    new webpack.DefinePlugin({'process.env.NODE_ENV': JSON.stringify('development')})
    new webpack.NamedModulesPlugin()
    new webpack.NoEmitOnErrorsPlugin()
    new webpack.optimize.OccurrenceOrderPlugin()

  ]


config = merge(devConfig, baseConfig)
console.log config
module.exports = config