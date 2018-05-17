require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:user) { users(:admin) }
  let(:municipality) { municipalities(:port_chester) }
  let(:ticket) { described_class.new }

  describe "validations" do
    subject { ticket }

    context "with a user id" do
      before { ticket.user_id = user.id }
      it { should have(:no).errors_on(:user_id) }
    end

    context "without a user id" do
      before { expect(ticket.user_id).to be_nil }
      it { should have(1).errors_on(:user_id) }
    end

    context "with a municipality id" do
      before { ticket.municipality_id = municipality.id }
      it { should have(:no).errors_on(:municipality_id) }
    end

    context "without a municipality id" do
      before { expect(ticket.municipality_id).to be_nil }
      it { should have(1).errors_on(:municipality_id) }
    end

    context "with a violation id" do
      before { ticket.violation_id = 223423 }
      it { should have(:no).errors_on(:violation_id) }
    end

    context "without a violation id" do
      before { expect(ticket.violation_id).to be_nil }
      it { should have(1).errors_on(:violation_id) }
    end

    context "with an amount" do
      before { ticket.amount = 2323 }
      it { should have(:no).errors_on(:amount) }
    end

    context "without an amount" do
      before { expect(ticket.amount).to be_nil }
      it { should have(1).errors_on(:amount) }
    end
  end
end

