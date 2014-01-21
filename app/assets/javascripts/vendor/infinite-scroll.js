(function(window, Ember, $){
  var InfiniteScroll = {
    PAGE:     1,  // default start page
    PER_PAGE: 25 // default per page
  };

  InfiniteScroll.ControllerMixin = Ember.Mixin.create({
    loadingMore: false,
    noMoreItems: false,
    recordsCount: -1,
    page: InfiniteScroll.PAGE,
    perPage: InfiniteScroll.PER_PAGE,

    actions: {
      getMore: function(){
        if (this.get('noMoreItems')) return;
        if (this.get('loadingMore')) return;
        console.log("MORE")

        this.set('loadingMore', true);
        this.get('target').send('getMore');
      },

      resetNoMore: function(){
        this.set('recordsCount', 0);
        this.set('noMoreItems', false);
      },
      noMore: function(){
        this.set('noMoreItems', true);
      }
    }
  });
  
  InfiniteScroll.RouteMixin = Ember.Mixin.create({
    actions: {
      getMore: function() {
        throw new Error("Must override Route action `getMore`.");
      },
      fetchPage: function() {
        throw new Error("Must override Route action `getMore`.");
      }
    }
  });

  InfiniteScroll.ViewMixin = Ember.Mixin.create({
    setupInfiniteScrollListener: function(){
      $(window).on('scroll', $.proxy(this.didScroll, this));
    },
    teardownInfiniteScrollListener: function(){
      $(window).off('scroll', $.proxy(this.didScroll, this));
    },
    didScroll: function(){
      if (this.isScrolledToBottom()) {
        this.get('controller').send('getMore');
      }
    },
    isScrolledToBottom: function(){
      var viewPortTop = $('.infinite-scroll-box').scrollTop();

      if (viewPortTop === 0) {
        // if we are at the top of the page, don't do
        // the infinite scroll thing
        return false;
      }
      return true;
    }
  });

  window.InfiniteScroll = InfiniteScroll;
})(this, Ember, jQuery);