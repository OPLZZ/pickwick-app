class PickwickApp.ApplicationRoute extends Ember.Route
  remembered_scroll: 0
  events:
#    goToJobPosting: (job_posting) ->
#      @remembered_scroll = $('.infinite-scroll-box').scrollTop()
#      @transitionTo "job_posting", job_posting

    backToJobPostings: ->
      @transitionTo "job_postings.index"

      remembered_scroll = @remembered_scroll
      setTimeout (->
        $('.infinite-scroll-box').scrollTo(remembered_scroll, 0)
      ), 100

    toggleMenu: ->
      @controller.toggleProperty "menuVisible"
      @controller.pushBody()

    showMenu: ->
      @controller.set "menuVisible", true
      @controller.pushBody()

    hideMenu: ->
      @controller.set "menuVisible", false
      @controller.pushBody()

    goToJobPostingsFromMenu: ->
      @send "toggleMenu"
      @transitionTo "job_postings.index"
