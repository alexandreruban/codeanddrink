class GameMaster::GamesController < ApplicationController
  def index
    @games = Game.where(game_master: current_game_master)
  end
  def show
    @game = Game.find(params[:id])
    @players = @game.players
  end
end
