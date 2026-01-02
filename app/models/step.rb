class Step < ApplicationRecord
  belongs_to :recipe
  has_many_attached :step_images, dependent: :destroy

  enum :duration_unit, { minutes: "minutes", hours: "hours", days: "days" }
end
