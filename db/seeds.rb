# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# puts "Creating fake movies..."

# 20.times do
#   movie = Movie.create(
#     title: Faker::Movie.title,
#     overview: Faker::Quote.famous_last_words,
#     poster_url: Faker::LoremFlickr.image,
#     rating: rand(0..5)
#   )
# end

require 'json'
require 'open-uri'


puts "Creating fake movies..."

Bookmark.destroy_all
Movie.destroy_all

url = 'https://tmdb.lewagon.com/movie/top_rated'
movie_serialized = URI.open(url).read
movies = JSON.parse(movie_serialized)
movies['results'].each do |movie|
  Movie.create(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: movie['poster_path'],
    rating: movie['vote_average']
  )
end
puts "finish - #{Movie.count} movies created"
