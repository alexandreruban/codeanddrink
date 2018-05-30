class Round < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :game
  belongs_to :exercise
  has_many :attempts

  validates :number_of_winners, {
    numericality: { only_integer: true, greater_than: 0 }
  }
  validates :state, inclusion: { in: [ "not started", "running", "finished" ] }
end
