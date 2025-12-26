class Recipe < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :ingredients
  has_many :steps
end
