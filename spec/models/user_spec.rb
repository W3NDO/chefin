require 'rails_helper'

RSpec.describe User, type: :model do
  def build_user(overrides = {})
    attrs = {
      email: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    }.merge(overrides)
    User.new(attrs)
  end

  describe "validations" do
    it "is valid with valid attributes" do
      user = build_user
      expect(user.valid?).to eq(true)
    end

    it "requires an email" do
      user = build_user(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "requires a unique email (case-insensitive)" do
      User.create!(email: "original@example.com", password: "password", password_confirmation: "password")
      duplicate = build_user(email: "ORIGINAL@example.com")

      expect(duplicate.valid?).to eq(false)
      expect(duplicate.errors[:email]).to include("has already been taken")
    end

    it "requires a password" do
      user = build_user(password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "enforces a minimum password length" do
      user = build_user(password: "12345", password_confirmation: "12345")
      user.valid?
      expect(user.errors[:password].any? { |e| e.include?("is too short") }).to eq(true)
    end
  end

  describe "associations" do
    it "has many recipes" do
      user = build_user
      expect(user.recipes).to be_empty
    end

    it "removes associated recipes when the user is destroyed" do
      user = User.create!(email: "chef@example.com", password: "password", password_confirmation: "password")

      user.recipes.create!(name: "Traditional Goulash", description: "Slow cook for 3 hours")

      expect(Recipe.count).to eq(1)

      user.destroy

      expect(Recipe.count).to eq(0)
    end
  end

  describe "devise integration" do
    it "encrypts the password" do
      user = User.create!(email: "devise@example.com", password: "password123", password_confirmation: "password123")

      expect(user.encrypted_password).not_to be_empty
      expect(user.encrypted_password).not_to eq("password123")
    end
  end
end
