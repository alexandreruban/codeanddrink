class GameMaster::RoundsController < ApplicationController
  before_action :set_game
  before_action :set_round, except: [:index]

  def index
    @rounds = @game.rounds.order(created_at: :desc)
  end

  def update_number_of_winners
    @round.update(round_params)
    redirect_to game_master_game_rounds_path(@game)
  end

  def start
    @round.update(state: "running")
    redirect_to game_master_game_rounds_path(@game)
  end

  def stop
    @round.update(state: "finished")
    redirect_to game_master_game_rounds_path(@game)
  end

  private

  def round_params
    params.require(:round).permit(:number_of_winners)
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_round
    @round = Round.find(params[:id])
  end
end
