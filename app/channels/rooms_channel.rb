class RoomsChannel < ApplicationCable::Channel
  def subscribed
    message_user.rooms.each do |room|
      stream_from "Room:#{room.id}"
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
