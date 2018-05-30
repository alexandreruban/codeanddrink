class PlayersController < ApplicationController

  skip_before_action :authenticate_game_master!
  before_action :authenticate_player, only: :show

  def show
    @player = Player.find(params[:id])
    @game = Game.find(params[:game_id])
    @players = @game.players
    @exercise = Exercise.joins(rounds: :game).where(rounds: { game_id: params[:game_id] }).first
    #ne pas oublier de rajouter le "state" lorsque celui-ci sera créé.
  end

  def new
    @game = Game.find(params[:game_id])
    @player = Player.new
  end

  def create
    @game = Game.find(params[:game_id])
    @player = Player.new(player_params)
    @player.game = @game
    if (params["player"]["password"] == @game.password) && @player.save
      session[:player_id] = @player.id
      redirect_to game_player_path(@game, @player)
    else
      render :new
    end
  end

  private

  def player_params
    params.require(:player).permit(:username)
  end

  def current_player
    @game = Game.find(params[:game_id])
    @current_player ||= @game.players.find(session[:player_id]) if session[:player_id]
  end

  def authenticate_player
    unless current_player && current_player == Player.find(params[:id])
      redirect_to root_url
    end
  end
end
