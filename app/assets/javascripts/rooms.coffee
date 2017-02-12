$(document).on "turbolinks:load", ->
  scroll_bottom()

  $("#new_message").on "keypress", (e) ->
    if e && e.keyCode == 13
      e.preventDefault()
      $(this).submit()

  $("#new_message").on "submit", (e) ->
    e.preventDefault()

    room_id = $("[data-behavior='message-form']").data("room-id")
    content = $("#message_content")

    App.rooms.send_message(room_id, content.val())

    content.val("")


scroll_bottom = () ->
  $("[data-behavior='messages']").scrollTop($("[data-behavior='messages']")[0].scrollHeight)
