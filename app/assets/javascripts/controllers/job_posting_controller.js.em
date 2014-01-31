class PickwickApp.JobPostingController extends Ember.ObjectController
  needs: ["likedJobs"]
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


    setLike: ->
      job_posting = @get('content')
      liked_jobs = @controllers.likedJobs
      liked_jobs.addItem(job_posting)
      #let ember know that function is found and called
      return false

    setDislike: ->
      job_posting = @get('content')
      liked_jobs = @controllers.likedJobs
      liked_jobs.removeItem('id', job_posting.id)
      #let ember know that function is found and called
      return false

