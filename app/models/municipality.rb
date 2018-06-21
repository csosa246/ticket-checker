class Municipality < ApplicationRecord
  validates :name, :state, :city, presence: true
  has_many :violations

  def klass
    self.name.gsub(/\s+/, "")
  end

end

