#= require jquery
#= require jquery_ujs
#= require handlebars
#= require ember
#= require ember-data
#= require vendor/autogrow.textarea
#= require vendor/ember-geolocation
#= require vendor/scroll-to
#= require vendor/ember-animated-outlet
#= require vendor/ember-touch
#= require vendor/ember-fastclick
#= require vendor/infinite-scroll
#= require_self
#= require pickwick_app


# for more details see: http://emberjs.com/guides/application/
window.PickwickApp = Ember.Application.create(
  rootElement: '#application'
)

$(document).ready ->
  unless navigator.userAgent.match(/Android|BlackBerry|iPhone|iPad|iPod|Opera Mini|IEMobile/i)
    $('body').addClass('desktop')

PickwickApp.normalizeTouchEvent = (event) ->
  if (!event.touches)
    event.touches = event.originalEvent.touches
  if (!event.pageX)
      event.pageX = event.originalEvent.pageX
  if (!event.pageY)
      event.pageY = event.originalEvent.pageY
  return event

