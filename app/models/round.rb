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
    game.players.where(status: "playing").update_all(status: "defeated")
    game.players.reload # do not remove me (thanks to update_all and select)!!

    update(state: "finished")

    ActionCable.server.broadcast "game_#{game.id}", {
      message: "round stopped",
      ranking_partial: ApplicationController.renderer.render(
        partial: "players/ranking_screen",
        locals: {
          players: game.players.order(created_at: :asc)
        }
      )
    }
  end

  def add_valid_attempt(attempt)
    if state == "running" && attempt.status == "valid"
      attempt.player.update(status: "alive")
      ActionCable.server.broadcast "player_#{attempt.player.id}", {
        message: "successful attempt",
        ranking_partial: ApplicationController.renderer.render(
          partial: "players/ranking_screen",
          locals: {
            players: game.players.order(created_at: :asc)
          }
        )
      }
      ActionCable.server.broadcast "game_#{attempt.round.game.id}", {
        message: "new ranking",
        new_ranking_partial: ApplicationController.renderer.render(
          partial: "players/ranking_screen",
          locals: {
            players: game.players.order(created_at: :asc)
          }
        )
      }
      winners_count = attempts.where(status: "valid").group(:player).count.size
      if winners_count == number_of_winners
        stop
      end
    end
  end
end
