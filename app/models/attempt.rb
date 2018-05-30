class Attempt < ApplicationRecord
  belongs_to :round
  belongs_to :player

  validates :status, inclusion: { in: %w[valid invalid] }
end
