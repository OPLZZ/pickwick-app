class PickwickApp.IndexRoute extends Ember.Route
  redirect: ->
    @transitionTo "job_postings.index"