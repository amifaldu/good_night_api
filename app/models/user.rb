class User < ApplicationRecord
  # Associations
  has_many :sleep_records, dependent: :destroy
  has_many :follower_users, foreign_key: :follower_user_id, class_name: 'UserFollowing'
  has_many :following_users, through: :follower_users, source: :following_user
   # Validations
  validates :name, presence: true, length: { maximum: 255 }
  # scope
  scope :last_week_sleep_trackings, -> {
    joins(:sleep_records)
      .select('sleep_records.id', 'sleep_records.user_id', 'users.name', 'sleep_records.sleep_start', 'sleep_records.sleep_end', 'sleep_records.sleep_duration')
      .where(sleep_records: { created_at: 1.week.ago..Time.zone.now })
      .where.not(sleep_records: { sleep_end: nil })
      .order(sleep_duration: :desc)
  }
end