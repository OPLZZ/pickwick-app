class PickwickApp.UserJobPostingController extends Ember.ObjectController
  needs: ["application"]
  actions:
    destroy: ->
      app_controller = @controllers.application
      content = @get('content')
      bootbox.dialog({
        title: "Chcete opravdu smazat inzerát: #{@get('content.title')} ?"
        message: "Pracovní nabídka: #{@get('content.title')}"
        buttons: {
          close: {
            label: "zrušit",
            className: "btn-default pull-left"
          },
          success: {
            label: "smazat",
            className: "btn-danger"
            callback: (out)->
              console.log(content)
              app_controller.send('removeUserJobPosting', content)
          }
        }
      })