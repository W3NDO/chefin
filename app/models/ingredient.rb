class Ingredient < ApplicationRecord
  belongs_to :recipe

  # enum :amount_unit, [ :liters, :ounces, :grams, :gallons, :cups, :teaspoons, :tablespoons ]
  enum :amount_unit, { liters: "liters", ounces: "ounces", grams: "grams", gallons: "gallons", cups: "cups", teaspoons: "teaspoons", tablespoons: "tablespoons" }
  enum :temp_unit, { fahrenheit: "fahrenheit", celsius: "celsius" }
end
