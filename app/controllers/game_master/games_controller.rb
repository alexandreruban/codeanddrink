class GameMaster::GamesController < ApplicationController
  def index
    @games = Game.where(game_master: current_game_master)
  end
end
