class GameMaster::GamesController < GameMaster::BaseController
  def index
    @games = current_game_master.games
  end

  def show
    @game = current_game_master.games.find(params[:id])
    @players = @game.players
  end
end

