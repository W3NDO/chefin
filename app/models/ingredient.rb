class Ingredient < ApplicationRecord
  belongs_to :recipe

  enum :amount_unit, [ :liters, :ounces, :grams, :gallons ]
  enum :temp_unit, [ :fahrenheit, :celsius ]
end
