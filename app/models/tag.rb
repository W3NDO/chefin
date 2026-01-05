class Tag < ApplicationRecord
  extend FriendlyId
  friendly_id :tag_name, use: :slugged

  before_save :downcase_tag_name

  has_and_belongs_to_many :recipes

  validates :tag_name, uniqueness: true, presence: true

  def downcase_tag_name
    self.tag_name.downcase!
  end

  def humanize_tag_name
    self.tag_name.gsub("-", " ").humanize
  end
end
