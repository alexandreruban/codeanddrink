class Round < ApplicationRecord
  belongs_to :game
  belongs_to :exercise
  has_many :attempts

  validates :number_of_winners, numericality: { only_integer: true }
  validates :state, inclusion: { in: [ "not started", "running", "finished" ] }
end
