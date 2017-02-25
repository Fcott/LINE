class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    message.room.update(last_message: Time.now)
    ActionCable.server.broadcast "Room:#{message.room.id}", {
      message: MessagesController.render(message),
      room_id: message.room.id,
      timestamp: message.sent_time,
      content: message.content
    }
  end
end
