path = require('path')
root = path.join __dirname, '..'


module.exports =
  root:           root
  node_modules:   path.join root, 'node_modules'
  src:            path.join root, 'src'
  app:            path.join root, 'src', 'app'
  styles:         path.join root, 'src', 'styles'
  stores:         path.join root, 'src', 'stores'
  components:     path.join root, 'src', 'components'
  containers:     path.join root, 'src', 'containers'
  server:         path.join root, 'server'
  public:         path.join root, 'public'
  entry:
    dev:          path.join root, 'src', 'entry', 'dev.js'
    html:         path.join root, 'src', 'entry', 'index.html'
  builds:
    dev:          path.join root, 'build'
    prod:         path.join root, 'dist'