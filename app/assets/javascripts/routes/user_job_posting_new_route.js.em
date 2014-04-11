class PickwickApp.UserJobPostingNewRoute extends Em.Route

  model: ->
    if @controllerFor('application').user && @controllerFor('application').user.id
      new_model = PickwickApp.JobPosting.create({})
      new_model.set_defaults_for_new()
      return new_model
    else
      @transitionTo('user_job_postings')
