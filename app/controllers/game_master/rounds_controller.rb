class GameMaster::RoundsController < GameMaster::BaseController
  before_action :set_game, except: [:destroy]
  before_action :set_round, only: [:show, :edit, :update, :start, :stop]

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
    @exercises = Exercise.all
  end

  def update
    if @round.update(round_params)
      redirect_to game_master_game_rounds_path(@game)
    else
      render :edit
    end
  end

  def destroy
    @round = Round.find(params[:id])
    @game = @round.game
    @round.destroy

    redirect_to game_master_game_rounds_path(@game)
  end

  def start
    @round.start
    redirect_to game_master_game_rounds_path(@game)
    ActionCable.server.broadcast 'games', games: "coucou start"
  end

  def stop
    @round.stop
    redirect_to game_master_game_rounds_path(@game)
    ActionCable.server.broadcast 'games', content: "coucou stop"
  end

  private

  def round_params
    params.require(:round).permit(:number_of_winners, :exercise_id)
  end

  def set_game
    @game = current_game_master.games.find(params[:game_id])
  end

  def set_round
    @round = @game.rounds.find(params[:id])
  end
end
