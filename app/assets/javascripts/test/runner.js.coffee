document.write(
  '<div id="qunit"></div>' +
  '<div id="qunit-fixture"></div>' +
  '<div id="ember-testing-container">' +
  '  <div id="ember-testing"></div>' +
  '</div>'
)
PickwickApp.rootElement = '#ember-testing'
PickwickApp.setupForTesting()
PickwickApp.injectTestHelpers()
