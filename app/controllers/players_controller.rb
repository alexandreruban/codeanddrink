class PlayersController < ApplicationController


  def show
    # @player = Player.find(params[:id])
    @exercice = Exercice.joins(rounds: :game).where(rounds: { game_id: params[:game_id] })
    raise
  end


end
