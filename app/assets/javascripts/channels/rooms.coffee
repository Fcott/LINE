App.rooms = App.cable.subscriptions.create "RoomsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    active_room = $("[data-behavior='messages'][data-room-id='#{data.room_id}']")
    if active_room.length > 0
      active_room.append(data.message)
      scroll_bottom()
    else
      $("[data-behavior='room-name'][data-room-id='#{data.room_id}']").css("font-weight", "bold")
      $("[data-behavior='timestamp'][data-room-id='#{data.room_id}']").text(data.timestamp)
      $("[data-behavior='content'][data-room-id='#{data.room_id}']").text(data.content)

  send_message: (room_id, message) ->
    @perform "send_message", {room_id: room_id, content: message}


  scroll_bottom = () ->
    $("[data-behavior='messages']").scrollTop($("[data-behavior='messages']")[0].scrollHeight)
