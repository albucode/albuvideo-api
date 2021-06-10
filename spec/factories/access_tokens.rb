FactoryBot.define do
  factory :access_token do
    name { "MyAccessToken" }
    user
  end
end
