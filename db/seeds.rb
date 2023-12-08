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
ProductOrder.delete_all
Order.delete_all
Product.delete_all
Category.delete_all
Customer.delete_all
Province.delete_all

# filename = Rails.root.join("db/gameknight.csv")

# csv_data= File.read(filename)

# gameknight_data = CSV.parse(csv_data, headers: true, encoding: "utf-8")

# cards_category = Category.create(
#   name: "Cards"
# )

# packs_category = Category.create(
#   name: "Card Packs"
# )

# binders_category = Category.create(
#   name: "Binders"
# )

# sleeves_category = Category.create(
#   name: "Card Sleeves"
# )

# gameknight_data.each do |product|
#   pack_product = packs_category.products.create(
#     name: product["name"],
#     description: product["description"],
#     price: product["price"],
#     stock: Faker::Number.between(from: 0, to: 200)
#   )

#   download_image = URI.open("https:" + product["image-src"])

#   pack_product.image.attach(io:download_image,filename: "m-#{[product["name"],Faker::Number.number(digits: 6)].join('-')}.jpg")
#   sleep(1)
# end

# url = URI("https://api.pokemontcg.io/v2/cards?q=set.id:base1")
# response = Net::HTTP.get(url)
# json_data = JSON.parse(response)

# json_data["data"].each do |card|
#   if card["supertype"] == "Pokémon"
#     card_product = cards_category.products.create(
#       name: "#{card["name"]} - #{card["set"]["ptcgoCode"]} #{card["number"]}",
#       description: card["flavorText"],
#       price: card["cardmarket"]["prices"]["averageSellPrice"],
#       stock: Faker::Number.between(from: 0, to: 200)
#     )

#     download_image = URI.open(card["images"]["small"])
#     card_product.image.attach(io:download_image,filename: "m-#{[card["name"],card["set"]["ptcgoCode"],card["number"],Faker::Number.number(digits: 6)].join('-')}.jpg")
#     sleep(1)
#   end
# end

Province.create(
  code: "AB",
  full_name: "Alberta",
  tax_percentage: 0.05
)

Province.create(
  code: "BC",
  full_name: "British Columbia",
  tax_percentage: 0.12
)

mb_province = Province.create(
  code: "MB",
  full_name: "Manitoba",
  tax_percentage: 0.12
)

Province.create(
  code: "NB",
  full_name: "New Brunswick",
  tax_percentage: 0.15
)

Province.create(
  code: "NL",
  full_name: "Newfoundland and Labrador",
  tax_percentage: 0.15
)

Province.create(
  code: "NT",
  full_name: "Northwest Territories",
  tax_percentage: 0.05
)

Province.create(
  code: "NS",
  full_name: "Nova Scotia",
  tax_percentage: 0.15
)

Province.create(
  code: "NU",
  full_name: "Nunavut",
  tax_percentage: 0.05
)

Province.create(
  code: "ON",
  full_name: "Ontario",
  tax_percentage: 0.13
)

Province.create(
  code: "PEI",
  full_name: "Prince Edward Island",
  tax_percentage: 0.15
)

Province.create(
  code: "QC",
  full_name: "Quebec",
  tax_percentage: 0.14975
)

Province.create(
  code: "SK",
  full_name: "Saskatchewan",
  tax_percentage: 0.11
)

Province.create(
  code: "YT",
  full_name: "Yukon",
  tax_percentage: 0.05
)

fake_customer = mb_province.customers.create(
  email: "fake@email.com",
  username: "user101",
  street_address: "127 Princess Street",
  city: "Winnipeg",
  postal_code: "R2G7V2"
)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?