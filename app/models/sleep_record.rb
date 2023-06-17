class SleepRecord < ApplicationRecord
  # Associations
  belongs_to :user
  # Validations
  validates :sleep_start, presence: true
  validates :sleep_end, presence: true
  validates :sleep_duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
end