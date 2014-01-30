class PickwickApp.JobPostingController extends Ember.ObjectController

  actions:
    callPhone: ->
      url = "tel:#{@get('content.contact.phone')}"
      console.log(url)
      window.open(url, '_self')

    sendMail: ->
      url = "mailto:#{@get('content.contact.email')}"
      console.log(url)
      window.open(url, '_self')

    forwardJob: ->

      body = "#{@get('content.title')}\n"
      body += "#{@get('content.employment_type_translated')}\n"

      if @get('content.employer.company')
        body += "#{@get('content.employer.company')}\n"
      else
        if @get('content.employer.name')
          body += "#{@get('content.employer.name')}\n"
      if @get('content.url')
        body += "#{@get('content.url')} \n"

      body += "#{@get('content.location.city')} #{@get('content.location.street')}\n"

      if @get('content.compensation')
        body += "#{@get('content.compensation')} \n"

      if @get('content.contact.name')
        body += "#{@get('content.contact.name')}\n"
      if @get('content.contact.phone')
        body += "#{@get('content.contact.phone')}\n"
      if @get('content.contact.email')
        body += "#{@get('content.contact.email')}\n"

      body += "\n\n-------\n"
      body += @get('content.description')

      subject = "Dáme práci: #{@get('content.title')}"
      url = "mailto:?subject=#{encodeURIComponent(subject)}&body=#{encodeURIComponent(body)}"
      console.log(url)
      window.open(url, '_self')

    showMap: ->
      url = "maps:q=#{@get('content.location.coordinates.lat')},#{@get('content.location.coordinates.lon')}"
      console.log(url)
      window.open(url, '_self')



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
      if liked_jobs && Object.keys(liked_jobs).length > 0
        @controllerFor('job_postings').set('hasLikedJobs', true)
      else
        #there are no liked jobs
        @controllerFor('job_postings').set('hasLikedJobs', false)
        @controllerFor('job_postings').set "likedVisible", false

        #if showing liked page redirect back to results
        if @controllerFor('job_postings').get('likedVisible')
          @controllerFor('job_postings').send('back_from_liked')

