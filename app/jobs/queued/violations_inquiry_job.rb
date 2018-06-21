class Queued::ViolationsInquiryJob < ApplicationJob
  queue_as :auxiliary

  def perform(user)

    Municipality.all.each do |municipality|
      inquiry = violations_inquiry_klass(municipality).new
    end

  end

  private

  def violations_inquiry_klass(municipality)
    "Municipality::#{municipality.klass)}::Violations::Inquiry".constantize
  end

end

