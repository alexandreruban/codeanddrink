class Round < ApplicationRecord
  belongs_to :game
  belongs_to :exercice
  has_many :attempts
end
