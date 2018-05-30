class Exercise < ApplicationRecord
  has_many :rounds

  validates :title, presence: true
  validates :rules, presence: true
  validates :specs, presence: true
end
