# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create({ email: 'a@a.com', password: 'asdasdasd' })
video = Video.create({ title: 'Video1', published: true, source: 'sourceseed', user_id: user.id })

(1..3).map do
  VideoWatchEvent.create({ duration: 2.5, video_id: video.id, user_id: user.id })
end
