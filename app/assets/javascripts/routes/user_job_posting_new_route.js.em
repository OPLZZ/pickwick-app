class PickwickApp.UserJobPostingNewRoute extends Em.Route
  model: ->
    return PickwickApp.JobPosting.create({})
