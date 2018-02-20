FactoryBot.define do
  factory :user do
    email "testuser@gmail.com"
    password "123456"
    password_confirmation "123456"
    first_name "James"
    last_name "Black"
  end
end
