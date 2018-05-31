class GameMaster::RoundsController < ApplicationController
  before_action :set_game
  before_action :set_round, except: [:index]

  def index
    @rounds = @game.rounds
  end

  def update_number_of_winners
    @round.update(round_params)
    redirect_to game_master_game_rounds_path(@game)
  end

  def start
    @round.update(state: "running")
    @round.winners = 0
    @round.game.players.where(status: "alive").each { |player| player.update(status: "playing") }
    redirect_to game_master_game_rounds_path(@game)
  end

  def stop
    @round.update(state: "finished")
    @players = @game.players
    @players.each do |player|
      player.update_status
      player.save
    end
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
