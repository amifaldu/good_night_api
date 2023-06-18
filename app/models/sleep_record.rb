class SleepRecord < ApplicationRecord
  # Associations
  belongs_to :user
  # Validations
  validates :sleep_start, presence: true
end