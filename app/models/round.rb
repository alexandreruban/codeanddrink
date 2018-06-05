class Round < ApplicationRecord

  default_scope { order(created_at: :asc) }

  belongs_to :game
  belongs_to :exercise
  has_many :attempts, dependent: :destroy

  validates :number_of_winners, {
    numericality: { only_integer: true, greater_than: 0 }
  }
  validates :state, inclusion: { in: [ "not started", "running", "finished" ] }

  def start
    update(state: "running")
    game.players.where(status: "alive").update_all(status: "playing")
    ActionCable.server.broadcast "game_#{game.id}", {
      message: "round started",
      game_partial: ApplicationController.renderer.render(
        partial: "players/game_screen",
        locals: {
          round: self,
          attempt: Attempt.new,
          last_attempt: nil,
          exercise: self.exercise
        }
      )
    }
  end

  def stop
    update(state: "finished")
    game.players.where(status: "playing").update_all(status: "defeated")
    ActionCable.server.broadcast "game_#{game.id}", {
      message: "round stopped",
      ranking_partial: ApplicationController.renderer.render(
        partial: "players/ranking_screen",
        locals: {
          players: {
            alive_players: self.game.players.select { |player| player.status == "alive" },
            playing_players: self.game.players.select { |player| player.status == "playing" },
            defeated_players: self.game.players.select { |player| player.status == "defeated" }
          }
        }
      )
    }
  end

  def add_valid_attempt(attempt)
    if state == "running" && attempt.status == "valid"
      attempt.player.update(status: "alive")
      winners_count = attempts.where(status: "valid").group(:player).count.size
      if winners_count == number_of_winners
        stop
      end
    end
  end
end
