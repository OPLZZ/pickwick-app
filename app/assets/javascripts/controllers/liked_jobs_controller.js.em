class PickwickApp.LikedJobsController extends Ember.ArrayController
  needs: ["jobPostings", "application"]
  liked_jobs: Em.A([])
  init: ->
    if localStorage["liked_jobs"] != undefined
      try
        job_postings = JSON.parse(localStorage["liked_jobs"]).map (job_data)-> PickwickApp.JobPosting.create(job_data)
        for job in job_postings
          @addItem(job)
        @notifyJobPostingController
      catch error
        console.log("Not loaded any liked jobs - no existing cache")

  hasItem: (propName, value) ->
    try
      return @liked_jobs.findProperty(propName, value)
    catch error
      console.log(error)
      return undefined

  addItem: (item) ->
    item.set('is_liked', true)
    this_controller = @
    Ember.run ->
      this_controller.liked_jobs.pushObject item
    @storeToLocalStorage()

  removeItem: (propName, value) ->
    item = @hasItem(propName, value)
    if item != undefined
      item.set('is_liked', false)
      this_controller = @
      Ember.run ->
        this_controller.liked_jobs.removeObject item
      @storeToLocalStorage()
      #if there are no liked jobs
      if @liked_jobs.length == 0 && @controllers.application.get('likedVisible')
        @controllers.application.send('goToIndex')
      return true
    else
      console.log("Liked job: #{propName} -> #{value} not removed")
      return false

  storeToLocalStorage: ->
    localStorage["liked_jobs"] = JSON.stringify(@liked_jobs)
    @notifyJobPostingController()

  notifyJobPostingController: ->
    this_controller = @

    Ember.run ->
      this_controller.controllers.jobPostings.set('hasLikedJobs', this_controller.liked_jobs.length > 0)