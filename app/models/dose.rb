class Dose < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient

  validates :description, :cocktail, :ingredient, presence: true

  validates :cocktail, uniqueness: { scope: :ingredient }
  # same as:
  # validates :cocktail_id, uniqueness: { scope: :ingredient_id }
  # rails magic solves this


  # t.bigint "cocktail_id"
  # t.bigint "ingredient_id"
end
