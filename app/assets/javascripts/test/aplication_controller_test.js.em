SMTest = {}
module "Application Controller tests",
  setup: ->
    Ember.run ->
      SMTest.controller = PickwickApp.__container__.lookup('controller:application')

test "visit detail", ->
  Ember.run ->
    SMTest.data = {
      "id": "a2825637f486dde50c01fa32e8836cbdf65011bb",
      "distance": 2.21561335479989,
      "score": 0.49951947,
      "title": "nákupčí, správce skladu, expedient",
      "description": "Interiérové studio hledá na HPP pracovníka na pozici NÁKUPČÍ, SPRÁVCE SKLADU, EXPEDIENT. Požadujeme SŠ, AJ aktivně slovem i písmem, znalost práce na PC, ŘP \"B\", Nabízíme zajímavou práci, finanční ohodnocení podle výkonů, profesní životopis zašlete na kariera@orsei.cz\n\n",
      "industry": null,
      "responsibilities": null,
      "number_of_positions": null,
      "employment_type": "full-time",
      "remote": false,
      "location": {
          "street": "Jankovcova 1345/61",
          "city": "Praha",
          "region": null,
          "zip": "170 00",
          "country": "Czech Republic",
          "coordinates": {
              "lat": 50.1101389,
              "lon": 14.4483912
          }
      },
      "experience": null,
      "employer": {
          "name": null,
          "company": "Ateliér Orsei s.r.o."
      },
      "publisher": null,
      "contact": {
          "email": "kariera @orsei.cz",
          "name": "Irena SCHWARZOVÁ",
          "phone": "+420 284 821 412"
      },
      "compensation": null,
      "start_date": "2014-05-01T00:00:00Z",
      "expiration_date": "2014-04-09T18:00:01Z",
      "created_at": "2014-03-10T18:00:01Z",
      "updated_at": "2014-03-10T18:00:27Z"
    }
    SMTest.job_posting_route = PickwickApp.__container__.lookup('route:job_posting')
    SMTest.job_posting_route.get_job_posting_from_url = (id)->
      @load_job_posting(SMTest.data)
    SMTest.job_posting_route.model(1)
    loaded_object = SMTest.job_posting_route.model(1)
    equal loaded_object.title, SMTest.data.title
    equal loaded_object.id, SMTest.data.id
    ok true

test "currentPathDidChange -> info", ->
  Ember.run ->
    SMTest.controller.currentPath = "job_postings.info"
  equal SMTest.controller.infoVisible,   true
  #ok $(".ember-application").hasClass('push-info')

test "currentPathDidChange -> index", ->
  SMTest.controller.currentPath = "job_postings.index"
  equal SMTest.controller.detailVisible, false
  equal SMTest.controller.infoVisible,   false
  equal SMTest.controller.menuVisible,   false
  equal SMTest.controller.likedVisible,  false
  #ok !$(".ember-application").hasClass('push-detail')
  #ok !$(".ember-application").hasClass('push-liked')
  #ok !$(".ember-application").hasClass('push-menu')
  #ok !$(".ember-application").hasClass('push-info')

test "currentPathDidChange -> detail", ->
  SMTest.controller.currentPath = "job_postings.job_posting"
  equal SMTest.controller.detailVisible, true
  equal SMTest.controller.menuVisible,   false
  equal SMTest.controller.likedVisible,  false
  #ok $(".ember-application").hasClass('push-detail')

test "currentPathDidChange -> liked", ->
  SMTest.controller.currentPath = "job_postings.liked"
  equal SMTest.controller.detailVisible, false
  equal SMTest.controller.likedVisible,  true
  #ok $(".ember-application").hasClass('push-liked')

test "currentPathDidChange -> search", ->
  SMTest.controller.currentPath = "job_postings.search"
  equal SMTest.controller.menuVisible,   true
  #ok $(".ember-application").hasClass('push-menu')