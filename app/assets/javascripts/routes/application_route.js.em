class PickwickApp.ApplicationRoute extends Ember.Route
  remembered_scroll: 0
  events:
    goToJobPosting: (job_posting) ->
      @remembered_scroll = $('.infinite-scroll-box').scrollTop()
      @transitionToAnimated "job_posting", {job_postings: "slideLeft"}, job_posting

    backToJobPostings: ->
      @transitionToAnimated "job_postings.index", job_postings: "slideRight"

      remembered_scroll = @remembered_scroll
      setTimeout (->
        $('.infinite-scroll-box').scrollTo(remembered_scroll, 0)
      ), 100

    toggleMenu: ->
      @controller.toggleProperty "menuVisible"
      @controller.pushBody()

    goToJobPostingsFromMenu: ->
      @send "toggleMenu"
      @transitionTo "job_postings.index"
