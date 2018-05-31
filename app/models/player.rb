class Player < ApplicationRecord
  belongs_to :game
  has_many :attempts
  validates :username, presence: true, uniqueness: true

  validates :status, inclusion: { in: %w[alive defeated playing] }

  def has_no_successful_attempts?
    self.attempts.select { |attempt| attempt.status == "valid" } == []
  end

  def update_status
    self.status = "defeated" if has_no_successful_attempts?
  end
end
