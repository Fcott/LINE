class RoomsChannel < ApplicationCable::Channel
  def subscribed
    message_user.rooms.each do |room|
      stream_from "Room:#{room.id}"
    end
  end

  def unsubscribed
    stop_all_streams
  end

  def send_message(data)
    @room = Room.find(data['room_id'])
    message = @room.messages.create(content: data['content'], user: message_user)
    MessageRelayJob.perform_later(message)
  end
end
