class GameMaster::RoundsController < ApplicationController
  before_action :set_game, except: [:destroy]
  before_action :set_round, except: [:index, :new, :create]

  def index
    @rounds = @game.rounds
  end

  def new
    @round = Round.new
    @exercises = Exercise.all
  end

  def create
    @round = Round.new(round_params)
    @round.game = @game
    if @round.save
      redirect_to game_master_game_rounds_path(@game)
    else
      render :new
    end
  end

  def edit
    @round = Round.find(params[:id])
    @exercises = Exercise.all
  end

  def update
    @round = Round.find(params[:id])
    @round.update!(round_params)
    redirect_to game_master_game_rounds_path(@game)
  end

  def destroy
    @round = Round.find(params[:id])
    @game = @round.game
    @round.destroy
    redirect_to game_master_game_rounds_path(@game)
  end

  def start
    @round.update(state: "running")
    redirect_to game_master_game_rounds_path(@game)
  end

  def stop
    @round.update(state: "finished")
    redirect_to game_master_game_rounds_path(@game)
  end

  private

  def round_params
    params.require(:round).permit(:number_of_winners, :exercise_id)
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_round
    @round = Round.find(params[:id])
  end
end
