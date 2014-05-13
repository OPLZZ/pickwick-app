
hello.on('auth.login', function(auth){
    // call user information, for the given network
    hello( auth.network ).api( '/me' ).success(function(r){
      Ember.run(function(){
        console.log(auth)
        console.log(r)
        user = PickwickApp.User.create({'name': r.name, 'system_id': r.id, 'token': auth.authResponse.access_token });
        user.save()
        route = PickwickApp.__container__.lookup('route:application');
        route.transitionTo("user_job_postings");
      })
    });
  });

hello.on('auth.logout', function(auth){
    // call user information, for the given network
    Ember.run(function(){
      controller = PickwickApp.__container__.lookup('controller:application');
      controller.set('user', undefined)
      controller = PickwickApp.__container__.lookup('controller:user_job_postings');
      controller.set('user', undefined)
    })
  });

hello.init({ 
    facebook : '458081994294211',
  },{redirect_uri:'redirect.html'});
