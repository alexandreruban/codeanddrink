class PlayersController < ApplicationController

  skip_before_action :authenticate_game_master!
  
  def show
    @player = Player.find(params[:id])
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
        redirect_to game_player_path(@game, @player)
    else
      render :new
    end
  end

  private

  def player_params
    params.require(:player).permit(:username)
  end
end
