path = require('path')
root = path.join __dirname, '..'


module.exports =
  root:           root
  node_modules:   path.join root, 'node_modules'
  public:         path.join root, 'public'
  graphql:        path.join root, 'graphql'
  server:         path.join root, 'server'
  models:         path.join root, 'models'
  web:            path.join root, 'web'

  app:            path.join root, 'web', 'app'
  styles:         path.join root, 'web', 'styles'
  stores:         path.join root, 'web', 'stores'
  components:     path.join root, 'web', 'components'
  containers:     path.join root, 'web', 'containers'
  entry:
    js:          path.join root, 'web', 'entry', 'index.js'
    html:         path.join root, 'web', 'entry', 'index.html'

  builds:
    dev:          path.join root, 'build'
    prod:         path.join root, 'dist'
