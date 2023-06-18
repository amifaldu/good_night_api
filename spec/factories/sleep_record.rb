FactoryBot.define do
  factory :sleep_record do
    user
    sleep_start { Time.current }
  end
end