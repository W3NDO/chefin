class Recipe < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :ingredients
  has_many :steps
  belongs_to :user

  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: :all_blank

  def belongs_to_user?
    self.user_id == current_user.id
  end
end
