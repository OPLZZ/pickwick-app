class PickwickApp.JobPostingController extends Ember.ObjectController

  actions:
    callPhone: ->
      url = "tel:#{@get('content.contact_phone')}"
      console.log(url)
      window.open(url, '_self')

    sendMail: ->
      url = "mailto:#{@get('content.contact_email')}"
      console.log(url)
      window.open(url, '_self')

    forwardJob: ->

      body = "#{@get('content.title')}\n"

      if @get('content.employer_company')
        body += "#{@get('content.employer_company')}\n"
      else
        if @get('content.employer_name')
          body += "#{@get('content.employer_name')}\n"
      if @get('content.url')
        body += "#{@get('content.url')} \n"

      body += "#{@get('content.location_city')} #{@get('content.location_street')}\n"

      if @get('content.compensation')
        body += "#{@get('content.compensation')} \n"

      if @get('content.contact_name')
        body += "#{@get('content.contact_name')}\n"
      if @get('content.contact_phone')
        body += "#{@get('content.contact_phone')}\n"
      if @get('content.contact_email')
        body += "#{@get('content.contact_email')}\n"

      body += "\n\n-------\n"
      body += @get('content.description')

      subject = "Dáme práci: #{@get('content.title')}"
      url = "mailto:?subject=#{encodeURIComponent(subject)}&body=#{encodeURIComponent(body)}"
      console.log(url)
      window.open(url, '_self')

    showMap: ->
      url = "map:#{@get('content.location_coordinates_lat')},#{@get('content.location_coordinates_lon')}"
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
        @controllerFor('job_postings').set('hasLikedJobs', false)
        @controllerFor('job_postings').send('back_from_liked')
        @controllerFor('job_postings').set "likedVisible", false

