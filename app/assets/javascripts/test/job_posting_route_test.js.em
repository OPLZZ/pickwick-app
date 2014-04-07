JPCTest = {}
module "Job Posting Route tests",
  setup: ->
    Ember.run ->
      JPCTest.route = PickwickApp.__container__.lookup('route:job_posting')

    JPCTest.data = {
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
    JPCTest.route.get_job_posting_from_url = (id)->
      @load_job_posting(JPCTest.data)

test "get job posting", ->
  object = JPCTest.route.get_job_posting_from_url(1)
  equal object.title, JPCTest.data.title

test "load job posting", ->
  object = JPCTest.route.load_job_posting(JPCTest.data)
  equal object.title, JPCTest.data.title
