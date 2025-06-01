# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# require "faker"
# Create some products with Faker
# 676.times do
#   Product.find_or_create_by!(
#     title: Faker::Commerce.product_name,
#     price: Faker::Commerce.price(range: 10.0..100.0),
#     stock_quantity: Faker::Number.between(from: 1, to: 100)
#   )
# end
require "csv"

Product.destroy_all
Category.destroy_all

CSV.foreach("db/products.csv", headers: true) do |row|
  Product.create_or_find_by!(
    title: row["name"],
    price: row["price"].to_f,
    stock_quantity: row["stock_quantity"].to_i,
    category: Category.find_or_create_by!(name: row["category"])
  )
end