class PlayersController < ApplicationController
  before_action :set_game
  before_action :authenticate_player, only: :show

  helper_method :current_player

  def show
    # game not started or you won / lose
    @players = @game.players.order(created_at: :asc)

    # round running
    @round = @game.rounds.find_by(state: "running") || @game.rounds.first
    @exercise = @round.exercise
    @attempt = Attempt.new
    @last_attempts = @round.attempts.where(player: @player)
    @last_attempt = @last_attempts.empty? ? nil : @last_attempts.last
  end

  def new
    @player = Player.new
  end

  def create
    if @game.not_started?
      @player = Player.new(player_params)
      @player.game = @game

      if (params["player"]["game_pwd_input"] == @game.password)
        if @player.save
          session[:player_id] = @player.id
          redirect_to game_player_path(@game, @player)
          ActionCable.server.broadcast "game_#{@game.id}", {
            message: "new player",
            players_partial: ApplicationController.renderer.render(
              partial: "players/players",
              locals: {
                players: @game.players.order(created_at: :asc)
              }
              )
          }
        else
          render :new
        end
      else
        @invalid_password = true
        render :new
      end

    else
      render :new
    end
  end

  def content
    ActionCable.server.broadcast "game_#{@game.id}", {
      message: "new final content",
      player_id: params[:id],
      content: params[:content]
    }
  end

  private

  def player_params
    params.require(:player).permit(:username)
  end

  def current_player
    @current_player ||= @game.players.find(session[:player_id]) if session[:player_id]
  end

  def authenticate_player
    unless current_player && current_player == Player.find(params[:id])
      redirect_to root_url
    end
  end

  def set_game
    @game = Game.find(params[:game_id])
  end
end
