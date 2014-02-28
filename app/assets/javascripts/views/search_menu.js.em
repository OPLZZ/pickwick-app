# for more details see: http://emberjs.com/guides/views/

class PickwickApp.SearchMenuView extends Ember.View
  templateName: 'search_menu'
  swipeOptions:
    direction: Em.OneGestureDirection.Left

  didInsertElement: ->
    $('textarea').autoGrow()

    $('.click_on_textarea').click ->
      console.log("clicked od textarea")
      $(this).find("textarea").focus()

    $('.click_on_query').click ->
      console.log("clicked od query")
      $(this).find('input[type=text]').focus()

    $('.click_on_select').click ->
      console.log("clicked od select")
      $(this).find('select').focus()


  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")

    if direction is Em.OneGestureDirection.Left
      @get("controller").send "hideMenu"
