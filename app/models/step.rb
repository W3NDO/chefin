class Step < ApplicationRecord
  belongs_to :recipe

  enum :duration_unit, [ :minutes, :hours, :days ]
end
