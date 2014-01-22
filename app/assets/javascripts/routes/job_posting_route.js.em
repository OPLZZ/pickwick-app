class PickwickApp.JobPostingRoute extends Em.Route

  actions:
    setLikeDislike: ->
      if localStorage["liked_jobs"] == undefined
        liked_jobs    = {}
      else
        liked_jobs    = JSON.parse(localStorage["liked_jobs"])

      if @get('context').is_liked == true
        @get('context').is_liked = false

        # delete data from local Storage
        if localStorage["liked_jobs"] != undefined
          delete liked_jobs[@get('context').id]
          console.log(@get('context').id)

      else
        @get('context').is_liked = true
        # add job posting to local Storage
        liked_jobs[@get('context').id] = @get('context')

      localStorage["liked_jobs"]    = JSON.stringify(liked_jobs)
