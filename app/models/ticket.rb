class Ticket < ApplicationRecord
  validates :municipality_id, :violation_id, :amount, presence: true
  belongs_to :municipality

  def enqueue_ticket_scan

  end
  
end
