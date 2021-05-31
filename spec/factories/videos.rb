FactoryBot.define do
  factory :video do
    title { Faker::Movie.title }
    published { Faker::Boolean.boolean }
    status { 'ready' }
    source { Faker::Internet.url }
  end
end
