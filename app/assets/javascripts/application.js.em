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
#= require vendor/jquery.inview
#= require_self
#= require pickwick_app


# for more details see: http://emberjs.com/guides/application/
window.PickwickApp = Ember.Application.create(
  rootElement: '#application'
)

$(document).ready ->
  if navigator.userAgent.match(/Android|BlackBerry|iPhone|iPad|iPod|Opera Mini|IEMobile|KFSOWI/i)
    $('body').addClass('not_desktop')
  else
    $('body').addClass('desktop')

  #problem with 20 pixels for bottom bar in safari on IOS
  if (navigator.userAgent.match(/iPad;.*CPU.*OS 7_\d/i))
    $('html').addClass('ipad ios7')
    $('#application_container').css('height', "#{$(window).height() - 21}px !important")

PickwickApp.normalizeTouchEvent = (event) ->
  if (!event.touches)
    event.touches = event.originalEvent.touches
  if (!event.pageX)
      event.pageX = event.originalEvent.pageX
  if (!event.pageY)
      event.pageY = event.originalEvent.pageY
  return event

