class GameMaster::GamesController < GameMaster::BaseController
  before_action :set_game, only: [ :show, :final ]

  def index
    @games = current_game_master.games
  end

  def show
  end

  private

  def set_game
    @game = current_game_master.games.find(params[:id])
    @players = @game.players
  end
end

