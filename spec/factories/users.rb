FactoryBot.define do
  factory :user do
    email { "test@test.com" }
    login { "test@test.com" }
    password { "password" }
    password_confirmation { "password" }
    active { true }
    approved { true }
    confirmed { true }
  end
end