
hello.on('auth.login', function(auth){
    // call user information, for the given network
    hello( auth.network ).api( '/me' ).success(function(r){
      Ember.run(function(){
        controller = PickwickApp.__container__.lookup('controller:application');
        user = PickwickApp.User.create({'name': r.name, 'id': r.id, 'thumbnail': r.thumbnail, 'obj': r});
        controller.set('user', user)
      })
    });
  });

hello.init({ 
    facebook : '213747822167688',
  },{redirect_uri:'redirect.html'});
