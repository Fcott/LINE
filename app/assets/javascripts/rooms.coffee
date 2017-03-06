handleVisibilityChange = ->
  unless document.hidden
    room_id = $("[data-behavior='message-form']").data("room-id")
    App.rooms.update(room_id)

$(document).on "turbolinks:load", ->
  $(document).on "visibilitychange", handleVisibilityChange
  $("#new_message").on "keypress", (e) ->
    if e && e.keyCode == 13
      e.preventDefault()
      $(this).submit()

  $("#new_message").on "submit", (e) ->
    e.preventDefault()

    room_id = $("[data-behavior='message-form']").data("room-id")
    content = $("#message_content")
    App.rooms.send_message(room_id, content.val())  unless content.val().trim() == ""

    content.val("")
