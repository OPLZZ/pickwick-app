class PickwickApp.JobPostingRoute extends Em.Route

  actions:
    setLikeDislike: ->
      if @get('context').is_liked == true
        @get('context').is_liked = false
      else
        @get('context').is_liked = true
