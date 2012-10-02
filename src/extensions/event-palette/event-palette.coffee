{View, $$} = require 'space-pen'
Editor = require 'editor'
$ = require 'jquery'

module.exports =
class EventPalette extends View
  @activate: (rootView) ->
    requireStylesheet 'event-palette/event-palette.css'
    @instance = new EventPalette(rootView)
    rootView.on 'event-palette:show', => @instance.attach()

  @content: ->
    @div class: 'event-palette', =>
      @div class: 'event-list', outlet: 'eventList'
      @subview 'miniEditor', new Editor(mini: true)

  initialize: (@rootView) ->

  attach: ->
    @previouslyFocusedElement = $(':focus')
    @populateEventList()
    @appendTo(@rootView)
    @miniEditor.focus()

  populateEventList: ->
    events = @previouslyFocusedElement.events()
    table = $$ ->
      @table =>
        for [event, description] in events
          @tr =>
            @td event
            @td description if description

    @eventList.html(table)
