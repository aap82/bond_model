path = require('path')
paths = require '../config/paths.coffee'

module.exports =
  context: paths.root
  resolve:
    alias:
      stores: paths.stores + '/'
      styles: paths.styles + '/'
      components: paths.components + '/'
      containers: paths.containers + '/'
    modules: [
      "node_modules",
      "#{paths.web}"
      "#{paths.models}"
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



