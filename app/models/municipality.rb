class Municipality < ApplicationRecord
  validates :name, :state, :city, presence: true 
  has_many :tickets
end
