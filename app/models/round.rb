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
    ActionCable.server.broadcast "game_#{game.id}", games: "round started"
  end

  def stop
    update(state: "finished")
    game.players.where(status: "playing").update_all(status: "defeated")
    ActionCable.server.broadcast "game_#{game.id}", games: "round stopped"
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
