path = require('path')
paths = require '../config/paths.coffee'

module.exports =
  context: paths.src
  resolve:
    alias:
      app: paths.src + '/'
      stores: paths.stores + '/'
      styles: paths.styles + '/'
      components: paths.components + '/'
      components: paths.containers + '/'
    modules: [
      "node_modules",
      "#{path.src}"
    ]
    extensions: [
      '.js'
      '.json'
      '.jsx'
      '.coffee'
      '.css'
      '.scss'
    ]
  module:
    rules: [
      { test: /\.(png|woff|woff2|eot|ttf|svg)$/,  loader: ['url-loader'] }
    ]



