class AttemptsController < ApplicationController
  before_action :authenticate_player
  before_action :set_round

  def create
    @attempt        = Attempt.new(attempt_params)
    @attempt.round  = @round
    @attempt.player = current_player
    @attempt.status = "pending"

    if @attempt.save
      #AttemptValidationJob.new(@attempt.id).perform_now
      AttemptValidationJob.perform_later(@attempt.id)
      redirect_to game_player_path(current_player.game, current_player)
    end
  end

  private

  def current_player
    @current_player ||= Player.find(session[:player_id]) if session[:player_id]
  end

  def authenticate_player
    redirect_to root_url unless current_player
  end

  def attempt_params
    params.require(:attempt).permit(:player_input)
  end

  def set_round
    @round = current_player.game.rounds.find(params[:round_id])
  end
end
