require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { described_class.new }

  describe "validations" do
    subject { user }

    context "when the email is valid" do
      before { user.email = "crae.sosa@gmail.com" }

      it { should have(:no).errors_on(:email) }
    end

    context "when the email is invalid" do
      context "when the email is empty" do
        before { user.email = '' }
        it { should have(1).errors_on(:email) }
      end

      context "when the email is nil" do
        before { user.email = nil }
        it { should have(1).errors_on(:email) }
      end

      context "when the email is not formatted properly" do
        before { user.email = 'blah' }
        it { should have(1).errors_on(:email) }
      end

      context "when the email is not unique" do
        before { user.email = users(:admin).email }
        it { should have(1).errors_on(:email) }
      end
    end

    context "when the license_plate is valid" do
      before { user.license_plate = "111-1111" }
      it { should have(:no).errors_on(:license_plate) }
    end

    context "when the license_plate is invalid" do
      context "when the license plate is empty" do
        before { user.license_plate = '' }
        it { should have(1).errors_on(:license_plate) }
      end

      context "when the license plate is nil" do
        before { user.license_plate = nil }
        it { should have(1).errors_on(:license_plate) }
      end

      context "when the combination of license plate and state is not unique" do
        let(:other_user) { users(:admin) }
        before do
          user.license_plate = other_user.license_plate
          user.state = other_user.state
        end
        it { should have(1).errors_on(:license_plate) }
      end
    end
  end

  describe "on create" do
    subject { -> { user.run_callbacks(:create) } }
    it { should change(user, :authentication_token).to be }
  end
end

