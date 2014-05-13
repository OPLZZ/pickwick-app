class PickwickApp.Error404Route extends Ember.Route
  redirect: (params)->
    console.log(params)
    bootbox.dialog({
      title: "Chyba 404"
      message: "Neznámá adresa: #{params.path}"
      buttons: {
        close: {
          label: "zavřít upozornění",
          className: "btn-default pull-right"
        }
      }
    })
    @transitionTo('job_postings.index')