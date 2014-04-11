# for more details see: http://emberjs.com/guides/models/defining-models/

class PickwickApp.JobPosting extends Ember.Object
  is_liked: false
  employer: Ember.Object.create({})
  location: Ember.Object.create({})
  contact:  Ember.Object.create({})
  compensation:  Ember.Object.create({})
  start_date: null
  phone_regexp: /\+?\d{3}[ -]?\d{3}[ -]?\d{3}[ -]?\d{0,3}/
  email_regexp: /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/

  employment_type_translation: {
    "full-time": 'plný úvazek'
    "part-time": 'částečný úvazek'
  }

  compensation_type_translation: {
    "monthly": 'měsíční'
    "hourly":  'hodinová'
    "annual":  'roční'
    "fixed":   'fixní'
  }

  compensation_currency_translation: {
    'CZK': 'Kč'
    'EUR': '€'
  }

  employer_type_select: [
    {'key': 'company', 'value': 'Firma'},
    {'key': 'private', 'value': 'Soukromá osob'},
  ]

  set_defaults_for_new: ->
    @start_date = moment().format('YYYY-MM-DD')
    app_controller = PickwickApp.__container__.lookup('controller:application')
    @contact.name =  app_controller.user.name
    @employer.type = "private"

  destroy: ->
    app_controller = PickwickApp.__container__.lookup('controller:application')
    url = "#{window.PickwickApp.user_url_point}/users/#{app_controller.user.id}/job_postings/#{@id}"

    this_object = @
    Ember.run ->
      $.ajax(
        method: 'DELETE'
        dataType: 'json'
        contentType: 'application/json'
        url: url
        processData: false
        headers: {
          'Application-Token': window.PickwickApp.user_api_token
          'User-Token': app_controller.user.token
        }
        cache: false
      ).done( (data) ->
        console.log("DELETED: #{this_object.id}")
      ).error (error)->
        console.log("ERROR WITH DELETING")

  save_params: (->
    {
      job_posting: {
        title:           @title
        start_date:      @start_date
        description:     @description
        employment_type: @employment_type
        employer:        @employer
        location:        @location
        contact:         @contact
        compensation:    @compensation
      }
    }
  ).property('title, description, employment_type, employer, location, contact, compensation')

  get_contact_phone: (->
    if @contact && @contact.phone
      phone = @contact.phone.split(",")[0]
      if phone.match(@phone_regexp)
        phone
      else
        null
    else
      null
  ).property('contact, contact.phone')

  update_attributes: (job_posting) ->
    @id = job_posting.id
    @checked = job_posting.checked

  save: ->
    console.log("SAVING")
    this_object = @
    app_controller = PickwickApp.__container__.lookup('controller:application')

    unless app_controller.user
      alert('cant save without sign in')

    if @id
      method = "PATCH"
      url = "#{window.PickwickApp.user_url_point}/users/#{app_controller.user.id}/job_postings/#{@id}"
    else
      method = "POST"
      url = "#{window.PickwickApp.user_url_point}/users/#{app_controller.user.id}/job_postings"
    
    this_object = @

    console.log(JSON.stringify(this_object.save_params))
    Ember.run ->
      $.ajax(
        method: method
        dataType: 'json'
        contentType: 'application/json'
        url: url
        processData: false
        data: JSON.stringify(this_object.save_params)
        headers: { 
          'Application-Token': window.PickwickApp.user_api_token
          'User-Token': app_controller.user.token
        }
        cache: false
      ).done( (data) ->
        this_object.update_attributes(data.job_posting)
      ).error (error)->
        console.log("ERROR WITH SAVING")

  valid_save: ( ->
    @valid_title && @valid_description && @valid_employer && @valid_contact && @valid_location_city
  ).property('valid_title','valid_description', 'valid_employer', 'valid_contact','valid_location_city')

  valid_title:( ->
    if @title && @title.length > 6
      true
    else
      false
  ).property('title')

  valid_description:( ->
    if @description && @description.length > 6
      true
    else
      false
  ).property('description')

  valid_employer:( ->
    if @employer.name && @employer.name.length > 3
      true
    else
      false
  ).property('employer','employer.name')

  valid_contact:( ->
    console.log(@contact.phone)
    if @contact.phone
      console.log(@contact.phone.match(@phone_regexp))
    console.log(@contact.email)
    if @contact.email
      console.log(@contact.email.match(@email_regexp))
    if @contact && ((@contact.phone && @contact.phone.match(@phone_regexp)) || (@contact.email && @contact.email.match(@email_regexp)))
      true
    else
      false
  ).property('contact', 'contact.phone', 'contact.email')

  valid_location_city:( ->
    if @location && @location.city && @location.city.length > 3
      true
    else
      false
  ).property('location','location.city')


  duplicate: ->
    new_job = {}
    new_job.id      = @id
    new_job.title   = @title
    new_job.employment_type = @employment_type
    new_job.description     = @description
    new_job.start_date      = @start_date

    new_job.employer = Ember.Object.create({})
    new_job.employer.type = @employer.type
    new_job.employer.name = @employer.name


    new_job.location = Ember.Object.create({})
    new_job.location.city   = @location.city
    new_job.location.street = @location.street
    new_job.location.zip    = @location.zip

    new_job.contact = Ember.Object.create({})
    new_job.contact.name  = @contact.name
    new_job.contact.phone = @contact.phone
    new_job.contact.email = @contact.email

    new_job.compensation = Ember.Object.create({})
    new_job.compensation.value    = @compensation.value
    new_job.compensation.type     = @compensation.type
    new_job.compensation.currency = @compensation.currency

    PickwickApp.JobPosting.create(new_job)


  #for select box in new/edit form
  employment_type_select:(->
    out = Em.A([])
    for key, value of @employment_type_translation
      out.push({'key': key, 'value': value})
    out
  ).property('employment_type_translation')

  #for select box in new/edit form
  compensation_type_select:(->
    out = Em.A([])
    for key, value of @compensation_type_translation
      out.push({'key': key, 'value': value})
    out
  ).property('compensation_type_translation')

  #for select box in new/edit form
  compensation_currency_select:(->
    out = Em.A([])
    for key, value of @compensation_currency_translation
      out.push({'key': key, 'value': value})
    out
  ).property('compensation_currency_translation')

  #for links in index
  detail_link:( ->
    "job_postings/#{@id}"
  ).property('id')

  description_with_brs:( ->
    $.trim(@description).replace("\n", "<br /><br />")
  ).property('description')

  description_preferencies:( ->
    description = @description
    if description == null || description == 'null' || description == undefined
      description = ""
    title = @title
    if title == null || title == 'null' || title == undefined
      title = ""
    des = $.trim("#{title} #{description}").replace(/<(?:.|\n)*?>/gm, '');
    arr = des.toLowerCase().replace(/[\.,-\/#!$%\^&\*;:{}=\-_`~()]/g,"").split(" ").sort()
    output = {}
    for i in arr
      ii = $.trim(i)
      if ii.length > 3
        output[ii] ||= 0
        output[ii] += 1
    output
  ).property('description', 'title')

  employment_type_translated:( ->
    if @employment_type == null
      ''
    else if @employment_type_translation[@employment_type]
      @employment_type_translation[@employment_type]
    else
      @employment_type

  ).property('employment_type')

  distance_text:( ->
    if @distance
      " ... #{Math.round(@distance)} km"
    else
      ""
  ).property('distance')

  compensation_currency_translated: ( ->
    if @compensation && @compensation.currency && @compensation_currency_translation[@compensation.currency]
      @compensation_currency_translation[@compensation.currency]
    else if @compensation && @compensation.currency
      @compensation.currency
    else
      ""
  ).property('compensation','compensation.currency')

  compensation_type_translated: ( ->
    if @compensation && @compensation.type && @compensation_type_translation[@compensation.type]
      @compensation_type_translation[@compensation.type]
    else if @compensation && @compensation.type
      @compensation.type
    else
      ""
  ).property('compensation','compensation.currency')


  compensation_text: ( ->
    out = ""
    if @compensation && @compensation.value
      out += "#{@compensation.value}"
    else if @compensation && @compensation.min_value && @compensation.max_value
      out += "#{@compensation.min_value}-#{@compensation.max_value}"
    else if @compensation && @compensation.min_value
      out += "#{@compensation.min_value}"
    else if @compensation && @compensation.max_value
      out += "#{@compensation.max_value}"

    if out.length > 0
      out += " #{@compensation_currency_translated}" if @compensation_currency_translated.length > 0
      out += " #{@compensation_type_translated}"     if @compensation_type_translated.length > 0
      out
    else
      ""
  ).property('compensation','compensation.value','compensation.type','compensation.currency')

  start_date_show:( ->
    if @start_date
      formated_date = moment(@start_date).format("D. M. YYYY")
      if formated_date == "Invalid date"
        console.log("Problem with formating date: #{@start_date} -> #{formated_date}")
        return ""
      else
        return formated_date
    else
      ""
  ).property('start_date')

  is_new:( ->
    if @created_at
      moment(@created_at) > moment().subtract('days', 2)
    else
      false
  ).property('created_at')

  checked_text:( ->
    if @checked == "valid"
      "Schváleno administrátorem a zobrazuje se uživatelům ve výsledcích vyhledávání"
    else if @checked == "invalid"
      "Není schváleno administrátorem!"
    else
      "Čeká na schválení administrátora"
  ).property('checked')

  checked_badge_klass: ( ->
    if @checked == "valid"
      "new_badge green"
    else if @checked == "invalid"
      "new_badge red"
    else
      "new_badge gray"
  ).property('checked')

  checked_badge_text: ( ->
    if @checked == "valid"
      "ok"
    else if @checked == "invalid"
      "err"
    else
      "čeká"
  ).property('checked')