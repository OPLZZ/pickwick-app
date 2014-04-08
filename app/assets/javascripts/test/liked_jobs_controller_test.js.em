LJCTest = {}
module "Liked Jobs Controller tests",
  setup: ->
    Ember.run ->
      LJCTest.controller = PickwickApp.__container__.lookup('controller:liked_jobs')
      LJCTest.controller.liked_jobs.replace(0, LJCTest.controller.liked_jobs.length, Em.A([]))

      LJCTest.job_posting = PickwickApp.JobPosting.create({id: 1})

test 'has no objects', ->
  equal LJCTest.controller.liked_jobs.length, 0

test 'add item', ->
  equal LJCTest.controller.liked_jobs.length, 0
  LJCTest.controller.addItem(LJCTest.job_posting)
  equal LJCTest.controller.liked_jobs.length, 1

test 'has item', ->
  equal LJCTest.controller.liked_jobs.length, 0
  LJCTest.controller.addItem(LJCTest.job_posting)
  equal LJCTest.controller.liked_jobs.length, 1
  ok LJCTest.controller.hasItem('id', 1), "existing"
  ok !LJCTest.controller.hasItem('id', 2), "non-existing"

test 'remove item', ->
  equal LJCTest.controller.liked_jobs.length, 0, "before add 0"
  LJCTest.controller.addItem(LJCTest.job_posting)
  equal LJCTest.controller.liked_jobs.length, 1
  ok LJCTest.controller.removeItem('id', 1)
  equal LJCTest.controller.liked_jobs.length, 0, "after remove 0"
  ok !LJCTest.controller.removeItem('id', 3), "Don't remove non-existing"

