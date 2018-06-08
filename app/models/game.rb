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

  def not_started?
    self.rounds.first.state == "not started"
  end

  def final_running?
    running_round = self.rounds.find_by_state("running")
    running_round.nil? ? false : (running_round.number_of_winners == 1)
  end
end
