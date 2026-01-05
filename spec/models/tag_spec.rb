require 'rails_helper'

RSpec.describe Tag, type: :model do
  # Helper to build a valid tag
  def build_tag(overrides = {})
    attrs = {
      tag_name: "Gluten-Free"
    }.merge(overrides)
    Tag.new(attrs)
  end

  describe "validations" do
    it "is valid with a unique tag_name" do
      tag = build_tag
      expect(tag.valid?).to eq(true)
    end

    it "is invalid without a tag_name" do
      tag = build_tag(tag_name: nil)
      expect(tag.valid?).to eq(false)
      expect(tag.errors[:tag_name]).to include("can't be blank")
    end

    it "enforces uniqueness of tag_name" do
      Tag.create!(tag_name: "vegan")
      duplicate = build_tag(tag_name: "vegan")

      expect(duplicate.valid?).to eq(false)
      expect(duplicate.errors[:tag_name]).to include("has already been taken")
    end
  end

  describe "callbacks" do
    it "downcases the tag_name before saving" do
      tag = Tag.create!(tag_name: "KETO-FRIENDLY")
      expect(tag.tag_name).to eq("keto-friendly")
    end
  end

  describe "slugging (FriendlyId)" do
    it "generates a slug from the tag_name" do
      tag = Tag.create!(tag_name: "High Protein")
      expect(tag.slug).to eq("high-protein")
    end

    it "ensures the slug is unique in the database" do
      # Schema has a unique index on slug
      tag1 = Tag.create!(tag_name: "Healthy")
      tag2 = Tag.create!(tag_name: "Healthy ")
      expect(tag1.slug).to eq("healthy")
      expect(tag1.slug == tag2.slug).to be false
    end
  end

  describe "associations" do
    it "has and belongs to many recipes" do
      tag = build_tag
      # Verifying HABTM relationship exists
      expect(tag.recipes).to be_empty
      expect(tag).to respond_to(:recipe_ids)
    end
  end

  describe "custom methods" do
    describe "#humanize_tag_name" do
      it "converts hyphens to spaces and humanizes" do
        tag = Tag.new(tag_name: "low-carb-diet")
        expect(tag.humanize_tag_name).to eq("Low carb diet")
      end

      it "handles simple names correctly" do
        tag = Tag.new(tag_name: "vegan")
        expect(tag.humanize_tag_name).to eq("Vegan")
      end
    end
  end
end
