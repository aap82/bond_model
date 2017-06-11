import mobx, {extras,extendObservable, observable, computed, runInAction, action, toJS} from 'mobx'
import {onSnapshot, applySnapshot,getSnapshot,onAction} from 'mobx-state-tree'
class History
  @snapshots = null
  @actions = null
  constructor: (view) ->
    @view = view
    extendObservable @, {
      history: observable.shallowArray()
      currentFrame: 0
      savedFrame: 0
      canUndo: computed(-> @currentFrame > 0)
      canRedo: computed(-> @currentFrame < @history.length - 1)
      canSave: computed(-> @currentFrame isnt @savedFrame and @currentFrame > -1)

    }

  saveSnapshot: (snapshot) ->
    @history.splice(@currentFrame+1) if @currentFrame < @history.length - 1
    @history.push(snapshot)
    @currentFrame++
    @snapshots()

  listenSnapshots: ->
    @history[@currentFrame] = getSnapshot(@view)
    @snapshots = onSnapshot(@view, (snapshot) =>
      @saveSnapshot(snapshot)

    )

  start: ->
    @actions = onAction(@view, (action) =>
      return unless action.name in ['undo', 'redo', 'edit']
      switch action.name
        when 'undo' then @undo()
        when 'redo' then @redo()
        when 'edit' then @listenSnapshots()
    )
  stop: -> @actions()

  undo: ->
    return unless @canUndo
    @currentFrame--
    applySnapshot(@view, @history[@currentFrame])

  redo: ->
    return unless @canRedo
    @currentFrame++
    applySnapshot(@view, @history[@currentFrame])


export default History