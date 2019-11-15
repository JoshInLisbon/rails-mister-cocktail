class Ingredient < ApplicationRecord
  has_many :doses, dependent: :restrict_with_error
  has_many :cocktails, through: :doses

  validates :name, uniqueness: true, presence: true
end
