# for more details see: http://emberjs.com/guides/models/defining-models/

class PickwickApp.JobPosting extends Ember.Object
  is_liked: false
  employer: Ember.Object.create({})
  location: Ember.Object.create({})
  contact:  Ember.Object.create({})
  compensation:  Ember.Object.create({})

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
  ).property('description, title')

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
  ).property('compensation,compensation.currency')

  compensation_type_translated: ( ->
    if @compensation && @compensation.type && @compensation_type_translation[@compensation.type]
      @compensation_type_translation[@compensation.type]
    else if @compensation && @compensation.type
      @compensation.type
    else
      ""
  ).property('compensation,compensation.currency')


  compensation_text: ( ->
    out = ""
    console.log(@compensation)
    if @compensation && @compensation.value
      out += "#{@compensation.value}"
    else if @compensation && @compensation.min_value && @compensation.max_value
      out += "#{@compensation.min_value}-#{@compensation.max_value}"
    else if @compensation && @compensation.min_value
      out += "#{@compensation.min_value}"
    else if @compensation && @compensation.max_value
      out += "#{@compensation.max_value}"

    if out.length > 0
      out += " #{@compensation_currency_translated}" if @compensation_currency_translated.length > 1
      out += " #{@compensation_type_translated}"     if @compensation_type_translated.length > 1
      out
    else
      ""
  ).property('compensation,compensation.value,compensation.type,compensation.currency')

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