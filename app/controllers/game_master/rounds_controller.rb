class GameMaster::RoundsController < GameMaster::BaseController
  before_action :set_game, except: [:destroy]
  before_action :set_round, only: [:show, :edit, :update, :start, :stop, :final]

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
  end

  def stop
    @round.stop
    redirect_to game_master_game_rounds_path(@game)
  end

  def final
    @exercise = @round.exercise
    @final_players = @game.players.where(status: "playing");
    @player0 = @final_players[0]
    @player1 = @final_players[1]
    @last_attempt0 = @round.attempts.where(player: @player0).last;
    @last_attempt1 = @round.attempts.where(player: @player1).last;

    ActionCable.server.broadcast "player_#{@player0.id}", {
      message: "final started"
    }
    ActionCable.server.broadcast "player_#{@player1.id}", {
      message: "final started"
    }
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
