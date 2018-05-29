class Round < ApplicationRecord
  belongs_to :game
  belongs_to :exercise
  has_many :attempts
end
