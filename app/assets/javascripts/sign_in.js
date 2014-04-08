
hello.on('auth.login', function(auth){
    // call user information, for the given network
    hello( auth.network ).api( '/me' ).success(function(r){
      Ember.run(function(){
        controller = PickwickApp.__container__.lookup('controller:application');
        user = PickwickApp.User.create({'name': r.name, 'id': r.id, 'thumbnail': r.thumbnail, 'obj': r, 'auth': auth});
        controller.set('user', user)
      })
    });
  });

hello.on('auth.logout', function(auth){
    // call user information, for the given network
    Ember.run(function(){
      controller = PickwickApp.__container__.lookup('controller:application');
      controller.set('user', undefined)
    })
  });

hello.init({ 
    facebook : '213747822167688',
  },{redirect_uri:'redirect.html'});
