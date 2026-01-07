require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  # Setup dependencies
  let(:user) { User.create!(email: "chef.gordon@example.com", password: "password123", password_confirmation: "password123") }
  let(:recipe) { Recipe.create!(name: "Beef Wellington", user: user) }

  def build_ingredient(overrides = {})
    attrs = {
      name: "Puff Pastry",
      amount: 500,
      amount_unit: "grams",
      temp_unit: "celsius",
      recipe: recipe
    }.merge(overrides)
    Ingredient.new(attrs)
  end

  describe "associations" do
    it "belongs to a recipe" do
      ingredient = build_ingredient
      expect(ingredient.recipe).to eq(recipe)
    end

    it "can access the recipe owner through the association" do
      ingredient = build_ingredient
      # Testing the "chain" of ownership
      expect(ingredient.recipe.user).to eq(user)
    end
  end

  describe "enums" do
    describe "amount_unit" do
      it "accepts a valid unit from the hash keys" do
        ingredient = build_ingredient(amount_unit: "liters")
        expect(ingredient.amount_unit).to eq("liters")
      end

      it "raises an ArgumentError when an invalid unit is assigned" do
        ingredient = build_ingredient
        expect {
          ingredient.amount_unit = "kilograms"
        }.to raise_error(ArgumentError, /'kilograms' is not a valid amount_unit/)
      end

      it "provides helper methods for units" do
        ingredient = build_ingredient(amount_unit: "grams")
        expect(ingredient.grams?).to eq(true)
        expect(ingredient.cups?).to eq(false)
      end
    end

    describe "temp_unit" do
      it "correctly stores fahrenheit" do
        ingredient = build_ingredient(temp_unit: "fahrenheit")
        expect(ingredient.fahrenheit?).to eq(true)
      end

      it "correctly stores celsius" do
        ingredient = build_ingredient(temp_unit: "celsius")
        expect(ingredient.celsius?).to eq(true)
      end
    end
  end

  describe "database persistence" do
    it "saves the enum value as a string in the database" do
      ingredient = build_ingredient(amount_unit: "tablespoons")
      ingredient.save!

      raw_value = Ingredient.where(id: ingredient.id).pluck(:amount_unit).first
      expect(raw_value).to eq("tablespoons")
    end
  end
end
