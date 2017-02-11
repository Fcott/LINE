class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.sever.broadcast "Room:#{message.room.id}", {
      message: MessagesController.render(message),
      room_id: message.room.id
    }
  end
end
