require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:municipality) { municipalities(:port_chester) }
  let(:ticket) { described_class.new }

  describe "validations" do
    subject { ticket }

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
    # it { should have(1).errors_on(:violation_id) }
    # end

    # context "with a state" do
    # before { municipality.state = 'New York' }
    # it { should have(:no).errors_on(:state) }
    # end

    # context "without a state" do
    # it { should have(1).errors_on(:state) }
    # end

    # context "with a city" do
    # before { municipality.city = 'Port Chester' }
    # it { should have(:no).errors_on(:city) }
    # end

    # context "without a city" do
    # it { should have(1).errors_on(:city) }
    # end
  end
end

