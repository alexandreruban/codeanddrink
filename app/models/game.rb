class Game < ApplicationRecord
  belongs_to :game_master
  has_many :rounds
  has_many :players

  validates :title, presence: true
  validates :description, presence: true
  validates :wifi_network, presence: true
  validates :wifi_password, presence: true
  validates :starts_at, presence: true
  validates :password, presence: true

  def round_running?
    self.rounds.where(state: 'running').any?
  end
end
