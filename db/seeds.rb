# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "destroying destroying doses"
Dose.destroy_all

puts "destroying cocktails"
Cocktail.destroy_all

puts "destroying ingredients"
Ingredient.destroy_all

puts "get ingredients from url"
url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
response = RestClient.get(url)
json_response = JSON.parse(response.body, symbolize_names: true)

ingredients_array = []
puts "creating ingredients"
json_response[:drinks].each do |ing|
  ingredient = Ingredient.create(name: ing[:strIngredient1])
  ingredients_array << ingredient
end


puts "destroying cocktails"
Cocktail.destroy_all

puts "creating 8 cocktails"
8.times do
  cocktail = Cocktail.create(
    name: Faker::DcComics.hero,
    photo: File.new("#{Rails.root}/db/seed_images/#{rand(1..4)}.jpg")
  )
  puts "adding doses"
  rand(2..5).times do
    Dose.create(
      description: "#{[5, 10, 20, 25, 400, 500].sample}ml",
      ingredient: ingredients_array.sample,
      cocktail: cocktail
    )
  end
end

  # ActiveRecord::Schema.define(version: 2019_11_14_122456) do

  #   # These are extensions that must be enabled in order to support this database
  #   enable_extension "plpgsql"

  #   create_table "cocktails", force: :cascade do |t|
  #     t.string "name"
  #     t.datetime "created_at", null: false
  #     t.datetime "updated_at", null: false
  #   end

  #   create_table "doses", force: :cascade do |t|
  #     t.string "description"
  #     t.bigint "cocktail_id"
  #     t.bigint "ingredient_id"
  #     t.datetime "created_at", null: false
  #     t.datetime "updated_at", null: false
  #     t.index ["cocktail_id"], name: "index_doses_on_cocktail_id"
  #     t.index ["ingredient_id"], name: "index_doses_on_ingredient_id"
  #   end

  #   create_table "ingredients", force: :cascade do |t|
  #     t.string "name"
  #     t.datetime "created_at", null: false
  #     t.datetime "updated_at", null: false
  #   end

  #   add_foreign_key "doses", "cocktails"
  #   add_foreign_key "doses", "ingredients"
  # end
