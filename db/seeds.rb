# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "net/http"
require "json"
require "faker"
require "csv"

AdminUser.delete_all
Product.delete_all
Category.delete_all

filename = Rails.root.join("db/gameknight.csv")

csv_data= File.read(filename)

gameknight_data = CSV.parse(csv_data, headers: true, encoding: "utf-8")

url = URI("https://api.pokemontcg.io/v2/cards?q=set.id:base1")
response = Net::HTTP.get(url)
json_data = JSON.parse(response)

cards_category = Category.create(
  name: "Cards"
)

packs_category = Category.create(
  name: "Card Packs"
)

binders_category = Category.create(
  name: "Binders"
)

sleeves_category = Category.create(
  name: "Card Sleeves"
)

gameknight_data.each do |product|
  pack_product = packs_category.product.create(
    name: product["name"],
    description: product["description"],
    price: product["price"],
    stock: Faker::Number.between(from: 0, to: 200)
  )

  pack_product.image.attach(io:product["image-src"],filename: "m-#{[product["name"],Faker::Number.number(digits: 6)].join('-')}.jpg")
  sleep(1)
end

json_data["data"].each do |card|
  if card["supertype"] == "Pokemon"
    card_product = cards_category.product.create(
      name: "#{card["name"]} - #{card["set"]["ptcgoCode"]} #{card["number"]}",
      description: card["flavorText"],
      price: card["cardmarket"]["prices"]["averageSellPrice"],
      stock: Faker::Number.between(from: 0, to: 200)
    )

    card_product.image.attach(io:card["images"]["small"],filename: "m-#{[card["name"],card["set"]["ptcgoCode"],card["number"],Faker::Number.number(digits: 6)].join('-')}.jpg")
    sleep(1)
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?