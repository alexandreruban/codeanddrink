class Game < ApplicationRecord
  belongs_to :game_master
  has_many :rounds
  has_many :players
end
