# for more details see: http://emberjs.com/guides/views/

class PickwickApp.SearchMenuView extends Ember.View
  templateName: 'search_menu'
  swipeOptions:
    direction: Em.OneGestureDirection.Left
    cancelPeriod: 80
    swipeThreshold: 200

  didInsertElement: ->
    $('textarea').autoGrow()

    if localStorage["search_query"] != undefined
      @controller.controllerFor('application').set('search_query', localStorage["search_query"])
    if localStorage["search_location"] != undefined
      @controller.controllerFor('application').set('search_location', localStorage["search_location"])
    if localStorage["person_about"] != undefined
      @controller.controllerFor('application').set('person_about', localStorage["person_about"])
    if localStorage["person_education"] != undefined
      @controller.controllerFor('application').set('person_education', localStorage["person_education"])

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")

    if direction is Em.OneGestureDirection.Left
      @get("controller").send "hideMenu"
