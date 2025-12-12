class Step < ApplicationRecord
  belongs_to :recipe
  enum duration_unit: { minutes: "minutes", hours: "hours", days: "days" }
end
