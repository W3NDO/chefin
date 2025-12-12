class Ingredient < ApplicationRecord
  belongs_to :recipe
  enum amount_unit: { liters: "liters", ounces: "ounces", grams: "grams", gallons: "gallons" }
  enum temp_unit: { fahrenheit: "fahrenheit", celsius: "celsius" }
end
