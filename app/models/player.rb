class Player < ApplicationRecord
  belongs_to :game
  has_many :attempts
  validates :username, presence: true, uniqueness: true

  validates :status, inclusion: { in: %w[alive defeated] }
end
