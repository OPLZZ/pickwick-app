# for more details see: http://emberjs.com/guides/models/defining-models/

class PickwickApp.JobPosting extends Ember.Object
  is_liked: false
  translation: {
    "full-time": 'plný úvazek'
    "part-time": 'poloviční úvazek'
  }

  detail_link:( ->
    "job_postings/#{@id}"
  ).property('id')

  description_with_brs:( ->
    $.trim(@description).replace("\n", "<br /><br />")
  ).property('description')

  description_preferencies:( ->
    des = $.trim("#{@description} #{@title}").replace(/<(?:.|\n)*?>/gm, '');
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
    if @translation[@employment_type]
      @translation[@employment_type]
    else
      @employment_type

  ).property('employment_type')

  distance_text:( ->
    if @distance
      " ... #{Math.round(@distance)} km"
    else
      " "
  ).property('distance')


  start_date_show:( ->
    if @start_date
      moment(@start_date).format("D. M. YYYY")
    else
      ""
  ).property('start_date')