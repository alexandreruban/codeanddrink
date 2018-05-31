class AttemptsController < ApplicationController
  skip_before_action :authenticate_game_master!

  def create
    @attempt        = Attempt.new(attempt_params)
    @attempt.round  = Round.find(params[:round_id])
    @attempt.player = Player.find(params[:player_id])
    @attempt.status = "pending"
    if @attempt.save
      #AttemptValidationJob.new(@attempt.id).perform_now
      AttemptValidationJob.perform_later(@attempt.id)
    end
  end

  private

  def attempt_params
    params.require(:attempt).permit(:player_input)
  end
end
