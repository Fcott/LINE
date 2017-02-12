$(document).on "turbolinks:load", ->
  $("#new_message").on "submit", (e) ->
    e.preventDefault()

    room_id = $("[data-behavior='message-form']").data("room-id")
    content = $("#message_content")

    App.rooms.send_message(room_id, content.val())

    content.val("")
