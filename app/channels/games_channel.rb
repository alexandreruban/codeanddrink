class GamesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "player_#{params[:player_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
