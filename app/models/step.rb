class Step < ApplicationRecord
  before_save :duration_unit_display
  belongs_to :recipe
  has_many_attached :step_images, dependent: :destroy

    validates :step_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :instruction, presence: true

  enum :duration_unit, { minutes: "minutes", hours: "hours", days: "days", not_applicable: "not_applicable" }

  def duration_unit_display
    self.duration_unit.presence || "N/A"
  end
end
