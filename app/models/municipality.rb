class Municipality < ApplicationRecord
  validates :name, :state, :city, presence: true 
end
