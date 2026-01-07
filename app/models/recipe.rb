class Recipe < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :ingredients
  has_many :steps
  has_and_belongs_to_many :tags
  belongs_to :user

  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: :all_blank

  def belongs_to_user?(user)
    self.user_id == user.id
  end

  # username for users would render this unnecessary
  def get_recipe_author
    self.user.email.split("@").first.gsub(".", " ").split().map { |name| name.humanize }.join(" ")
    # converts "julia.child@example.com to Julia Child"
  end
end
