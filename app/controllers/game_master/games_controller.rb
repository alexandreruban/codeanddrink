class GameMaster::GamesController < GameMaster::BaseController
  before_action :set_game, only: [ :show, :final ]

  def index
    @games = current_game_master.games
  end

  def show
    @final_running = @game.final_running?
    if @final_running
      @round = @game.rounds.find_by_state("running")
      @exercise = @round.exercise
      @final_players = @game.players.where.not(status: "defeated").order(created_at: :asc);
      @player0 = @final_players[0]
      @player1 = @final_players[1]
      @last_attempt0 = @round.attempts.where(player: @player0).last;
      @last_attempt1 = @round.attempts.where(player: @player1).last;
    end
  end

  private

  def set_game
    @game = current_game_master.games.find(params[:id])
    @players = @game.players
  end
end

