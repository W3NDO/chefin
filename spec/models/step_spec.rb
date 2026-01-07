require 'rails_helper'

RSpec.describe Step, type: :model do
  let(:user) { User.create!(email: "chef.berlin@example.de", password: "password123", password_confirmation: "password123") }
  let(:recipe) { Recipe.create!(name: "Pretzel", user: user) }

  def build_step(overrides = {})
    attrs = {
      step_number: 1,
      instruction: "Mix the flour and water.",
      duration: 10,
      duration_unit: "minutes",
      recipe: recipe
    }.merge(overrides)
    Step.new(attrs)
  end

  describe "schema constraints" do
    it "is valid with all required fields" do
      step = build_step
      expect(step.valid?).to eq(true)
    end

    it "is invalid without a step_number" do
      step = build_step(step_number: nil)
      expect(step.valid?).to eq(false)
      expect(step.errors[:step_number]).to include("can't be blank")
    end

    it "is invalid without an instruction" do
      step = build_step(instruction: nil)
      expect(step.valid?).to eq(false)
      expect(step.errors[:instruction]).to include("can't be blank")
    end

    it "requires a recipe_id" do
      step = build_step(recipe: nil)
      expect(step.valid?).to eq(false)
      expect(step.errors[:recipe]).to include("must exist")
    end
  end


  describe "enums (duration_unit)" do
    it "allows setting valid units" do
      step = build_step(duration_unit: "hours")
      expect(step.hours?).to eq(true)
      expect(step.duration_unit).to eq("hours")
    end

    it "raises ArgumentError when assigning a value not in the enum list" do
      step = build_step

      expect {
        step.duration_unit = "seconds"
      }.to raise_error(ArgumentError)
    end
  end

  describe "associations and attachments" do
    it "belongs to a recipe" do
      step = build_step
      expect(step.recipe).to eq(recipe)
    end
  end

  describe "custom attributes" do
    it "can store pre_requisite_steps" do
      step = build_step(pre_requisite_steps: 2)
      expect(step.pre_requisite_steps).to eq(2)
    end
  end
end
