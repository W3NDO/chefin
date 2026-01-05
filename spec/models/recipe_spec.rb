require 'rails_helper'

RSpec.describe Recipe, type: :model do
  # Setup basic objects for testing
  let(:user) { User.create!(email: "julia.child@example.com", password: "password123", password_confirmation: "password123") }
  let(:valid_attributes) do
    {
      name: "French Onion Soup",
      user: user
    }
  end

  describe "slug generation (FriendlyId)" do
    it "generates a slug based on the name" do
      recipe = Recipe.create!(valid_attributes)
      expect(recipe.slug).to eq("french-onion-soup")
    end

    it "uses the slug for finding the record" do
      recipe = Recipe.create!(valid_attributes)
      expect(Recipe.friendly.find("french-onion-soup")).to eq(recipe)
    end
  end

  describe "associations" do
    it "belongs to a user" do
      recipe = Recipe.new(valid_attributes)
      expect(recipe.user).to eq(user)
    end

    it "can have ingredients, steps, and tags" do
      recipe = Recipe.new(valid_attributes)
      expect(recipe.ingredients).to be_empty
      expect(recipe.steps).to be_empty
      expect(recipe.tags).to be_empty
    end
  end

  describe "nested attributes" do
    it "creates ingredients via nested attributes" do
      recipe = Recipe.new(valid_attributes.merge(
        ingredients_attributes: [ { name: "Onions" }, { name: "Beef Stock" } ]
      ))

      expect(recipe.ingredients.size).to eq(2)
      expect(recipe.ingredients.first.name).to eq("Onions")
    end

    it "rejects ingredients if they are all blank" do
      recipe = Recipe.new(valid_attributes.merge(
        ingredients_attributes: [ { name: "" } ]
      ))

      expect(recipe.ingredients).to be_empty
    end
  end

  describe "#belongs_to_user?" do
    let(:other_user) { User.create!(email: "other@example.com", password: "password", password_confirmation: "password") }
    let(:recipe) { Recipe.new(user: user) }

    it "returns true if the user is the owner" do
      expect(recipe.belongs_to_user?(user)).to eq(true)
    end

    it "returns false if the user is not the owner" do
      expect(recipe.belongs_to_user?(other_user)).to eq(false)
    end
  end

  describe "#get_recipe_author" do
    it "extracts and formats the name from the user email" do
      recipe = Recipe.new(user: user) # Email is julia.child@example.com
      expect(recipe.get_recipe_author).to eq("Julia child")
    end

    it "handles emails without dots correctly" do
      simple_user = User.new(email: "admin@test.com")
      recipe = Recipe.new(user: simple_user)

      expect(recipe.get_recipe_author).to eq("Admin")
    end
  end
end
