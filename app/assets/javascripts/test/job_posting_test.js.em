This = {}
module "Job Posting tests",
  setup: ->
    This.data = {
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

    This.job_posting = PickwickApp.JobPosting.create(This.data)

test "has valid data", ->
  equal This.job_posting.title, This.data.title, "Should match titles"
  equal This.job_posting.description, This.data.description, "Should match description"
  equal This.job_posting.start_date, This.data.start_date, "Should match start_date"
  equal This.job_posting.contact.name, This.data.contact.name, "Should match contact name"

test "return detail link", ->
  equal This.job_posting.detail_link, "job_postings/#{This.data.id}"

test "return description for HTML", ->
  equal This.job_posting.description_with_brs, $.trim(This.data.description).replace("\n", "<br /><br />")

test "return description_preferencies", ->
  jp = PickwickApp.JobPosting.create({})
  out = jp.description_preferencies
  equal Object.keys(out), 0

  jp = PickwickApp.JobPosting.create({"title": 'fool bar'})
  out = jp.description_preferencies
  valid_out = {"fool": 1}
  equal out.fool, valid_out.fool

  jp = PickwickApp.JobPosting.create({"title": 'foo barl', "description": 'barl'})
  out = jp.description_preferencies
  valid_out = {"barl": 2}
  equal out.fool, valid_out.fool

test "return employment type translated", ->
  equal PickwickApp.JobPosting.create(employment_type: 'full-time').employment_type_translated, 'plný úvazek', "translate full-time"
  equal PickwickApp.JobPosting.create(employment_type: 'part-time').employment_type_translated, 'částečný úvazek', "translate part-time"
  equal PickwickApp.JobPosting.create(employment_type: 'unknown').employment_type_translated, 'unknown', "translate unknown"
  equal PickwickApp.JobPosting.create(employment_type: null).employment_type_translated, '', "translate NULL"

test "return distance", ->
  equal PickwickApp.JobPosting.create(distance: 0).distance_text, '', "0"
  equal PickwickApp.JobPosting.create(distance: null).distance_text, '', "null"
  equal PickwickApp.JobPosting.create(distance: 50).distance_text, ' ... 50 km', "50km"
  equal PickwickApp.JobPosting.create(distance: 150.34).distance_text, ' ... 150 km', "rounded 150km"

test "return start_date", ->
  equal PickwickApp.JobPosting.create(start_date: "2014-05-01T00:00:00Z").start_date_show, '1. 5. 2014', "return date"
  equal PickwickApp.JobPosting.create(start_date: "2014-05-asd").start_date_show, '', "INVALID - return empty text"
  equal PickwickApp.JobPosting.create(start_date: null).start_date_show, '', "NULL - return empty text"
  equal PickwickApp.JobPosting.create(start_date: undefined).start_date_show, '', "Undefined - return empty text"

test "return compensation text", ->
  equal PickwickApp.JobPosting.create().compensation_text, '', "return empty text"
  equal PickwickApp.JobPosting.create(compensation: {value: 100}).compensation_text, '100'
  equal PickwickApp.JobPosting.create(compensation: {min_value: 50}).compensation_text, '50'
  equal PickwickApp.JobPosting.create(compensation: {max_value: 60}).compensation_text, '60'
  equal PickwickApp.JobPosting.create(compensation: {min_value: 40, max_value: 70}).compensation_text, '40-70'
  equal PickwickApp.JobPosting.create(compensation: {min_value: 40, max_value: 70, type: 'annual'}).compensation_text, '40-70 roční'
  equal PickwickApp.JobPosting.create(compensation: {min_value: 40, max_value: 70, currency: 'CZK'}).compensation_text, '40-70 Kč'
  equal PickwickApp.JobPosting.create(compensation: {min_value: 40, max_value: 70, type: 'annual', currency: 'CZK'}).compensation_text, '40-70 Kč roční'

test "return compensation type translated", ->
  equal PickwickApp.JobPosting.create(compensation: {type: 'annual'}).compensation_type_translated, 'roční'
  equal PickwickApp.JobPosting.create(compensation: {type: 'hourly'}).compensation_type_translated, 'hodinová'
  equal PickwickApp.JobPosting.create(compensation: {type: 'fixed'}).compensation_type_translated, 'fixní'
  equal PickwickApp.JobPosting.create(compensation: {type: 'monthly'}).compensation_type_translated, 'měsíční'
  equal PickwickApp.JobPosting.create(compensation: {}).compensation_type_translated, '', "return empty text "
  equal PickwickApp.JobPosting.create().compensation_type_translated, '', "return without compensation empty text"

test "return compensation currency translated", ->
  equal PickwickApp.JobPosting.create(compensation: {currency: 'CZK'}).compensation_currency_translated, 'Kč', "return Kč"
  equal PickwickApp.JobPosting.create(compensation: {currency: 'EUR'}).compensation_currency_translated, '€', "return €"
  equal PickwickApp.JobPosting.create(compensation: {currency: 'PLN'}).compensation_currency_translated, 'PLN', "return unknown PLN"
  equal PickwickApp.JobPosting.create(compensation: {}).compensation_currency_translated, '', "return empty text"
  equal PickwickApp.JobPosting.create().compensation_currency_translated, '', "return without compensation empty text"

test "return is_new", ->
  equal PickwickApp.JobPosting.create(created_at: moment().subtract('days', 3)).is_new, false, "older date"
  equal PickwickApp.JobPosting.create(created_at: moment().subtract('days', 1)).is_new, true, "younger tahn 2 days"
  equal PickwickApp.JobPosting.create(created_at: moment().add('days', 1)).is_new, true, "in future"
