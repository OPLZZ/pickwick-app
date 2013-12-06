
mixin PickwickApp.TouchScroll

  touchStart: (event) ->
    @touch_start_position.x = event.originalEvent.touches[0].screenX
    @touch_start_position.y = event.originalEvent.touches[0].screenY

  touchEnd: (event) ->
    @touchMoveBox(event)
    @touch_start_position.x = 0
    @touch_start_position.y = 0

  touchMove: (event) ->
    @touchMoveBox(event)
    event.preventDefault()

  touchMoveBox: (event) ->
    move_x = @touch_start_position.x - event.originalEvent.touches[0].screenX
    move_y = @touch_start_position.y - event.originalEvent.touches[0].screenY 
    move_y = if move_y < 0 then "-=#{move_y*-1}px" else "+=#{move_y}px"
    move_x = if move_x < 0 then "-=#{move_x*-1}px" else "+=#{move_x}px"
    console.log(move_x+" | "+move_y)
    $('.infinite-scroll-box').scrollTo({top: move_y, left: move_x}, {duration:0})
    @touch_start_position.x = event.originalEvent.touches[0].screenX
    @touch_start_position.y = event.originalEvent.touches[0].screenY 

  touch_start_position:
    x: 0
    y: 0
