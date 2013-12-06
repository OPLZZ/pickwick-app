class PickwickApp.ApplicationRoute extends Ember.Route
  events:
    goToJobPosting: (job_posting) ->
      @transitionToAnimated "job_posting", {posts: "slideLeft"}, job_posting

    backToJobPostings: ->
      @transitionToAnimated "job_postings.index",
        posts: "slideRight"


    toggleMenu: ->
      @controller.toggleProperty "menuVisible"
      @controller.pushBody()

    goToJobPostingsFromMenu: ->
      @send "toggleMenu"
      @transitionTo "job_postings.index"
