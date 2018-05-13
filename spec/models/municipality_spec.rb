require 'rails_helper'

RSpec.describe Municipality, type: :model do
  let(:municipality) { described_class.new }

  describe "validations" do
    subject { municipality }

    context "with a name" do
      before { municipality.name = 'Port Chester' }
      it { should have(:no).errors_on(:name) }
    end

    context "with no name" do
      it { should have(1).errors_on(:name) }
    end

    context "with a state" do
      before { municipality.state = 'New York' }
      it { should have(:no).errors_on(:state) }
    end

    context "without a state" do
      it { should have(1).errors_on(:state) }
    end
    
    context "with a city" do
      before { municipality.city = 'Port Chester' }
      it { should have(:no).errors_on(:city) }
    end

    context "without a city" do
      it { should have(1).errors_on(:city) }
    end
    
  end


end
