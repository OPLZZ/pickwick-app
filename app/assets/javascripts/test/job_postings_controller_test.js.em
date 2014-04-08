JPsCTest = {}
module "Job Postings Controller tests",
  setup: ->
    Ember.run ->
      JPsCTest.controller = PickwickApp.__container__.lookup('controller:job_postings')
      JPsCTest.controller.replace(0, JPsCTest.controller.length, Em.A([]))
      JPsCTest.controller.similar_jobs.replace(0, JPsCTest.controller.similar_jobs.length, Em.A([]))

test 'has no objects', ->
  equal JPsCTest.controller.length, 0

test 'add item', ->
  equal JPsCTest.controller.length, 0
  JPsCTest.controller.addItem({id: 1})
  equal JPsCTest.controller.length, 1

test 'has item', ->
  equal JPsCTest.controller.length, 0
  JPsCTest.controller.addItem({id: 1})
  equal JPsCTest.controller.length, 1
  ok JPsCTest.controller.hasItem('id', 1), "existing"
  ok !JPsCTest.controller.hasItem('id', 2), "non-existing"

test 'remove item', ->
  equal JPsCTest.controller.length, 0, "before add 0"
  JPsCTest.controller.addItem({id: 1})
  equal JPsCTest.controller.length, 1
  ok JPsCTest.controller.removeItem('id', 1)
  equal JPsCTest.controller.length, 0, "after remove 0"
  ok !JPsCTest.controller.removeItem('id', 3), "Don't remove non-existing"


test 'add similar item', ->
  equal JPsCTest.controller.similar_jobs.length, 0
  JPsCTest.controller.addSimilarItem({id: 1})
  equal JPsCTest.controller.similar_jobs.length, 1

test 'has similar item', ->
  equal JPsCTest.controller.similar_jobs.length, 0
  JPsCTest.controller.addSimilarItem({id: 1})
  equal JPsCTest.controller.similar_jobs.length, 1
  ok JPsCTest.controller.hasSimilarItem('id', 1), "existing"
  ok !JPsCTest.controller.hasSimilarItem('id', 2), "non-existing"

test 'remove similar item', ->
  equal JPsCTest.controller.similar_jobs.length, 0, "before add 0"
  JPsCTest.controller.addSimilarItem({id: 1})
  equal JPsCTest.controller.similar_jobs.length, 1
  ok JPsCTest.controller.removeSimilarItem('id', 1)
  equal JPsCTest.controller.similar_jobs.length, 0, "after remove 0"
  ok !JPsCTest.controller.removeSimilarItem('id', 3), "Don't remove non-existing"
