class PickwickApp.JobPostingController extends Ember.ObjectController

  actions:
    setLikeDislike: ->
      if localStorage["liked_jobs"] == undefined
        liked_jobs    = {}
      else
        liked_jobs    = JSON.parse(localStorage["liked_jobs"])

      job_posting = @get('content')
      if job_posting.get("is_liked") == true
        job_posting.set("is_liked", false)

        # delete data from local Storage
        if localStorage["liked_jobs"] != undefined
          delete liked_jobs[job_posting.id]

      else
        job_posting.set("is_liked", true)
        # add job posting to local Storage
        liked_jobs[job_posting.id] = job_posting

      localStorage["liked_jobs"]    = JSON.stringify(liked_jobs)

      #set hasLikedJobs for know if there are any liked jobs
      if Object.keys(liked_jobs).length > 0
        @controllerFor('job_postings').set('hasLikedJobs', true)
      else
        @controllerFor('job_postings').set('hasLikedJobs', false)
        @controllerFor('job_postings').send('back_from_liked')
        @controllerFor('job_postings').set "likedVisible", false

