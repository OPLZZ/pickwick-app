class PickwickApp.ApplicationRoute extends Ember.Route
  events:
    goToJobPosting: (job_posting) ->
      console.log("BAF")
      @transitionToAnimated "job_posting", {job_postings: "slideLeft"}, job_posting

    backToJobPostings: ->
      console.log("LEK")
      @transitionToAnimated "job_postings.index",
        job_postings: "slideRight"


    toggleMenu: ->
      @controller.toggleProperty "menuVisible"
      @controller.pushBody()

    goToJobPostingsFromMenu: ->
      @send "toggleMenu"
      @transitionTo "job_postings.index"
