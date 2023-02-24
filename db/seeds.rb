# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'rest-client'
require 'json'
require 'faker'

puts "Getting Movies Data"

movies_api_url = "https://tmdb.lewagon.com/"

def movies_dataset(api_base, request)
  movies = RestClient.get("#{api_base}#{request}")
  movies_array = JSON.parse(movies)["results"]
  # configurate images url
  img_base_url = "https://image.tmdb.org/t/p/"
  size = "w500"

  movies_array.each do |movie|
    image_path = movie["poster_path"]
      
    Movie.create(
      id: movie["id"],
      title: movie["title"],
      overview: movie["overview"],
      poster_url: "#{img_base_url}#{size}#{image_path}",
      rating: movie["vote_average"]
    )
  end
end

def lists_dataset(api_base, request)
  lists = RestClient.get("#{api_base}#{request}")
  lists_array = JSON.parse(lists)["genres"]

  lists_array.each do |list|
    List.create(
      id: list["id"],
      name: list["name"]
    )
  end
end

def bookmarks_dataset(api_base, request)
  movies = RestClient.get("#{api_base}#{request}")
  movies_array = JSON.parse(movies)["results"]

  movies_array.each do |movie|
    movie_id = movie["id"]
    list_ids = movie["genre_ids"]

    list_ids.each do |list|
      current_bookmark = Bookmark.new(
        comment: Faker::Movie.quote
      )
  
      current_movie = Movie.find(movie_id)

      current_bookmark.list = List.find(list)
      current_bookmark.movie = current_movie
      current_bookmark.save
    end
  end
end

puts "set movies model"
movies_dataset(movies_api_url, "/movie/top_rated") 
puts "Seeding Movies Data"

puts "set list model"
lists_dataset(movies_api_url, "/genre/movie/list") 
puts "Seeding Lists Data"

puts "set bookmark and movies model"
bookmarks_dataset(movies_api_url, "/movie/top_rated") 
puts "Seeding Bookmarks and Movies Data"
