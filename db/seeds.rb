# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

20.times do
  Post.create!(
    :title => [Faker::Company.name,  Faker::Company.industry].join(' - '),
    :url => Faker::LoremFlickr.image(search_terms: ['reddit']),
    :content => Faker::Quote.matz,
    :sub_ids => [28],
    :author_id => 5
  )
end
