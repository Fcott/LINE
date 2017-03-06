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

  def update(data)
    user_room = message_user.user_rooms.find_by(room_id: data['room_id'])
    user_room.update(last_read_at: Time.now)
  end

end
