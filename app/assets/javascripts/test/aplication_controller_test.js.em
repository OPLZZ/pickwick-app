This = {}
module "Application controller tests",
  setup: ->
    Ember.run PickwickApp, PickwickApp.advanceReadiness
    This.controller = PickwickApp.__container__.lookup('controller:application')

  teardown: ->
    PickwickApp.reset()


test "visit search", ->
  visit("/job_postings/search").then ->
    ok This.controller.menuVisible

test "visit info", ->
  visit("/job_postings/info").then ->
    ok This.controller.infoVisible

test "visit detail", ->
  visit("/job_postings/123").then ->
    ok This.controller.detailVisible

test "currentPathDidChange -> index", ->
  This.controller.currentPath = "job_postings.index"
  equal This.controller.detailVisible, false
  equal This.controller.infoVisible,   false
  equal This.controller.menuVisible,   false
  equal This.controller.likedVisible,  false
  ok !$(".ember-application").hasClass('push-detail')
  ok !$(".ember-application").hasClass('push-liked')
  ok !$(".ember-application").hasClass('push-menu')
  ok !$(".ember-application").hasClass('push-info')

test "currentPathDidChange -> detail", ->
  This.controller.currentPath = "job_postings.job_posting"
  equal This.controller.detailVisible, true
  equal This.controller.infoVisible,   false
  equal This.controller.menuVisible,   false
  equal This.controller.likedVisible,  false
  ok $(".ember-application").hasClass('push-detail')

test "currentPathDidChange -> liked", ->
  This.controller.currentPath = "job_postings.liked"
  equal This.controller.detailVisible, false
  equal This.controller.infoVisible,   false
  equal This.controller.menuVisible,   false
  equal This.controller.likedVisible,  true
  ok $(".ember-application").hasClass('push-liked')

test "currentPathDidChange -> search", ->
  This.controller.currentPath = "job_postings.search"
  equal This.controller.detailVisible, false
  equal This.controller.infoVisible,   false
  equal This.controller.menuVisible,   true
  equal This.controller.likedVisible,  false
  ok $(".ember-application").hasClass('push-menu')

test "currentPathDidChange -> info", ->
  This.controller.currentPath = "job_postings.info"
  equal This.controller.detailVisible, false
  equal This.controller.infoVisible,   true
  equal This.controller.menuVisible,   false
  equal This.controller.likedVisible,  false
  ok $(".ember-application").hasClass('push-info')
