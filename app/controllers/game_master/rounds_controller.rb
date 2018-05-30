class GameMaster::RoundsController < ApplicationController
  before_action :set_game, only: [:index, :update_number_of_winners]

  def index
    @rounds = @game.rounds.order(created_at: :desc)
  end

  def update_number_of_winners
    @round = Round.find(params[:id])
    unless @round.update(round_params)
      flash[:warning] = "The number of winners is too big!"
    end
    redirect_to game_master_game_rounds_path(@game)
  end

  def start
  end

  private

  def round_params
    params.require(:round).permit(:number_of_winners)
  end

  def set_game
    @game = Game.find(params[:game_id])
  end
end
