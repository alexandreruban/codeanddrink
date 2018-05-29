class PlayersController < ApplicationController

  def show
    @player = Player.find(params[:id])
    @exercise = Exercise.joins(rounds: :game).where(rounds: { game_id: params[:game_id] }).first
    #ne pas oublier de rajouter le "state" lorsque celui-ci sera créé.
  end
end
