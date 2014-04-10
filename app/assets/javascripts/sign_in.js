
hello.on('auth.login', function(auth){
    // call user information, for the given network
    hello( auth.network ).api( '/me' ).success(function(r){
      Ember.run(function(){
        console.log(auth)
        console.log(r)
        controller = PickwickApp.__container__.lookup('controller:application');
        user = PickwickApp.User.create({'name': r.name, 'system_id': r.id, 'token': auth.authResponse.access_token });
        user.save()
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
