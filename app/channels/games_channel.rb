class GamesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "games_#{params[:game_id]}" if params.has_key?(:game_id)
    stream_from "player_#{params[:player_id]}" if params.has_key?(:player_id)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
