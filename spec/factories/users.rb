FactoryBot.define do 
  factory :user do 
    name {"ユーザー名"}
    sequence(:email) { |n| "ユーザー名#{n}@example.com"}
    sequence(:introduction) {  |n| "introduction#{n}" }
    password {"password"}
    
    trait :too_long_name do
      name {Faker::Lorem.characters(16)}
    end
    trait :too_short_name do
      name {Faker::Lorem.characters(1)}
    end

    trait :too_long_email do
      email {Faker::Lorem.characters(81)}
    end

    trait :too_long_introduction do
      introduction {Faker::Lorem.characters(151)}
    end
  end 
end 