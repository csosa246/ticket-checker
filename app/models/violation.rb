class Violation < ApplicationRecord
  validates :user_id, :municipality_id, :violation_id, :amount, presence: true
  belongs_to :municipality
end

