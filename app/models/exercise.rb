class Exercise < ApplicationRecord
  has_many :rounds
  validates :template, presence: true
end
