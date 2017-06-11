import Handsontable from 'handsontable/dist/handsontable.full'

class SettingsMapper 
  constructor: ->
    @registeredHooks = Handsontable.hooks.getRegistered()


  getSettings: (properties) -> 
    newSettings = {}
  
    if properties.settings 
      settings = properties.settings
      for key in settings
        newSettings[@trimHookPrefix(key)] = settings[key] if settings[key]?
    
    
    for key in properties
      if key isnt 'settings' and properties[key]?
        newSettings[@trimHookPrefix(key)] = properties[key]
    return newSettings



  trimHookPrefix: (prop) ->
    if prop.indexOf('on') is 0
      hookName = prop.charAt(2).toLowerCase() + prop.slice(3, prop.length)
      if (@registeredHooks.indexOf(hookName) > -1)
        return hookName

    return prop



export default SettingsMapper